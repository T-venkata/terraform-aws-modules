provider "aws" {
  region = "us-east-1"
}


provider "aws" {
    region = "ap-south-1"
    alias = "provider2"
  
}
resource "aws_s3_bucket" "provider-1" {
    bucket = "ancdefghi"
    provider = aws.provider2   # s3 bucket will create into "ap-south-1"
  
}

resource "aws_instance" "name" {
    ami = ""
    instance_type = "t2.micro"
    key_name = "ec2test"
    availability_zone = "us-east-1a"
    tags = {
      Name = "dev"
    }
   
  
}



# same resource into two different regions 
# provider "aws" {
#   region = "us-east-1"
# }

# provider "aws" {
#   region = "ap-south-1"
#   alias  = "mumbai"
# }

# variable "regions" {
#   type = map(object({
#     ami             = string
#     availability_zone = string
#   }))
#   default = {
#     "us-east-1"  = { ami = "ami-085ad6ae776d8f09c", availability_zone = "us-east-1a" }
#     "ap-south-1" = { ami = "ami-05169c5e5bfb48fb4", availability_zone = "ap-south-1a" }
#   }
# }

# resource "aws_instance" "multi_region" {
#   for_each = var.regions

#   ami             = each.value.ami
#   instance_type   = "t2.micro"
#   key_name        = "ec2test"
#   availability_zone = each.value.availability_zone

#   provider = each.key == "us-east-1" ? aws : aws.mumbai

#   tags = {
#     Name = "dev-${each.key}"
#   }
# }
