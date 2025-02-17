output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.custom_vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.custom_ig.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "nat_gateway_eip" {
  description = "Elastic IP of the NAT Gateway"
  value       = aws_eip.nat_eip.public_ip
}

output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.custom_instance.id
}

output "ec2_instance_public_ip" {
  description = "Public IP of the EC2 instance (if assigned)"
  value       = aws_instance.custom_instance.public_ip
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public_route.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private_route.id
}

output "security_group_id" {
  description = "ID of the custom security group"
  value       = aws_security_group.custom_sg.id
}

output "ec2_instance_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.custom_instance.private_ip
}