terraform {
    # Assumes s3 bucket and dynamo DB table already set up
    backend "s3" {
        bucket = "devops-directive-tf-state-elnur"
        key = "3/staging/terraform.tfstate"
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

variable "db_pass" {
    description = "password for the database"
    type = string
    sensitive = true
}

locals {
    environment_name = "staging"
}

module "web_app"  {
    source = "../../2/web-app/web-app-module"

    bucket_name = "elnur-web-app-data-${local.environment_name}"
    domain = "elnurdevops.com"
    //app_name = "web-app-1"
    environment_name = local.environment_name
    instance_type = "t3.micro"
    create_dns_zone = false
    db_name = "${local.environment_name}-mydb"
    db_user = "admin"
    db_pass = var.db_pass

}