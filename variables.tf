variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1" # Replace with your preferred region
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-0c02fb55956c7d316" # Replace with a valid Windows AMI ID
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  default     = "t3.medium"
}

variable "allow_rdp_cidr" {
  description = "CIDR block to allow RDP access"
  default     = "0.0.0.0/0" # Change this to your IP range for security
}
