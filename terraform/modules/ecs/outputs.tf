output "ecr_repository_url" {
  description = "ECR repository URL. Use this in your docker push and task definition image field."
  value       = aws_ecr_repository.this.repository_url
}

output "ecr_repository_name" {
  description = "ECR repository name."
  value       = aws_ecr_repository.this.name
}

output "cluster_id" {
  description = "ECS cluster ID."
  value       = aws_ecs_cluster.this.id
}

output "cluster_name" {
  description = "ECS cluster name."
  value       = aws_ecs_cluster.this.name
}

output "service_name" {
  description = "ECS service name. Empty string when create = false."
  value       = var.create ? aws_ecs_service.this[0].name : ""
}

output "task_definition_arn" {
  description = "ARN of the active task definition. Empty string when create = false."
  value       = var.create ? aws_ecs_task_definition.this[0].arn : ""
}

output "execution_role_arn" {
  description = "ARN of the ECS task execution IAM role."
  value       = aws_iam_role.execution.arn
}

output "task_role_arn" {
  description = "ARN of the ECS task IAM role (runtime permissions)."
  value       = aws_iam_role.task.arn
}

output "task_security_group_id" {
  description = "Security group ID attached to ECS tasks. Empty string when create = false."
  value       = var.create ? aws_security_group.tasks[0].id : ""
}

output "log_group_name" {
  description = "CloudWatch log group name for container stdout/stderr."
  value       = aws_cloudwatch_log_group.ecs.name
}
