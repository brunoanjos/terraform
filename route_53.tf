resource "aws_route53_zone" "hammer_route_zone" {
  name = "www.hammerinvest.com.br"

  tags = {
    Environment = var.env
  }
}

resource "aws_route53_record" "hammer_route_record_ns" {
  zone_id = aws_route53_zone.hammer_route_zone.zone_id
  name    = "www.hammerinvest.com.br"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.hammer_route_zone.name_servers
}

resource "aws_route53_record" "hammer_route_record_soa" {
  zone_id = aws_route53_zone.hammer_route_zone.zone_id
  name    = "www.hammerinvest.com.br"
  type    = "SOA"
  ttl     = "30"
  records = aws_route53_zone.hammer_route_zone.name_servers
}