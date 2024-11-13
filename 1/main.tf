terraform {
    required_providers {
        aws = {
            source= "hashicorp/aws"
            version = "~>3.0"
        }
    }
    
}

provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "example" {
    ami = "ami-038e0558f7ba9fefb"   // Amazon Linux 2023 AMI. user: ec2-user
    instance_type = "t3.micro"
}