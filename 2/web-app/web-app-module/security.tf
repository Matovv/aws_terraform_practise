// Security group 1: instances (web)
resource "aws_security_group" "instances" {
    name = "instance-security-group"
}

resource "aws_security_group_rule" "allow_http_inbound" {
    type = "ingress"
    security_group_id = aws_security_group.instances.id

    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

// Security group 2: load balancer (alb)
resource "aws_security_group" "alb" {
    name= "alb-security-group"
}

// alb inbound rule (from anywhere)
resource "aws_security_group_rule" "allow_alb_http_inbound" {
    type = "ingress"
    security_group_id = aws_security_group.alb.id

    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

// alb outbound rule (to anywhere)
resource "aws_security_group_rule" "allow_alb_http_outbound" {
    type = "egress"
    security_group_id = aws_security_group.alb.id

    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}