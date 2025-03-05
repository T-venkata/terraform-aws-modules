provider "aws" {

}

# Create an S3 Bucket (ensure the bucket name is globally unique)
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-unique-s3-bucket-12345-2402" # Replace with a globally unique name
  #acl    = "private"

  tags = {
    Name = "MyS3Bucket-240225"
  }
}

# Create an EC2 Key Pair(Creates an AWS key pair resource that is later used by the EC2 instance for SSH access.)
resource "aws_key_pair" "example" {
  key_name   = "my-keypairr"                 # Replace with your desired key name,Specifies the name of the key pair in AWS (here, "my-keypairr").
  public_key = file("~/.ssh/id_ed25519.pub") # Loads your public SSH key from your local machine (using the file function) so that the corresponding private key (kept on your machine) can be used to connect to the EC2 instance.

}

# Define an IAM Policy for S3 Access using the created S3 bucket
#Creates an IAM policy that grants permissions to list the bucket, get objects, and put objects in a specific S3 bucket.
resource "aws_iam_policy" "s3_access_policy" {
  name        = "EC2S3AccessPolicy"
  description = "Policy for EC2 instances to access S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject", #Allows uploading objects to the bucket.
          "s3:GetObject", #Allows downloading objects from the bucket.
          "s3:ListBucket" #Allows listing the contents of the bucket.
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*"
        ]
      }
    ]
  })
}

# Create an IAM Role for EC2(Sets up an IAM role that EC2 instances can assume.)
resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_access_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole" #Allows EC2 instances (identified by the service principal "ec2.amazonaws.com") to assume this role.
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach the S3 Access Policy to the IAM Role(Binds the S3 access policy to the IAM role created for EC2.)
#This attachment allows EC2 instances that assume the role ec2_s3_access_role to perform S3 actions defined in the policy.
resource "aws_iam_role_policy_attachment" "ec2_role_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Create an IAM Instance Profile for the EC2 Role(An instance profile is required to attach an IAM role to an EC2 instance.)
#This profile is referenced when launching the EC2 instance to ensure it has S3 access permissions.

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_s3_access_instance_profile"
  role = aws_iam_role.ec2_role.name
}

# Create an EC2 Instance with the IAM Instance Profile attached
#Creates an EC2 instance configured to use the key pair, security group, and IAM instance profile for S3 access.
resource "aws_instance" "web_server" {
  ami                  = "ami-0d682f26195e9ec0f" # Update with a valid AMI ID for your region
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.example.key_name
  security_groups      = ["default"]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  availability_zone    = "ap-south-1a"

  tags = {
    Name = "null-resource"
  }
}

# Null resource to run remote commands on the EC2 instance(Uses a null_resource to run a series of remote commands on the EC2 instance once it is created.)

resource "null_resource" "setup_and_upload" {
  depends_on = [aws_instance.web_server] #ensures that the commands run only after the EC2 instance is fully provisioned.
  #Executes a series of commands on the remote EC2 instance:
  provisioner "remote-exec" {
    inline = [
      # Install Apache if not installed
      "sudo yum install -y httpd",

      # Starts Apache immediately and configures it to launch on boot.
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",

      # Ensure /var/www/html/ directory exists
      "sudo mkdir -p /var/www/html/",

      # Create a sample index.html file(Generates a simple HTML file (index.html) with a welcome message.)
      "echo '<h1>Welcome to Null resource block concept</h1>' | sudo tee /var/www/html/index.html",

      # Upload the file to the S3 bucket created above
      "aws s3 cp /var/www/html/index.html s3://${aws_s3_bucket.s3_bucket.bucket}/",
      "echo 'File uploaded to S3'"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"                        #Uses the default EC2 user (ec2-user for Amazon Linux).
    private_key = file("~/.ssh/id_ed25519")         #Reads your private SSH key from your local machine.
    host        = aws_instance.web_server.public_ip #Uses the public IP address of the EC2 instance.
  }
  # The triggers block includes instance_id = aws_instance.web_server.id to ensure that if the EC2 instance changes, the null resource will be re-provisioned (forcing the remote commands to run again).
  triggers = {
    instance_id = aws_instance.web_server.id
  }
}

