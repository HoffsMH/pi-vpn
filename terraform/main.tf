provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

module "instance" {
  source = "./modules/ovpn_instance"
  name   = "${var.vpn_name}"

  providers = {
    digitalocean = "digitalocean"
  }
}

module "routing" {
  source  = "./modules/routing"
  address = "${var.vpn_address}"
  ip      = "${module.instance.ip}"

  providers = {
    digitalocean = "digitalocean"
  }
}

module "firewall" {
  source = "./modules/firewall"
  name = "${var.vpn_name}"
  droplet_id = "${module.instance.id}"

  providers ={
    digitalocean = "digitalocean"
  }
}