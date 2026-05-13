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

resource "aws_instance" "myserver" {
  ami = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  
    tags = {
        Name = "MyServer"
    }
}