# Terraformed Open-vpn server on digital ocean!

This was originally started as a way for me to securely connect to my raspberry pi's over the internet easily. It turned into "how much of this could I automate if I wanted to spin up many of these little vpns?". Its not at the level of a single button press yet, but I hope to get it there one day! The entire project has been redesigned to hold future-me's hand, thats why there is a nonsensical amount of shell scripts in the `scripts` folder; because given enough time (less than a couple days even) I would forget everything needed to get this up and running. built on top of the awesome docker image here! https://github.com/kylemanna/docker-openvpn 

### Features:
- all common task have been wrapped in a script!
- ansible for config management
- fail2ban for both ssh and vpn connections
- network layer security via digital ocean firewall
- routing to an aws area53 hosted domain so you can put your vpn
  as a sub domain of your personal website!
- systemd service so that if the node gets restarted so will the container
- easy client generation

### Requirements
- amazon aws api key
- digitial ocean api key
- direnv
- terraform
- ansible

## Lets go!

### Fill out your .envrc
```sh
cp .envrc.sample .envrc
```
And fill it out. Its pretty well commented to help figure where things should go

### Setup your terraform backend

Terraform needs a backend to keep the current state of your infrastructure
https://www.terraform.io/docs/backends/config.html

Im running with an s3 backend
https://www.terraform.io/docs/backends/types/s3.html

which could look something like this

```
terraform/backend.tf
```
```tf
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "<my_bucket_name>"
    key    = "<my_bucket_key>"
    region = "us-east-1"
  }
}
```

If you decide to go with this option you will probably need to set the following environment variables.

```
AWS_ACCESS_KEY_ID
AWS_SECRET_KEY
```

There is a spot in .envrc exists for this exact purpose

### Setup Terraform State

```
./scripts/terraform_setup.sh
```

### Build the image

```
./scripts/build_image.sh
```

### Push the image

Make sure to be logged into dockerhub in order for this to work

```
./scripts/push_image.sh
```

### Generate open vpn config  and pki
This will place a fresh open vpn config for your domain in config/openvpn

```
./scripts/gen_ovpn_config.sh
```

### Generate your first client
This will put a tarball in config/openvpn/pki that can be extracted to obtain your `*.ovpn` config file. This file can be used by the
`./scripts/connect_to_vpn.sh` script.

```
./scripts/gen_client.sh YOUR_CLIENT_NAME
```


### Create and fill out your env.sh for scheduling

Used to

```
cp config/scheduling/env.sh.sample config/scheduling/env.sh
```

### Provision the resources
```
./scripts/terraform_recreate.sh
```

### Run the configuration management

Ansible needs to be installed for this!
```
./scripts/run_config.sh
```

### Check that everything is running on the instance

These three services are needed in the droplet in order for the vpn to work

```
./scripts/ssh_to_vpn.sh
systemctl status docker
systemctl status fail2ban
systemctl status start_app
```

### Connect to the vpn using your `.ovpn` config

These three services are needed in the droplet in order for the vpn to work

```
./scripts/connect_to_vpn.sh path/to/my/config.ovpn
```

And thats it! In the future I plan to add more automation around common tasks like revoking. Possibly putting this all in CI so
that I don't have to bootstrap from my personal machine