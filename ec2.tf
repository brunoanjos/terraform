resource "aws_vpc" "hammer_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name        = "hammer-vpc"
    Environment = var.env
    Provisioner = "Terraform"
    Auto-Start  = "true"
  }
}

resource "aws_internet_gateway" "hammer_igw" {
  vpc_id = aws_vpc.hammer_vpc.id

  tags = {
    Name = "hammer_igw"
    Method = var.terraform

  }
}

resource "aws_route_table" "hammer_rt_public" {
  vpc_id = aws_vpc.hammer_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hammer_igw.id
  }
  tags = {
    Name = "hammer_rt_public"
    Method = var.terraform
  }
}

resource "aws_route_table_association" "hammer_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.hammer_rt_public.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.hammer_vpc.id
  cidr_block = var.cidr_block
  availability_zone = var.zone_us-east-1a
  map_public_ip_on_launch ="true"
}

resource "aws_instance" "hammer_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_pair
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.hammer_sg.id]

  tags = {
    Name        = var.name
    Environment = var.env
    Provisioner = var.terraform
    Auto-Start  = "true"
  }
}