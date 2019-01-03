output "ip" {
  value = "${digitalocean_floating_ip.pi-vpn-ip.ip_address}"
}

output "id" {
  value = "${digitalocean_droplet.pi-vpn.id}"
}
