variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0d682f26195e9ec0f"
}

variable "instance_name" {
  description = "Tag for EC2 instance name"
  type        = string
  default     = "venkat"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "my-keypair"
}
