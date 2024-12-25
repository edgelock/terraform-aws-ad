output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.ad_lab_vpc.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.ad_lab_subnet.id
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ad_lab_instance.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ad_lab_instance.public_ip
}
