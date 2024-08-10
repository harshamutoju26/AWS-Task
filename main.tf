terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Specify the provider
provider "aws" {
  region     = "ap-south-1" 
  access_key  = "Enter access key"
  secret_key  = "Enter secret key"
}

# Creating VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# Creating public subnets in two different availability zones
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-b"
  }
}

# Creating an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# Creating Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}


# Associating public_a subnet with route table
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

# Associating public_b subnet with route table
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# Creating security group for instances in subnet
resource "aws_security_group" "sg_public_a" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-a-ec2-sg"
  }
}

# Creating security group for instances in subnet
resource "aws_security_group" "sg_public_b" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-b-ec2-sg"
  }
}

# Creating instance in subnet
resource "aws_instance" "windows_a" {
  ami                  = "Specify ami according to instance(Windows/Linux)" 
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.sg_public_a.id]

  tags = {
    Name = "instance-a"
  }
}

# Creating instance in subnet
resource "aws_instance" "windows_b" {
  ami                  = "Specify ami according to instance(Windows/Linux)" 
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.public_b.id
  vpc_security_group_ids = [aws_security_group.sg_public_b.id]

  tags = {
    Name = "instance-b"
  }
}

# Creating Load Balancer
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_public_a.id, aws_security_group.sg_public_b.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  tags = {
    Name = "app-lb"
  }
}

# Creating Target Group for Load Balancer
resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

# Register instances with target group
resource "aws_lb_target_group_attachment" "app_tg_attachment_a" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.windows_a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "app_tg_attachment_b" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.windows_b.id
  port             = 80
}

# Creating Listener for Load Balancer
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# Output VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

# Output Load Balancer DNS name
output "lb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

output "subnet_a_id" {
  value = aws_subnet.public_a.id
}

output "subnet_b_id" {
  value = aws_subnet.public_b.id
}

output "route_table_public_id" {
  value = aws_route_table.public.id
}

output "route_table_private_id" {
  value = aws_route_table.private.id
}
