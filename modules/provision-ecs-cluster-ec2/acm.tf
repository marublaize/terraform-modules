resource "aws_acm_certificate" "main" {
  domain_name               = "${var.domain_name}"
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"
}

resource "aws_route53_record" "cert_validation" {
  name    = "${aws_acm_certificate.main.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.main.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.domain_name.id}"
  records = ["${aws_acm_certificate.main.domain_validation_options.0.resource_record_value}"]
  ttl     = 300
}