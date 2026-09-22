###############################################################################
# Root Module — devops-sandbox platform
#
# This file wires together all child modules. As new modules are added
# (observability), add them here and pass VPC/ALB/ECS/RDS outputs down.
#
# Cost flags (all default to false / off):
#   enable_nat_gateway        — NAT GW (~$35/mo per AZ)
#   create_alb                — ALB (~$18/mo)
#   create_ecs                — ECS service + task (~$3–6/mo for min Fargate)
#   create_rds                — Aurora Serverless v2 (~$0 when paused, ~$44/mo always-on)
#   enable_container_insights — Container Insights (~$0.35/GB)
#
# ECR repo and ECS cluster are always created — both are free at rest.
# RDS subnet group + security group are always created — both free at rest.
###############################################################################

module "vpc" {
  source = "./modules/vpc"

  name                     = var.name
  vpc_cidr                 = var.vpc_cidr
  availability_zones       = var.availability_zones
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_subnet_cidrs     = var.private_subnet_cidrs
  enable_nat_gateway       = var.enable_nat_gateway
  enable_flow_logs         = var.enable_flow_logs
  flow_logs_retention_days = var.flow_logs_retention_days
}

module "alb" {
  source = "./modules/alb"

  # Set create_alb = true in terraform.tfvars when you're ready to test (~$18/mo)
  create = var.create_alb

  name              = var.name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids

  internal            = var.alb_internal
  deletion_protection = var.alb_deletion_protection
  idle_timeout        = var.alb_idle_timeout
  container_port      = var.container_port
  health_check_path   = var.health_check_path

  # Leave empty to use HTTP-only (no TLS cost, good for dev).
  # Set to an ACM certificate ARN to enable HTTPS.
  certificate_arn = ""
}

module "ecs" {
  source = "./modules/ecs"

  # ECR repo + cluster always created (free). Set create_ecs = true to also
  # create the task definition and service (~$3–6/mo for min Fargate sizing).
  create = var.create_ecs

  name               = var.name
  aws_region         = var.aws_region
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  # Wire ALB outputs — empty strings when ALB is disabled (safe, handled in module)
  alb_security_group_id = module.alb.security_group_id
  target_group_arn      = module.alb.target_group_arn

  # Fargate sizing — minimum to keep costs low
  task_cpu    = var.ecs_task_cpu
  task_memory = var.ecs_task_memory

  # Set desired_count = 0 to stop tasks without destroying the service
  desired_count = var.ecs_desired_count

  # When NAT GW is off, tasks need a public IP to reach ECR/internet
  assign_public_ip = !var.enable_nat_gateway

  container_port    = var.container_port
  health_check_path = var.health_check_path
  image_tag         = var.ecs_image_tag

  environment_variables     = var.ecs_environment_variables
  enable_container_insights = var.enable_container_insights
  log_retention_days        = var.ecs_log_retention_days
}

module "rds" {
  source = "./modules/rds"

  # DB subnet group + security group always created (free).
  # Set create_rds = true to spin up the Aurora cluster (~$0 when paused with min_capacity=0).
  create = var.create_rds

  name               = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  # Only allow inbound from ECS tasks — empty list when ECS is disabled (safe)
  allowed_security_group_ids = compact([module.ecs.task_security_group_id])

  # Aurora engine
  engine_version  = var.rds_engine_version
  database_name   = var.rds_database_name
  master_username = var.rds_master_username

  # Serverless v2 scaling — min=0 enables auto-pause (free when idle)
  min_capacity             = var.rds_min_capacity
  max_capacity             = var.rds_max_capacity
  seconds_until_auto_pause = var.rds_seconds_until_auto_pause

  # Backup & safety
  backup_retention_days = var.rds_backup_retention_days
  skip_final_snapshot   = var.rds_skip_final_snapshot
  deletion_protection   = var.rds_deletion_protection

  # Observability
  enable_performance_insights = var.rds_enable_performance_insights
  log_retention_days          = var.rds_log_retention_days
  secret_recovery_window_days = var.rds_secret_recovery_window_days
}
