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
}

resource "digitalocean_floating_ip" "main" {
  droplet_id = "${digitalocean_droplet.main.id}"
  region     = "${digitalocean_droplet.main.region}"
}
