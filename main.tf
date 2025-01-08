provider "aws" {
  region = "us-east-1" # Change to your desired AWS region
}

resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16" # Define the CIDR block for your VPC
  enable_dns_support   = true          # Enable DNS support
  enable_dns_hostnames = true          # Enable DNS hostnames
  tags = {
    Name = "MyVPC"                  # Tag your VPC with a name
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "MyInternetGateway"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24" # Define the CIDR block for your subnet
  map_public_ip_on_launch = true    # Enable public IP mapping for instances launched in this subnet
  tags = {
    Name = "MySubnet"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "MyRouteTable"
  }
}

resource "aws_route" "my_route" {
  route_table_id         = aws_route_table.my_route_table.id
  destination_cidr_block = "0.0.0.0/0" # Allow traffic to any destination
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}
