terraform {
    # Assumes s3 bucket and dynamo DB table already set up
    backend "s3" {
        bucket = "devops-directive-tf-state-elnur"
        key = "3/global/terraform.tfstate"
        region = "eu-north-1"
        dynamodb_table = "terraform-state-locking"
        encrypt = true
    }

    required_providers {
        aws = {
            source: "hashicorp/aws"
            version: "~>3.0"
        }
    }
}

provider "aws" {
    region = "eu-north-1"
}

// Route53 zone is shared across staging and production
resource "aws_route53_zone" "primary" {
    name = "elnurdevops.com"
}
