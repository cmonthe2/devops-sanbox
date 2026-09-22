variable "create" {
  description = "Master switch. Set false to create no resources (avoids ~$18/mo ALB cost in dev)."
  type        = bool
  default     = false
}

variable "name" {
  description = "Name prefix for all ALB resources."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to deploy the ALB into."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to attach the ALB to. Needs at least 2 AZs."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "ALB requires at least 2 public subnets in different AZs."
  }
}

variable "internal" {
  description = "If true, creates an internal (private) ALB instead of internet-facing."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection on the ALB. Recommended for production."
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "ALB idle connection timeout in seconds."
  type        = number
  default     = 60
}

variable "container_port" {
  description = "Port the ECS container listens on. Used for target group and health checks."
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "HTTP path for ALB target group health checks."
  type        = string
  default     = "/health"
}

variable "certificate_arn" {
  description = "ACM certificate ARN for the HTTPS listener. Leave empty to use HTTP only (dev/test)."
  type        = string
  default     = ""
}
