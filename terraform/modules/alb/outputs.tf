output "alb_id" {
  description = "ID of the ALB. Empty string when create = false."
  value       = var.create ? aws_lb.this[0].id : ""
}

output "alb_arn" {
  description = "ARN of the ALB. Empty string when create = false."
  value       = var.create ? aws_lb.this[0].arn : ""
}

output "alb_dns_name" {
  description = "DNS name of the ALB. Point your CNAME/alias record here."
  value       = var.create ? aws_lb.this[0].dns_name : ""
}

output "alb_zone_id" {
  description = "Hosted zone ID of the ALB. Used for Route 53 alias records."
  value       = var.create ? aws_lb.this[0].zone_id : ""
}

output "target_group_arn" {
  description = "ARN of the target group. Pass this to the ECS service."
  value       = var.create ? aws_lb_target_group.this[0].arn : ""
}

output "security_group_id" {
  description = "ID of the ALB security group. Allow inbound from this SG on ECS task security groups."
  value       = var.create ? aws_security_group.alb[0].id : ""
}

output "http_listener_arn" {
  description = "ARN of the HTTP listener (redirect or forward depending on certificate_arn)."
  value = var.create ? (
    var.certificate_arn != "" ? aws_lb_listener.http[0].arn : aws_lb_listener.http_forward[0].arn
  ) : ""
}

output "https_listener_arn" {
  description = "ARN of the HTTPS listener. Empty when no certificate_arn is provided."
  value       = var.create && var.certificate_arn != "" ? aws_lb_listener.https[0].arn : ""
}
