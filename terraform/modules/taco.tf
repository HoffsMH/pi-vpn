resource "digitalocean_droplet" "pi-vpn" {
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
