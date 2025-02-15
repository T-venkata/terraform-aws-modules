resource "aws_instance" "name" {
  ami                    = "ami-0ddfba243cbee3768"
  instance_type          = "t2.micro"
  key_name               = "my-keypair"
  availability_zone      = "ap-south-1a"
  #vpc_security_group_ids = ["sg-05dc17f8ea75a20e2"]
  tags = {
    Name = "statefile"
  }
}

resource "aws_s3_bucket" "bucket" {
    bucket = "terraform-state-backeend-15-2"
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