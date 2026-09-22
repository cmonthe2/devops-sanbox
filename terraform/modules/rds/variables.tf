variable "create" {
  description = "Master switch. Set false to skip all RDS resources. Subnet group and security group are always created (free)."
  type        = bool
  default     = false
}

variable "name" {
  description = "Name prefix for all RDS resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to deploy the RDS cluster into."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the DB subnet group. Needs at least 2 AZs."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "Aurora requires a subnet group with subnets in at least 2 AZs."
  }
}

variable "allowed_security_group_ids" {
  description = "Security group IDs allowed to connect to RDS on port 5432 (typically the ECS task SG)."
  type        = list(string)
  default     = []
}

# ── Aurora engine ─────────────────────────────────────────────────────────────

variable "engine_version" {
  description = "Aurora PostgreSQL engine version."
  type        = string
  default     = "16.3"
}

variable "database_name" {
  description = "Name of the initial database created in the cluster."
  type        = string
  default     = "app"
}

variable "master_username" {
  description = "Master DB username. Avoid 'admin' or 'postgres' — they are reserved."
  type        = string
  default     = "dbadmin"
}

# ── Serverless v2 scaling ─────────────────────────────────────────────────────
# 1 ACU ≈ 2 GB RAM. Min 0.5 ACU ≈ $0.06/hr. Min 0 allows auto-pause (free when idle).
# Auto-pause is only available in single-AZ dev clusters.

variable "min_capacity" {
  description = "Minimum Aurora Capacity Units (ACU). Set 0 to enable auto-pause (cluster pauses when idle)."
  type        = number
  default     = 0

  validation {
    condition     = var.min_capacity >= 0 && var.min_capacity <= 256
    error_message = "min_capacity must be between 0 and 256 ACU."
  }
}

variable "max_capacity" {
  description = "Maximum Aurora Capacity Units (ACU). Keep low in dev to cap costs."
  type        = number
  default     = 1

  validation {
    condition     = var.max_capacity >= 0.5 && var.max_capacity <= 256
    error_message = "max_capacity must be between 0.5 and 256 ACU."
  }
}

variable "seconds_until_auto_pause" {
  description = "Seconds of inactivity before the cluster auto-pauses. Only applies when min_capacity = 0."
  type        = number
  default     = 300 # 5 minutes
}

# ── Backup & maintenance ──────────────────────────────────────────────────────

variable "backup_retention_days" {
  description = "Number of days to retain automated backups. Minimum 1."
  type        = number
  default     = 1

  validation {
    condition     = var.backup_retention_days >= 1 && var.backup_retention_days <= 35
    error_message = "backup_retention_days must be between 1 and 35."
  }
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on cluster deletion. Set true for dev, false for production."
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Enable deletion protection on the cluster. Recommended true for production."
  type        = bool
  default     = false
}

# ── Observability ─────────────────────────────────────────────────────────────

variable "enable_performance_insights" {
  description = "Enable RDS Performance Insights. Free tier covers 7 days retention."
  type        = bool
  default     = false
}

variable "log_retention_days" {
  description = "Days to retain Aurora PostgreSQL logs in CloudWatch."
  type        = number
  default     = 7

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653], var.log_retention_days)
    error_message = "log_retention_days must be a valid CloudWatch log retention value."
  }
}

# ── Secrets Manager ───────────────────────────────────────────────────────────

variable "secret_recovery_window_days" {
  description = "Days before a deleted secret is permanently removed. Set 0 for immediate deletion in dev."
  type        = number
  default     = 0

  validation {
    condition     = var.secret_recovery_window_days == 0 || (var.secret_recovery_window_days >= 7 && var.secret_recovery_window_days <= 30)
    error_message = "secret_recovery_window_days must be 0 (immediate) or between 7 and 30."
  }
}
