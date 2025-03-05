variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "ap-south-1"
}

variable "aws_profile" {
  description = "The AWS CLI profile to use for authentication."
  type        = string
  default     = "venkat" # Replace with your profile name if not using the default profile
}
