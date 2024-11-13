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