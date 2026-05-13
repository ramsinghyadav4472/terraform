terraform {
  required_providers {
    aws={
        source="hashicorp/aws"
        version = "5.55.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "name" {
  most_recent = true
  owners = ["amazon"]
}

output "aws_ami" {
  //value = data.aws_ami.name
  value = data.aws_ami.name.id
  

}

#security group
data "aws_security_group" "sg" {
  tags = {
    mywebserver = "http"
  }
}

output "security_group" {
    value = data.aws_security_group.sg
    //value = data.aws_security_group.name
  //value = data.aws_security_group.sg.id

  
}

#VPC Id
data "aws_vpc" "vpc" {
  tags = {
    ENV = "prod"
    Name = "myvpc"
  }
}

output "vpc_id" {
    value = data.aws_vpc.vpc.id
}

#AZ
data "aws_availability_zones" "az" {
  state = "available"
}

 output "aws_zones" {
        value = data.aws_availability_zones.az.names
    }

#to get the account details
data "aws_caller_identity" "name" {
}   
output "account_id" {
    value = data.aws_caller_identity.name.account_id
}


resource "aws_instance" "myserver" {
  ami = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  
    tags = {
        Name = "MyServer"
    }
}