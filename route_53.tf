resource "aws_route53_zone" "hammer_route_zone" {
  name = "hammerinvest.com.br"

  tags = {
    Environment = var.env
  }
}

resource "aws_route53_record" "hammer_route_record_ns" {
  zone_id = aws_route53_zone.hammer_route_zone.zone_id
  name    = "*.hammerinvest.com.br"
  type    = "A"

  alias {
    name                   = aws_elb.hammer_elb.dns_name
    zone_id                = aws_elb.hammer_elb.zone_id
    evaluate_target_health = true
  }
}