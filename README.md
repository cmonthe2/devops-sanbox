# DevOps Sandbox

A production-ready AWS infrastructure platform built with Terraform, featuring a full CI/CD pipeline, security scanning, and cost-safe feature flags for development.

## Architecture

```
VPC (free)
├── Public Subnets      — ALB, NAT Gateways
└── Private Subnets     — ECS Fargate tasks, Aurora RDS
    ├── ALB             — Application Load Balancer (~$18/mo, off by default)
    ├── ECS             — Fargate cluster + ECR (~$3-6/mo, off by default)
    └── RDS             — Aurora Serverless v2 PostgreSQL (~$0 when paused, off by default)
```

## Modules

| Module | Description | Always Created | Cost When Enabled |
|--------|-------------|---------------|-------------------|
| `vpc` | VPC, subnets, IGW, NAT GW, route tables, flow logs | ✅ | $0 (NAT GW ~$35/mo/AZ) |
| `alb` | Application Load Balancer, target group, listeners | ❌ | ~$18/mo |
| `ecs` | ECR repo, ECS cluster, Fargate service, IAM roles | Cluster + ECR only | ~$3-6/mo |
| `rds` | Aurora Serverless v2 PostgreSQL, Secrets Manager | Subnet group + SG only | ~$0 when paused |

## CI/CD Pipeline

| Workflow | Trigger | Description |
|----------|---------|-------------|
| `pr-plan.yml` | Pull request to `main` | Terraform plan + tfsec security scan + TFLint + PR comment |
| `apply.yml` | Manual (`workflow_dispatch`) | Terraform apply |
| `destroy.yml` | Manual (`workflow_dispatch`) | Terraform destroy (requires typing "destroy" to confirm) |
| `release.yml` | Push to `main` | Semantic release — auto versioning + changelog |

## Prerequisites

- Terraform >= 1.10.0
- AWS provider >= 5.0
- AWS credentials configured (OIDC via GitHub Actions)
- Git + pre-commit

## Getting Started

1. Clone this repo
2. Copy the example vars file:
   ```bash
   cp terraform/terraform.tfvars.example terraform/terraform.tfvars
   ```
3. Update `terraform/providers.tf` with your S3 bucket and state key:
   ```hcl
   backend "s3" {
     bucket       = "your-tfstate-bucket"
     key          = "your-project/terraform.tfstate"
     region       = "us-east-1"
     use_lockfile = true
     encrypt      = true
   }
   ```
4. Initialize and plan:
   ```bash
   cd terraform
   terraform init
   terraform plan
   ```

## Cost-Safe Development

All billable resources are off by default. Enable them in `terraform.tfvars` only when needed:

```hcl
# Free tier — always safe
enable_nat_gateway = false   # saves ~$35/mo per AZ
create_alb         = false   # saves ~$18/mo
create_ecs         = false   # saves ~$3-6/mo
create_rds         = false   # saves ~$44/mo (free when paused with min_capacity=0)

# Turn on individually when testing
create_ecs = true            # spin up Fargate service
create_alb = true            # add load balancer
create_rds = true            # add Aurora (auto-pauses after 5min idle)
```

Set `ecs_desired_count = 0` to stop Fargate tasks without destroying the service.
Set `rds_min_capacity = 0` to allow Aurora to auto-pause when idle.

## GitHub Actions Setup

The workflows authenticate to AWS via OIDC — no long-lived credentials needed.

1. Add a repository secret:
   ```
   Settings → Secrets and variables → Actions → New repository secret
   Name:  AWS_ROLE_ARN
   Value: arn:aws:iam::<account-id>:role/<role-name>
   ```

2. Ensure your IAM role trust policy allows your GitHub repo:
   ```json
   {
     "Condition": {
       "StringEquals": {
         "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
       },
       "StringLike": {
         "token.actions.githubusercontent.com:sub": "repo:<org>@<id>/*:*"
       }
     }
   }
   ```

## Conventional Commits

This project uses semantic-release with conventional commits for automated versioning:

| Prefix | Effect |
|--------|--------|
| `feat:` | Minor version bump |
| `fix:` | Patch version bump |
| `perf:`, `refactor:` | Patch version bump |
| `docs:`, `chore:`, `test:` | No release |

## Pre-commit Hooks

```bash
pip install pre-commit
pre-commit install
```

Hooks run on every commit: `terraform fmt`, `terraform validate`, `terraform-docs`, `tflint`, trailing whitespace, YAML checks.

## Project Structure

```
.
├── .github/
│   └── workflows/
│       ├── pr-plan.yml       # Plan on PR
│       ├── apply.yml         # Manual apply
│       ├── destroy.yaml      # Manual destroy
│       └── release.yml       # Semantic release
├── terraform/
│   ├── providers.tf          # Backend + provider config
│   ├── main.tf               # Root module — wires all child modules
│   ├── variables.tf          # All input variables
│   ├── outputs.tf            # All root outputs
│   ├── terraform.tfvars.example
│   └── modules/
│       ├── vpc/              # VPC, subnets, IGW, NAT GW, flow logs
│       ├── alb/              # Application Load Balancer
│       ├── ecs/              # ECS Fargate + ECR
│       └── rds/              # Aurora Serverless v2 + Secrets Manager
├── .pre-commit-config.yaml
└── .releaserc.json
```

## License

See LICENSE file for details.
