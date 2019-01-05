provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

module "main" {
  source = "./modules/ovpn_instance"

  providers = {
    digitalocean = "digitalocean"
  }
}

resource "aws_route53_record" "pi-vpn" {
  zone_id = "Z22WS4MEE8A9X6"
  name    = "${var.address}"
  type    = "A"
  ttl     = "60"
  records = ["${module.main.ip}"]
}

resource "digitalocean_firewall" "vpn" {
  name = "openvpn-and-ssh"

  droplet_ids = ["${module.main.id}"]

  inbound_rule = [
    {
      # ssh
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      # openvpn
      protocol         = "udp"
      port_range       = "1194"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "icmp"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      # only other machines on the vpn
      protocol              = "tcp"
      port_range            = "22"
      destination_addresses = ["192.168.254.0/24"]
    },
    {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}
