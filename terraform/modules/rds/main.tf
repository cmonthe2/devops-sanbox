###############################################################################
# RDS Module — Aurora Serverless v2 (PostgreSQL)
#
# Creates:
#   - Random password + Secrets Manager secret (always created)
#   - DB subnet group (always created, free)
#   - Security group for RDS (always created, free)
#   - Aurora Serverless v2 cluster + instance (gated behind var.create)
#
# Cost notes:
#   - Aurora Serverless v2 minimum: 0.5 ACU ≈ $0.06/hr ≈ ~$44/mo if always on
#   - It scales to 0 ACU when paused (cluster must have min_capacity = 0)
#   - Secrets Manager: $0.40/secret/month + $0.05 per 10k API calls
#   - Set create = false to skip all RDS resources ($0)
#   - Set min_capacity = 0 to allow Aurora to pause when idle (saves ~80%)
###############################################################################

###############################################################################
# Random password for the DB master user
###############################################################################
resource "random_password" "master" {
  count = var.create ? 1 : 0

  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

###############################################################################
# Secrets Manager — stores DB credentials, no plaintext in state
###############################################################################
resource "aws_secretsmanager_secret" "db" {
  count = var.create ? 1 : 0

  name                    = "${var.name}/rds/master-credentials"
  description             = "Master credentials for ${var.name} Aurora cluster"
  recovery_window_in_days = var.secret_recovery_window_days

  tags = {
    Name = "${var.name}-rds-credentials"
  }
}

resource "aws_secretsmanager_secret_version" "db" {
  count = var.create ? 1 : 0

  secret_id = aws_secretsmanager_secret.db[0].id
  secret_string = jsonencode({
    engine   = "aurora-postgresql"
    host     = aws_rds_cluster.this[0].endpoint
    port     = aws_rds_cluster.this[0].port
    dbname   = var.database_name
    username = var.master_username
    password = random_password.master[0].result
  })

  # Re-create secret version when the cluster endpoint changes
  depends_on = [aws_rds_cluster.this]
}

###############################################################################
# DB Subnet Group — always created (free), reusable across environments
###############################################################################
resource "aws_db_subnet_group" "this" {
  name        = "${var.name}-rds-subnet-group"
  description = "Subnet group for ${var.name} RDS cluster"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name = "${var.name}-rds-subnet-group"
  }
}

###############################################################################
# Security Group — RDS
# Only allows inbound on the Postgres port from the ECS task SG.
###############################################################################
resource "aws_security_group" "rds" {
  name        = "${var.name}-rds-sg"
  description = "Allow inbound PostgreSQL from ECS tasks only"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from ECS tasks"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = var.allowed_security_group_ids
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-rds-sg"
  }
}

###############################################################################
# Aurora Serverless v2 Cluster
###############################################################################
resource "aws_rds_cluster" "this" {
  count = var.create ? 1 : 0

  cluster_identifier = "${var.name}-cluster"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned" # Serverless v2 uses provisioned mode
  engine_version     = var.engine_version
  database_name      = var.database_name
  master_username    = var.master_username
  master_password    = random_password.master[0].result

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  # Serverless v2 scaling configuration
  serverlessv2_scaling_configuration {
    min_capacity             = var.min_capacity # 0 = pause when idle (saves cost)
    max_capacity             = var.max_capacity
    seconds_until_auto_pause = var.min_capacity == 0 ? var.seconds_until_auto_pause : null
  }

  # Storage
  storage_encrypted = true
  storage_type      = "aurora"

  # Backups
  backup_retention_period      = var.backup_retention_days
  preferred_backup_window      = "03:00-04:00"
  preferred_maintenance_window = "mon:04:00-mon:05:00"
  skip_final_snapshot          = var.skip_final_snapshot
  final_snapshot_identifier    = var.skip_final_snapshot ? null : "${var.name}-final-snapshot"

  # Logging
  enabled_cloudwatch_logs_exports = ["postgresql"]

  # Prevent accidental deletion
  deletion_protection = var.deletion_protection

  tags = {
    Name = "${var.name}-aurora-cluster"
  }
}

###############################################################################
# Aurora Serverless v2 Instance
# At least one instance is required for Serverless v2.
###############################################################################
resource "aws_rds_cluster_instance" "this" {
  count = var.create ? 1 : 0

  identifier         = "${var.name}-instance-1"
  cluster_identifier = aws_rds_cluster.this[0].id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.this[0].engine
  engine_version     = aws_rds_cluster.this[0].engine_version

  db_subnet_group_name       = aws_db_subnet_group.this.name
  publicly_accessible        = false
  auto_minor_version_upgrade = true

  performance_insights_enabled = var.enable_performance_insights

  tags = {
    Name = "${var.name}-aurora-instance-1"
  }
}

###############################################################################
# CloudWatch Log Group for Aurora PostgreSQL logs
###############################################################################
resource "aws_cloudwatch_log_group" "rds" {
  count = var.create ? 1 : 0

  name              = "/aws/rds/cluster/${var.name}-cluster/postgresql"
  retention_in_days = var.log_retention_days

  tags = {
    Name = "${var.name}-rds-logs"
  }
}
