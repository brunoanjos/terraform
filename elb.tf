resource "aws_lb" "hammer_lb" {
  name = var.nlb_name
  internal = true
  load_balancer_type = "network"
  vpc_id = aws_vpc.hammer_vpc.id
  subnets = [aws_instance.hammer_instance.subnet_id]
  enable_cross_zone_load_balancing = true
  enable_deletion_protection = false

  tags = {
    NomeProduto = var.name
    MicroService = "hammer-service"
    Environment = var.env
    LoadBalancerType = "VPCLink"
  }
  depends_on = [
    aws_vpc.hammer_vpc,
  ]
}

resource "aws_lb_listener" "hammer_lb_listener" {
  load_balancer_arn = aws_lb.hammer_lb.arn
  port = "80"
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.hammer_lb_tg.arn
  }
}