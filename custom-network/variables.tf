variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = ""
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = ""
}

variable "availability_zone_public" {
  description = "Availability zone for the public subnet"
  type        = string
  default     = ""
}

variable "availability_zone_private" {
  description = "Availability zone for the private subnet"
  type        = string
  default     = ""
}

variable "instance_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "SSH key pair for the EC2 instance"
  type        = string
  default     = ""
}
