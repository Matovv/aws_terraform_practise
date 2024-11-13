terraform {
    # Assumes s3 bucket and dynamo DB table already set up
    backend "s3" {
        bucket = "devops-directive-tf-state-elnur"
        key = "2/web-app/terraform.tfstate"
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

variable "db_pass_1" {
    description = "password for database 1"
    type = string
    sensitive = true
}

variable "db_pass_2" {
    description = "password for database 2"
    type = string
    sensitive = true
}

module "web_app_1"  {
    source = "../web-app-module"

    bucket_name = "web-app-1-devops-directive-web-app-data-elnur"
    domain = "devopsdeployed.com"
    app_name = "web-app-1"
    environment_name = "production"
    instance_type = "t3.micro"
    create_dns_zone = true
    db_name = "webapp1db"
    db_user = "admin"
    db_pass = var.db_pass_1

}
