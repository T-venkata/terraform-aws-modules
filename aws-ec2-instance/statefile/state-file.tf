resource "aws_instance" "name" {
  ami                    = ""
  instance_type          = ""
  key_name               = ""
  availability_zone      = ""
  #vpc_security_group_ids = [""]
  tags = {
    Name = "statefile"
  }
}

resource "aws_s3_bucket" "bucket" {
    bucket = ""
    tags = {
        Name = "S3 Remote Terraform State Store"
    }
}

/*
  terraform {
    backend "s3" {
      bucket         = "terraform-state-backend"
      key            = "terraform/state.tfstate"
      region         = "ap-south-1"
      encrypt        = true
    }
  }
*/
