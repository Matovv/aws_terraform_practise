terraform {
    # Assumes s3 bucket and dynamo DB table already set up
    backend "s3" {
        bucket = "devops-directive-tf-state-elnur"
        key = "4/hallow-world/terraform.tfstate"
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

module "web_app" {
    source = "../../modules/hallow-world"
}

output "instance_ip_addr" {
    value = module.web_app.instance_ip_addr
}

output "url" {
    value = "http://${module.web_app.instance_ip_addr}:8080"
}