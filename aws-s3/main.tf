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
  region = "us-west-2"

}

resource "aws_s3_bucket" "demo-tf-bucket" {
  bucket = "demo-tf-bucket-1234567890"
}

resource "aws_s3_object" "bucket-data" {
  bucket = aws_s3_bucket.demo-tf-bucket.bucket
  key    = "mydata.txt" //bucket me kis naam se file ko save karna hai 
  source = "./myfile.txt"
}

output "name" {
  value=random_id.rand_id.hex
}