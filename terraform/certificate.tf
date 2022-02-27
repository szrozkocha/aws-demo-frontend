resource "aws_acm_certificate" "cert" {
  provider = aws.cert
  domain_name       = var.s3_bucket_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  name = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  type = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  zone_id = var.hosted_zone_id
  records = [tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value]
  ttl = 60
}

resource "aws_acm_certificate_validation" "cert" {
  provider = aws.cert
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}
