data "aws_vpc" "default_vpc" {
    default = true
}

data "aws_subnet_ids" "default_subnet" {
    vpc_id = data.aws_vpc.default_vpc.id
}

// AWS Load balancer listener init
resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.load_balancer.arn

    port = 80

    protocol = "HTTP"

    default_action {
        type = "fixed-response"

        fixed_response {
            content_type = "text/plain"
            message_body = "404: page not found"
            status_code = 404
        }
    }
}

// Target group and targets
resource "aws_lb_target_group" "instances" {
    name = "example-target-group"
    port = 8080
    protocol = "HTTP"
    vpc_id = data.aws_vpc.default_vpc.id

    health_check {
        path = "/"
        protocol = "HTTP"
        matcher = "200"
        interval = 15
        timeout = 3
        healthy_threshold = 2
        unhealthy_threshold = 2
    }
}

resource "aws_lb_target_group_attachment" "instance_1" {
    target_group_arn = aws_lb_target_group.instances.arn
    target_id = aws_instance.instance_1.id
    port = 8080
}

resource "aws_lb_target_group_attachment" "instance_2" {
    target_group_arn = aws_lb_target_group.instances.arn
    target_id = aws_instance.instance_2.id
    port = 8080
}

resource "aws_lb_listener_rule" "instances" {
    listener_arn = aws_lb_listener.http.arn
    priority = 100

    condition {
        path_pattern {
          values = ["*"]
        }
    }

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.instances.arn
    }

}

// Load Balancer Setup
resource "aws_lb" "load_balancer" {
    name = "web-app-lb"
    load_balancer_type = "application"
    subnets = data.aws_subnet_ids.default_subnet.ids
    security_groups = [aws_security_group.alb.id]
}