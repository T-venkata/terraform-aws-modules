module "ec2_instance" {
  #source  = ""

  name = var.name

  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = true
  #vpc_security_group_ids = var.vpc_security_group_ids = 
  #subnet_id              = var.subnet_id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

provider "aws" {
  
}

