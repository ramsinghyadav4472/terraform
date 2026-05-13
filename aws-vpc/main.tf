terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.44.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"

}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "MyVPC"
    }
}

#Private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "PrivateSubnet"
  }
}

#Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "PublicSubnet"
  }
}

#internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "MyIGW"
  }
}

#Routing table 
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route{
    cidr_block = "0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
} 

#Associate the public subnet with the route table
resource "aws_route_table_association"  "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.my_rt.id
} 