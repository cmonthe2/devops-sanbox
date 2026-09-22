variable "create" {
  description = "Master switch. Set false to skip the ECS service and task definition (cluster and ECR are always created)."
  type        = bool
  default     = false
}

variable "name" {
  description = "Name prefix for all ECS resources."
  type        = string
}

variable "aws_region" {
  description = "AWS region (used for CloudWatch log driver config)."
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID to deploy ECS tasks into."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS task network interfaces."
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID of the ALB. If set, ECS tasks only accept traffic from the ALB. Leave empty when ALB is disabled."
  type        = string
  default     = ""
}

variable "target_group_arn" {
  description = "ARN of the ALB target group to register the ECS service with. Leave empty when ALB is disabled."
  type        = string
  default     = ""
}

# ── Fargate sizing ────────────────────────────────────────────────────────────
# Valid Fargate CPU/memory combinations:
#   256  CPU → 512, 1024, 2048 MB
#   512  CPU → 1024–4096 MB
#   1024 CPU → 2048–8192 MB
# 256 vCPU / 512 MB ≈ $0.004/hr ≈ $3/mo running 24/7

variable "task_cpu" {
  description = "Fargate task CPU units (256 = 0.25 vCPU). Minimum for Fargate."
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Fargate task memory in MB."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of ECS task instances to run. Set 0 to stop all tasks without destroying the service."
  type        = number
  default     = 1
}

variable "assign_public_ip" {
  description = "Assign a public IP to Fargate tasks. Required when no NAT Gateway exists so tasks can reach ECR/internet."
  type        = bool
  default     = true
}

# ── Container ─────────────────────────────────────────────────────────────────

variable "image_tag" {
  description = "ECR image tag to deploy."
  type        = string
  default     = "latest"
}

variable "container_port" {
  description = "Port the application container listens on."
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "HTTP path for container-level health checks."
  type        = string
  default     = "/health"
}

variable "environment_variables" {
  description = "List of environment variable maps ({ name, value }) passed to the container."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

# ── Observability ─────────────────────────────────────────────────────────────

variable "enable_container_insights" {
  description = "Enable ECS Container Insights. Costs ~$0.35/GB of metrics/logs ingested."
  type        = bool
  default     = false
}

variable "log_retention_days" {
  description = "Days to retain ECS container logs in CloudWatch."
  type        = number
  default     = 7

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653], var.log_retention_days)
    error_message = "log_retention_days must be a valid CloudWatch log retention value."
  }
}
