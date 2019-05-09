resource "digitalocean_firewall" "main" {
  name = "${var.name}"

  droplet_ids = ["${var.droplet_id}"]

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
      protocol              = "tcp"
      port_range            = "80"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "tcp"
      port_range            = "443"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "1-6000"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}
