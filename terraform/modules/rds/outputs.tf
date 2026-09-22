output "cluster_endpoint" {
  description = "Writer endpoint of the Aurora cluster. Use this for read/write connections."
  value       = var.create ? aws_rds_cluster.this[0].endpoint : ""
}

output "cluster_reader_endpoint" {
  description = "Reader endpoint of the Aurora cluster. Use this for read-only connections."
  value       = var.create ? aws_rds_cluster.this[0].reader_endpoint : ""
}

output "cluster_identifier" {
  description = "Identifier of the Aurora cluster."
  value       = var.create ? aws_rds_cluster.this[0].cluster_identifier : ""
}

output "cluster_port" {
  description = "Port the Aurora cluster listens on (5432 for PostgreSQL)."
  value       = var.create ? aws_rds_cluster.this[0].port : 5432
}

output "database_name" {
  description = "Name of the initial database."
  value       = var.database_name
}

output "master_username" {
  description = "Master DB username."
  value       = var.master_username
}

output "secret_arn" {
  description = "ARN of the Secrets Manager secret holding DB credentials. Pass this to ECS tasks."
  value       = var.create ? aws_secretsmanager_secret.db[0].arn : ""
}

output "secret_name" {
  description = "Name of the Secrets Manager secret."
  value       = var.create ? aws_secretsmanager_secret.db[0].name : ""
}

output "security_group_id" {
  description = "Security group ID attached to the RDS cluster."
  value       = aws_security_group.rds.id
}

output "subnet_group_name" {
  description = "Name of the DB subnet group."
  value       = aws_db_subnet_group.this.name
}

output "log_group_name" {
  description = "CloudWatch log group for Aurora PostgreSQL logs. Empty when create = false."
  value       = var.create ? aws_cloudwatch_log_group.rds[0].name : ""
}
