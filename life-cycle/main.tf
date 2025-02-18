provider "aws" {
  
}

resource "aws_instance" "import" {
  ami = "ami-0ddfba243cbee3768"
  instance_type = "t2.micro"
  key_name = "my-keypair"
  tags = {
    Name = "destroy"
  }

#Ensures a new EC2 instance is ready before terminating the old one.
 lifecycle {
    create_before_destroy = true  #create_before_destroy (Avoid Downtime)
  }
#Prevents Terraform from deleting an EC2 instance. If you try to delete the resource, Terraform will show an error.
#   lifecycle {
#     prevent_destroy = true       #prevent_destroy (Protect Important Resources)
#   }

#Prevents Terraform from managing specific attributes.
# Useful for values that change dynamically (e.g., instance_type, tags).
#Helps avoid conflicts with auto-scaling groups or external updates.
#   lifecycle {
#     ignore_changes = [tags,]    #ignore_changes (Ignore Specific Attribute Updates)
#   }

#Forces Terraform to recreate a resource when another resource changes.
# Useful when dependent resources must be recreated together.
#Use Case: If the security group is changed, the EC2 instance will be recreated.
#   lifecycle {
#     replace_triggered_by = [aws_security_group.web_sg]   #replace_triggered_by (Force Replacement on Dependency Change)
#   }
}




# create_before_destroy	    Prevents downtime	                                  Ensuring a new EC2 instance is running before deleting the old one
# prevent_destroy	        Protects important resources	                      Avoid accidental deletion of an S3 bucket or database
# ignore_changes	        Ignores specific attribute updates	                  Preventing Terraform from changing tags or instance_type
# replace_triggered_by	    Forces recreation when a dependency changes	          Rebuilding an EC2 instance if its security group changes


#  Best Practices
# ✔ Use prevent_destroy for critical resources like databases, S3 buckets.
# ✔ Use ignore_changes for attributes managed externally (e.g., auto-scaling).
# ✔ Use create_before_destroy to avoid downtime in production.