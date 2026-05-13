variable "region" { // Variable for AWS region
  description = " of region"
  type = string
  default = "us-west-2"
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.44.0"
    }
  }
}

provider "aws" {
  # Configuration options
  //region = "us-west-2"
  region = var.region // Use the variable for region (upper vale ko aaise bhi likh sakte hai)

}

resource "aws_instance" "myserver" {
  ami = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  
    tags = {
        Name = "MyServer"
    }
}