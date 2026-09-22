###############################################################################
# Root variables
###############################################################################

variable "name" {
  description = "Name prefix applied to all resources. Used to namespace resources across environments."
  type        = string
  default     = "devops-sandbox"
}

variable "aws_region" {
  description = "AWS region to deploy resources into."
  type        = string
  default     = "us-east-1"
}

# ── VPC ───────────────────────────────────────────────────────────────────────

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones to deploy into. Must have at least 2."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (ALB, NAT GW). One per AZ."
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (ECS tasks, RDS). One per AZ."
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "enable_nat_gateway" {
  description = "Create NAT Gateways for private subnet egress. Set false in dev to avoid NAT costs (~$35/mo per AZ)."
  type        = bool
  default     = false
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs to CloudWatch."
  type        = bool
  default     = true
}

variable "flow_logs_retention_days" {
  description = "Retention period in days for VPC flow log CloudWatch log group."
  type        = number
  default     = 30
}

# ── ALB ───────────────────────────────────────────────────────────────────────

variable "create_alb" {
  description = "Whether to create the Application Load Balancer. Set false to avoid ~$18/mo ALB cost during development."
  type        = bool
  default     = false
}

variable "alb_internal" {
  description = "If true, the ALB is internal (not internet-facing). Useful for internal services."
  type        = bool
  default     = false
}

variable "alb_deletion_protection" {
  description = "Enable deletion protection on the ALB. Recommended true for production."
  type        = bool
  default     = false
}

variable "alb_idle_timeout" {
  description = "Idle timeout in seconds for the ALB."
  type        = number
  default     = 60
}

variable "health_check_path" {
  description = "HTTP path the ALB target group uses for health checks."
  type        = string
  default     = "/health"
}

variable "container_port" {
  description = "Port the application container listens on."
  type        = number
  default     = 8080
}

# ── ECS ───────────────────────────────────────────────────────────────────────

variable "create_ecs" {
  description = "Create ECS service and task definition. ECR repo and cluster are always created (free). Set true to run Fargate tasks (~$3-6/mo minimum)."
  type        = bool
  default     = false
}

variable "ecs_task_cpu" {
  description = "Fargate task CPU units. 256 = 0.25 vCPU (minimum, cheapest)."
  type        = number
  default     = 256
}

variable "ecs_task_memory" {
  description = "Fargate task memory in MB. 512 is the minimum for 256 CPU."
  type        = number
  default     = 512
}

variable "ecs_desired_count" {
  description = "Number of Fargate task instances. Set 0 to stop all tasks without destroying the service."
  type        = number
  default     = 1
}

variable "ecs_image_tag" {
  description = "ECR image tag to deploy on the ECS service."
  type        = string
  default     = "latest"
}

variable "ecs_environment_variables" {
  description = "Environment variables passed to the container at runtime."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "enable_container_insights" {
  description = "Enable ECS Container Insights metrics. Costs ~$0.35/GB ingested."
  type        = bool
  default     = false
}

variable "ecs_log_retention_days" {
  description = "Days to retain ECS container logs in CloudWatch. Keep low to reduce cost."
  type        = number
  default     = 7
}

# ── RDS ───────────────────────────────────────────────────────────────────────

variable "create_rds" {
  description = "Create Aurora Serverless v2 cluster. Subnet group and security group are always created (free). With min_capacity=0 the cluster auto-pauses when idle (~$0)."
  type        = bool
  default     = false
}

variable "rds_engine_version" {
  description = "Aurora PostgreSQL engine version."
  type        = string
  default     = "16.3"
}

variable "rds_database_name" {
  description = "Name of the initial database in the Aurora cluster."
  type        = string
  default     = "app"
}

variable "rds_master_username" {
  description = "Master username for the Aurora cluster."
  type        = string
  default     = "dbadmin"
}

variable "rds_min_capacity" {
  description = "Minimum Aurora Capacity Units. 0 enables auto-pause (free when idle)."
  type        = number
  default     = 0
}

variable "rds_max_capacity" {
  description = "Maximum Aurora Capacity Units. Keep at 1 in dev to cap cost."
  type        = number
  default     = 1
}

variable "rds_seconds_until_auto_pause" {
  description = "Seconds of inactivity before Aurora auto-pauses. Only applies when min_capacity = 0."
  type        = number
  default     = 300
}

variable "rds_backup_retention_days" {
  description = "Days to retain automated Aurora backups."
  type        = number
  default     = 1
}

variable "rds_skip_final_snapshot" {
  description = "Skip final snapshot on cluster deletion. Keep true in dev."
  type        = bool
  default     = true
}

variable "rds_deletion_protection" {
  description = "Enable deletion protection on the Aurora cluster."
  type        = bool
  default     = false
}

variable "rds_enable_performance_insights" {
  description = "Enable RDS Performance Insights (free for 7-day retention)."
  type        = bool
  default     = false
}

variable "rds_log_retention_days" {
  description = "Days to retain Aurora logs in CloudWatch."
  type        = number
  default     = 7
}

variable "rds_secret_recovery_window_days" {
  description = "Days before a deleted Secrets Manager secret is permanently removed. 0 = immediate."
  type        = number
  default     = 0
}
