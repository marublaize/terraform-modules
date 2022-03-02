data "aws_route53_zone" "main" {
    name         = "${var.domain_name}."
    private_zone = "${var.is_private}" # true or false
}

  resource "aws_route53_record" "main" {
    zone_id = "${data.aws_route53_zone.main.zone_id}"
    name    = "${aws_ecs_cluster.main.name}.${var.domain_name}"
    type    = "CNAME"
    ttl     = "300"
    records = ["${aws_alb.alb.dns_name}"]
  }