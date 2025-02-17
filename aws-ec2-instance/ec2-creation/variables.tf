variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = ""
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = ""
}

variable "instance_name" {
  description = "Tag for EC2 instance name"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = ""
}
