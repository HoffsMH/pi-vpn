provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

resource "digitalocean_ssh_key" "me" {
  name       = "me"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "digitalocean_ssh_key" "terra" {
  name       = "terra"
  public_key = "${file("./infra/ssh/id_rsa.pub")}"
}

# Create a web server
resource "digitalocean_droplet" "pi-vpn" {
  name               = "pi-vpn"
  image              = "debian-9-x64"
  region             = "nyc1"
  size               = "s-1vcpu-1gb"
  ipv6               = true
  private_networking = true

  ssh_keys = [
    "${digitalocean_ssh_key.me.fingerprint}",
    "${digitalocean_ssh_key.terra.fingerprint}",
  ]

  provisioner "file" {
    source      = "./infra"
    destination = "/opt/infra"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("./infra/ssh/id_rsa")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /opt/infra/provisioning/*",
      "chmod +x /opt/infra/config/*.sh",

      # provisioning
      "/opt/infra/provisioning/install_docker.sh",

      # scheduling
      "/opt/infra/provisioning/install_scheduling.sh",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("./infra/ssh/id_rsa")}"
    }
  }
}

resource "digitalocean_floating_ip" "pi-vpn-ip" {
  droplet_id = "${digitalocean_droplet.pi-vpn.id}"
  region     = "${digitalocean_droplet.pi-vpn.region}"
}

output "ip" {
  value = "${digitalocean_floating_ip.pi-vpn-ip.ip_address}"
}
