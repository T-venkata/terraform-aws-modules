resource "aws_instance" "name" {
  ami               = "ami-0ddfba243cbee3768"
  instance_type     = "t2.micro"
  key_name          = "my-keypair"
  availability_zone = "ap-south-1a"
  #vpc_security_group_ids = ["sg-05dc17f8ea75a20e2"]
  tags = {
    Name = "state-remote-backend"
  }

}

terraform {
  backend "s3" {
    bucket         = "terraform-state-backeend-15-2"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform_state"
  }
}


resource "aws_dynamodb_table" "terraform-lock" {
  name           = "terraform_state"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB Terraform State Lock Table"
  }
}

