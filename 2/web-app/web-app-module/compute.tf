// aws instances
locals {
    extra_tag = "extra-tag"
}


resource "aws_instance" "instance_1" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
      Name = var.instance_name
      ExtraTag = local.extra_tag
    }

    security_groups = [aws_security_group.instances.name]
    
    user_data = <<-E0F
                #!/bin/bash
                echo "Hello, World 1" > index.html
                python3 -m http.server 8080 &
                E0F
}

resource "aws_instance" "instance_2" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
      Name = var.instance_name
      ExtraTag = local.extra_tag
    }

    security_groups = [aws_security_group.instances.name]
    user_data = <<-E0F
                #!/bin/bash
                echo "Hello, World 2" > index.html
                python3 -m http.server 8080 &
                E0F
}
