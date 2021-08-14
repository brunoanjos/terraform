resource "aws_vpc" "hammer_vpc" {
  cidr_block = "172.31.0.0/16"

  tags = {
    Name        = "hammer-vpc"
    Environment = var.env
    Provisioner = "Terraform"
    Auto-Start  = "true"
  }
}

resource "aws_lb_target_group" "hammer_lb_tg" {
  name = "hammer-lb-tg"
  port = "8080"
  protocol = "TCP"
  target_type = "ip"
  vpc_id = aws_vpc.hammer_vpc.id
  deregistration_delay = 5
  slow_start = 0
  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    interval = 30
    path = "/actuator/health"
    protocol = "HTTP"
  }
}