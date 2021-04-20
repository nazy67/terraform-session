# In this template for_each function with local variables were used in the creation of
# resources. for_each can work with a string or a map values. In our case we are
# working with map, here we can pass separate settings for each subnet, while using 
# the keys for generating subnets.

# VPC 
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.is_enabled_dns_support
  enable_dns_hostnames = var.is_enabled_dns_hostnames
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_vpc"
    }
  )
}

# Public Subnets
resource "aws_subnet" "public_subnet_" {
  for_each = local.public_subnet
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_pub_sub_${each.key}"
    }
  )
}
locals {
  public_subnet = {
    1 = { availability_zone = "us-east-1a", cidr_block = "10.0.1.0/24" },
    2 = { availability_zone = "us-east-1b", cidr_block = "10.0.2.0/24" },
    3 = { availability_zone = "us-east-1c", cidr_block = "10.0.3.0/24" }
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet_" {
  for_each = local.private_subnet
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_priv_sub_${each.key}"
    }
  )
}

locals {
  private_subnet = {
    1 = { availability_zone = "us-east-1a", cidr_block = "10.0.11.0/24" },
    2 = { availability_zone = "us-east-1b", cidr_block = "10.0.12.0/24" },
    3 = { availability_zone = "us-east-1c", cidr_block = "10.0.13.0/24" }
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_igw"
    }
  )
}

# Public Route Table
resource "aws_route_table" "pub_rtb" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_pub_rtb"
    }
  )
}

# Public Route Table Association
resource "aws_route_table_association" "pub_subnet" {
  for_each = local.public_subnet
  subnet_id      = aws_subnet.public_subnet_[each.key].id
  route_table_id = aws_route_table.pub_rtb.id
}

# Elastic IP
resource "aws_eip" "nat_gw_eip" {
  vpc = true
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_eip"
    }
  )
}

# Nat Gateway
resource "aws_nat_gateway" "nat_gw" {
  depends_on    = [aws_internet_gateway.igw]
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnet_[1].id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_nat_gw"
    }
  )
}

# Private Route Table
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = var.rt_cidr_block
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_private_rtb"
    }
  )
}

# Private Route Table Association
resource "aws_route_table_association" "priv_subnet" {
  for_each = local.private_subnet
  subnet_id      = aws_subnet.private_subnet_[each.key].id
  route_table_id = aws_route_table.private_rtb.id
}