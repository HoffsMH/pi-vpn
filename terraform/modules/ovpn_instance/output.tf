output "ip" {
  value = "${digitalocean_floating_ip.main.ip_address}"
}

output "id" {
  value = "${digitalocean_droplet.main.id}"
}
