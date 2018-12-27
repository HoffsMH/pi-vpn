# resource "aws_route53_zone" "main" {
#   name = "matthecker.com."
# }

resource "aws_route53_record" "vpn" {
  zone_id = "Z22WS4MEE8A9X6"
  name    = "pi-vpn.matthecker.com"
  type    = "A"
  ttl     = "60"
  records = ["${digitalocean_floating_ip.pi-vpn-ip.ip_address}"]
}
