provider "aws" {
  region = "us-east-1"
}

# Generate a secure password for RDS
resource "random_password" "db_password" {
  length  = 16
  special = true
}

# Subnet Group for RDS
resource "aws_db_subnet_group" "sub_grp" {
  name       = "mycutsubnet"
  subnet_ids = ["", ""]

  tags = {
    Name = "My DB subnet group"
  }
}

# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring" {
  name = "rds-monitoring-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}

# IAM Policy Attachment for RDS Monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# AWS RDS Instance
resource "aws_db_instance" "default" {
  allocated_storage       = 10
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = random_password.db_password.result # Secure password
  db_subnet_group_name    = aws_db_subnet_group.sub_grp.id
  parameter_group_name    = "default.mysql8.0"

  # Backups
  backup_retention_period  = 7
  backup_window            = "02:00-03:00"

  # Monitoring
  monitoring_interval      = 60
  monitoring_role_arn      = aws_iam_role.rds_monitoring.arn
  depends_on               = [aws_iam_role.rds_monitoring] # Ensure IAM role is created first

  # Performance Insights
  performance_insights_enabled          = true
  performance_insights_retention_period = 7

  # Maintenance
  maintenance_window = "sun:04:00-sun:05:00"

  # Security
  deletion_protection = true
  skip_final_snapshot = true
}
