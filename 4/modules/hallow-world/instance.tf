resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }

  security_groups = [aws_security_group.instances.name]

  user_data = <<-E0F
                #!/bin/bash
                echo "Hallow World!" > index.html
                python3 -m http.server 8080 &
                E0F
}

resource "aws_security_group" "instances" {
  name = "instance-security-group"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.instances.id
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

output "instance_ip_addr" {
  value = aws_instance.instance.public_ip
}
