resource "aws_acm_certificate" "hammer_cert" {
  domain_name       = "*.hammerinvest.com.br"
  validation_method = "DNS"

  tags = {
    Environment = var.env
  }

  lifecycle {
    create_before_destroy = true
  }
}