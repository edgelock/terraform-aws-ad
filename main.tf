resource "aws_vpc" "ad_lab_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ad-lab-vpc"
  }
}

resource "aws_subnet" "ad_lab_subnet" {
  vpc_id                  = aws_vpc.ad_lab_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "ad-lab-subnet"
  }
}

resource "aws_internet_gateway" "ad_lab_igw" {
  vpc_id = aws_vpc.ad_lab_vpc.id

  tags = {
    Name = "ad-lab-igw"
  }
}

resource "aws_route_table" "ad_lab_rt" {
  vpc_id = aws_vpc.ad_lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ad_lab_igw.id
  }

  tags = {
    Name = "ad-lab-rt"
  }
}

resource "aws_route_table_association" "ad_lab_rta" {
  subnet_id      = aws_subnet.ad_lab_subnet.id
  route_table_id = aws_route_table.ad_lab_rt.id
}

resource "aws_security_group" "ad_lab_sg" {
  vpc_id = aws_vpc.ad_lab_vpc.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow RDP access from anywhere
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/16"] # Allow DNS traffic within the VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ad-lab-sg"
  }
}

resource "aws_instance" "ad_lab_instance" {
  ami           = "ami-0c02fb55956c7d316" # Replace with Windows AMI ID
  instance_type = "t3.medium"            # Adjust instance type
  subnet_id     = aws_subnet.ad_lab_subnet.id
  security_groups = [
    aws_security_group.ad_lab_sg.name
  ]

  tags = {
    Name = "ad-lab-instance"
  }
}
