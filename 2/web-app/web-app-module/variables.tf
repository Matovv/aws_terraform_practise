# General:

variable "region" {
    description = "Default region for provider"
    type = string
    default = "eu-north-1"
}

variable "app_name" {
    description = "Name of the web application"
    type = string
    default = "web-app"
}

variable "environment_name" {
    description = "Deployment environment (dev/staging/production)"
    type = string
    default = "dev"
}

# EC2:

variable "instance_name" {
    description = "Name of ec2 instance"
    type = string
    default = "Default Instance"
}

variable "ami" {
    description = "Amazon machine image to use for ec2 instance"
    type = string
    default = "ami-038e0558f7ba9fefb"   // Amazon Linux 2023 AMI. user: ec2-user
}

variable "instance_type" {
    description = "ec2 instance type"
    type = string
    default = "t3.micro"
}

# S3:

variable "bucket_name" {
    description = "Name of s3 bucket for app data"
    type = string
}

# Route 53:

variable "domain" {
    description = "Domain for website"
    type = string
}

variable "create_dns_zone" {
    description = "If true, create new route53 zone, if false read existing route53 zone"
    type = bool
    default = false
}

# RDS:

variable "db_name" {
    description = "Name of DB"
    type = string
}

variable "db_user" {
    description = "username for database"
    type = string
}

variable "db_pass" {
    description = "password for database"
    type = string
    sensitive = true
}