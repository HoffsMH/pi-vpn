resource "aws_route53_record" "address" {
  zone_id = "Z22WS4MEE8A9X6"
  name    = "${var.address}"
  type    = "A"
  ttl     = "60"
  records = ["${var.ip}"]
}
