resource "digitalocean_ssh_key" "main" {
  name       = "dev"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "digitalocean_droplet" "main" {
  name               = "${var.name}"
  image              = "debian-9-x64"
  region             = "nyc1"
  size               = "s-1vcpu-1gb"
  ipv6               = true
  private_networking = true

  ssh_keys = [
    "${digitalocean_ssh_key.main.fingerprint}",
  ]

  # provisioner "file" {
  #   source      = "./infra"
  #   destination = "/opt/infra"

  #   connection {
  #     type        = "ssh"
  #     user        = "root"
  #     private_key = "${file("~/.ssh/id_rsa")}"
  #   }
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /opt/infra/provisioning/*",
  #     "chmod +x /opt/infra/config/*.sh",

  #     # provisioning
  #     "/opt/infra/provisioning/install_config.sh",

  #     # scheduling
  #     "/opt/infra/provisioning/install_scheduling.sh",
  #   ]

  #   connection {
  #     type        = "ssh"
  #     user        = "root"
  #     private_key = "${file("~/.ssh/id_rsa")}"
  #   }
  # }
}

resource "digitalocean_floating_ip" "main" {
  droplet_id = "${digitalocean_droplet.main.id}"
  region     = "${digitalocean_droplet.main.region}"
}
