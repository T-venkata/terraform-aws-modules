resource "aws_instance" "name" {
  ami               = ""
  instance_type     = ""
  key_name          = ""
  availability_zone = ""
  #vpc_security_group_ids = [""]
  tags = {
    Name = "state-remote-backend"
  }

}

terraform {
  backend "s3" {
    bucket         = ""
    key            = "terraform.tfstate"
    region         = ""
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

