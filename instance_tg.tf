resource "aws_lb_target_group" "hammer-lb-tg" {
  name     = "hammer-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.hammer-vpc.id
}

resource "aws_vpc" "hammer-vpc" {
  cidr_block = "172.31.0.0/16"
}