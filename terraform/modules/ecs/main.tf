###############################################################################
# ECS Module
#
# Creates:
#   - ECR repository (always created — free until you push images)
#   - ECS Cluster with Container Insights
#   - IAM roles: task execution role + task role
#   - CloudWatch log group for container logs
#   - Security group for ECS tasks
#   - ECS Task Definition
#   - ECS Service (Fargate)
#
# Cost notes:
#   - ECR: free up to 500 MB/month private storage
#   - ECS cluster: free (you pay for the Fargate tasks that run in it)
#   - Fargate task (0.25 vCPU / 0.5 GB): ~$0.008/hr ≈ $6/mo if running 24/7
#   - Set desired_count = 0 to stop all tasks (cluster stays, no compute charge)
#   - Set create = false to skip the service + task def entirely
###############################################################################

###############################################################################
# ECR Repository — always created, no cost until images are pushed
###############################################################################
resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true # free vulnerability scanning
  }

  tags = {
    Name = var.name
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 tagged images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan"
          countNumber   = 10
        }
        action = { type = "expire" }
      },
      {
        rulePriority = 2
        description  = "Remove untagged images older than 7 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }
        action = { type = "expire" }
      }
    ]
  })
}

###############################################################################
# ECS Cluster — free, Container Insights costs ~$0.35/GB of log data
###############################################################################
resource "aws_ecs_cluster" "this" {
  name = "${var.name}-cluster"

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  tags = {
    Name = "${var.name}-cluster"
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name       = aws_ecs_cluster.this.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
    base              = 1
  }
}

###############################################################################
# CloudWatch Log Group for container stdout/stderr
###############################################################################
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.name}"
  retention_in_days = var.log_retention_days

  tags = {
    Name = "${var.name}-ecs-logs"
  }
}

###############################################################################
# IAM — Task Execution Role (used by ECS agent to pull images, push logs)
###############################################################################
data "aws_iam_policy_document" "ecs_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "execution" {
  name               = "${var.name}-ecs-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume.json

  tags = {
    Name = "${var.name}-ecs-execution-role"
  }
}

resource "aws_iam_role_policy_attachment" "execution_managed" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Allow execution role to read Secrets Manager secrets (for DB creds etc.)
resource "aws_iam_role_policy" "execution_secrets" {
  name = "${var.name}-ecs-execution-secrets"
  role = aws_iam_role.execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["secretsmanager:GetSecretValue"]
        Resource = ["arn:aws:secretsmanager:*:*:secret:${var.name}/*"]
      }
    ]
  })
}

###############################################################################
# IAM — Task Role (permissions the application code itself has at runtime)
###############################################################################
resource "aws_iam_role" "task" {
  name               = "${var.name}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume.json

  tags = {
    Name = "${var.name}-ecs-task-role"
  }
}

# Extend this policy as the app needs more AWS permissions (S3, SQS, etc.)
resource "aws_iam_role_policy" "task_baseline" {
  name = "${var.name}-ecs-task-baseline"
  role = aws_iam_role.task.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${aws_cloudwatch_log_group.ecs.arn}:*"
      }
    ]
  })
}

###############################################################################
# Security Group — ECS Tasks
# Allows inbound from ALB SG only; all egress for ECR/S3/Secrets pulls.
###############################################################################
resource "aws_security_group" "tasks" {
  count = var.create ? 1 : 0

  name        = "${var.name}-ecs-tasks-sg"
  description = "Allow inbound from ALB; allow all egress for ECR/Secrets pulls"
  vpc_id      = var.vpc_id

  # If ALB SG is provided, allow traffic only from it.
  # If not (e.g. ALB disabled), allow inbound on container_port for direct testing.
  dynamic "ingress" {
    for_each = var.alb_security_group_id != "" ? [1] : []
    content {
      description     = "From ALB"
      from_port       = var.container_port
      to_port         = var.container_port
      protocol        = "tcp"
      security_groups = [var.alb_security_group_id]
    }
  }

  dynamic "ingress" {
    for_each = var.alb_security_group_id == "" ? [1] : []
    content {
      description = "Direct access (no ALB)"
      from_port   = var.container_port
      to_port     = var.container_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-ecs-tasks-sg"
  }
}

###############################################################################
# Task Definition
###############################################################################
resource "aws_ecs_task_definition" "this" {
  count = var.create ? 1 : 0

  family                   = var.name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.execution.arn
  task_role_arn            = aws_iam_role.task.arn

  container_definitions = jsonencode([
    {
      name      = var.name
      image     = "${aws_ecr_repository.this.repository_url}:${var.image_tag}"
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]

      environment = var.environment_variables

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }

      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:${var.container_port}${var.health_check_path} || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 60
      }
    }
  ])

  tags = {
    Name = var.name
  }
}

###############################################################################
# ECS Service
###############################################################################
resource "aws_ecs_service" "this" {
  count = var.create ? 1 : 0

  name                               = "${var.name}-service"
  cluster                            = aws_ecs_cluster.this.id
  task_definition                    = aws_ecs_task_definition.this[0].arn
  desired_count                      = var.desired_count
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  health_check_grace_period_seconds  = var.target_group_arn != "" ? 60 : null

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.tasks[0].id]
    # assign_public_ip only needed if no NAT GW — lets tasks reach ECR/internet
    assign_public_ip = var.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = var.target_group_arn != "" ? [1] : []
    content {
      target_group_arn = var.target_group_arn
      container_name   = var.name
      container_port   = var.container_port
    }
  }

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  lifecycle {
    # Ignore task definition changes from outside Terraform (e.g. CI/CD image updates)
    ignore_changes = [task_definition, desired_count]
  }

  tags = {
    Name = "${var.name}-service"
  }
}
