/*
resource "aws_lb_target_group" "hammer_lb_tg" {
  count   = var.tg_control ? 1 : 0
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

resource "aws_lb" "hammer_lb" {
  name = var.nlb_name
  internal = false
  load_balancer_type = "network"
  subnets = [aws_instance.hammer_instance.subnet_id]
  enable_cross_zone_load_balancing = true
  enable_deletion_protection = false

  tags = {
    NomeProduto = var.name
    MicroService = "hammer-service"
    Environment = var.env
    LoadBalancerType = "VPCLink"
  }
}

resource "aws_lb_listener" "hammer_lb_listener" {
  load_balancer_arn = aws_lb.hammer_lb.arn
  port = "80"
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.hammer_lb_tg.arn
  }
}*/
#############################################################
#############################################################
resource "aws_elb" "hammer_elb" {
  name               = "hammer-elb"
  subnets            = [aws_subnet.public_subnet.id]
  security_groups    = [aws_security_group.hammer_sg.id]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 8080
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.hammer_cert.arn
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/actuator/health"
    interval            = 10
  }

  instances                   = ["${aws_instance.hammer_instance.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name                    = "hammer-elb"
    Envirioment             = "Production"
    ProvideBy               = "${var.terraform}"
  }
}