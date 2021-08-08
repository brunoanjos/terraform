resource "aws_lb_target_group" "hammer_lb_tg" {
  name     = "hammer-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.hammer_vpc.id
}

resource "aws_vpc" "hammer_vpc" {
  cidr_block = "172.31.0.0/16"
}
/*
resource "aws_lb_target_group_attachment" "hammer_lb" {
  target_group_arn = aws_lb_target_group.hammer_lb_tg.arn
  target_id        = aws_instance.hammer_instance.id
  port             = 80
}
*/
resource "aws_elb_attachment" "hammer_lb" {
  elb      = aws_elb.hammer_elb.id
  instance = aws_instance.hammer_instance.id
}