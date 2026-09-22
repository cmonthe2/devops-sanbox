###############################################################################
# ALB Module
#
# Creates an Application Load Balancer with:
#   - HTTP listener (port 80) that redirects to HTTPS
#   - HTTPS listener (port 443) forwarding to the target group
#   - Target group for ECS Fargate tasks (IP target type)
#   - Security group allowing inbound 80/443 from anywhere
#
# The entire module is gated behind var.create — set it to false (the default)
# to skip all resources and avoid the ~$18/mo ALB cost during development.
###############################################################################

###############################################################################
# Security Group — allow HTTP + HTTPS inbound, all egress
###############################################################################
resource "aws_security_group" "alb" {
  count = var.create ? 1 : 0

  name        = "${var.name}-alb-sg"
  description = "Allow HTTP/HTTPS inbound to the ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-alb-sg"
  }
}

###############################################################################
# Application Load Balancer
###############################################################################
resource "aws_lb" "this" {
  count = var.create ? 1 : 0

  name               = "${var.name}-alb"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb[0].id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = var.deletion_protection
  idle_timeout               = var.idle_timeout

  # Access logs require an S3 bucket — wired in by the observability module later
  # access_logs { bucket = "..." enabled = true }

  tags = {
    Name = "${var.name}-alb"
  }
}

###############################################################################
# Target Group — IP type for ECS Fargate
###############################################################################
resource "aws_lb_target_group" "this" {
  count = var.create ? 1 : 0

  name        = "${var.name}-tg"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip" # Required for Fargate

  health_check {
    enabled             = true
    path                = var.health_check_path
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200-299"
  }

  # Allow in-place replacements without name conflicts
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.name}-tg"
  }
}

###############################################################################
# HTTP Listener — redirect 80 → 443
###############################################################################
resource "aws_lb_listener" "http" {
  count = var.create ? 1 : 0

  load_balancer_arn = aws_lb.this[0].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

###############################################################################
# HTTPS Listener — forward to target group
# NOTE: Requires an ACM certificate ARN. If var.certificate_arn is empty the
#       HTTPS listener is skipped and only the HTTP→HTTPS redirect is created.
#       For local testing you can hit the ALB on port 80 directly.
###############################################################################
resource "aws_lb_listener" "https" {
  count = var.create && var.certificate_arn != "" ? 1 : 0

  load_balancer_arn = aws_lb.this[0].arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[0].arn
  }
}

###############################################################################
# HTTP-only fallback listener (port 80 forward) — used when no cert is provided
# so the target group can still be tested end-to-end without TLS.
###############################################################################
resource "aws_lb_listener" "http_forward" {
  count = var.create && var.certificate_arn == "" ? 1 : 0

  load_balancer_arn = aws_lb.this[0].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[0].arn
  }
}
