resource "aws_route53_record" "vpn" {
  zone_id = "Z22WS4MEE8A9X6"
  name    = "${var.address}"
  type    = "A"
  ttl     = "60"
  records = ["${digitalocean_floating_ip.pi-vpn-ip.ip_address}"]
}
