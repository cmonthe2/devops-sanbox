###############################################################################
# Root outputs
# These bubble up key values from child modules so they are visible after
# `terraform apply` and can be consumed by external systems or other roots.
###############################################################################

# ── VPC ───────────────────────────────────────────────────────────────────────

output "vpc_id" {
  description = "ID of the VPC."
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC."
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs of the public subnets (ALB tier)."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets (ECS / RDS tier)."
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_public_ips" {
  description = "Public IPs of the NAT Gateways. Allowlist these in external firewalls if needed."
  value       = module.vpc.nat_gateway_public_ips
}

output "flow_log_group_name" {
  description = "CloudWatch log group capturing VPC flow logs."
  value       = module.vpc.flow_log_group_name
}

# ── ALB ───────────────────────────────────────────────────────────────────────

output "alb_dns_name" {
  description = "DNS name of the ALB. Empty when create_alb = false."
  value       = module.alb.alb_dns_name
}

output "alb_target_group_arn" {
  description = "ARN of the ALB target group. Passed to the ECS service."
  value       = module.alb.target_group_arn
}

output "alb_security_group_id" {
  description = "Security group ID of the ALB. ECS task SG should allow inbound from this."
  value       = module.alb.security_group_id
}

# ── ECS ───────────────────────────────────────────────────────────────────────

output "ecr_repository_url" {
  description = "ECR repository URL. Use in docker push and CI/CD pipeline."
  value       = module.ecs.ecr_repository_url
}

output "ecs_cluster_name" {
  description = "ECS cluster name."
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "ECS service name. Empty when create_ecs = false."
  value       = module.ecs.service_name
}

output "ecs_log_group_name" {
  description = "CloudWatch log group for ECS container stdout/stderr."
  value       = module.ecs.log_group_name
}

output "ecs_task_security_group_id" {
  description = "Security group ID attached to ECS tasks."
  value       = module.ecs.task_security_group_id
}

# ── RDS ───────────────────────────────────────────────────────────────────────

output "rds_cluster_endpoint" {
  description = "Aurora writer endpoint. Use for read/write DB connections."
  value       = module.rds.cluster_endpoint
}

output "rds_cluster_reader_endpoint" {
  description = "Aurora reader endpoint. Use for read-only DB connections."
  value       = module.rds.cluster_reader_endpoint
}

output "rds_secret_arn" {
  description = "Secrets Manager ARN holding DB credentials. Pass to ECS task definition."
  value       = module.rds.secret_arn
}

output "rds_secret_name" {
  description = "Secrets Manager secret name for DB credentials."
  value       = module.rds.secret_name
}

output "rds_security_group_id" {
  description = "Security group ID of the RDS cluster."
  value       = module.rds.security_group_id
}

output "rds_log_group_name" {
  description = "CloudWatch log group for Aurora PostgreSQL logs."
  value       = module.rds.log_group_name
}
