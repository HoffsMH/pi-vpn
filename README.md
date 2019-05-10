# Terraformed Open-vpn server on digital ocean!

# Requirements
- terraform
- direnv
- amazon aws account
- digitial ocean account

## This Project depends heavily on direnv

## Getting terraform up and running

### Setup your terraform backend

Terraform needs a backend to keep the current state of your infrastructure
https://www.terraform.io/docs/backends/config.html

Im running with an s3 backend
https://www.terraform.io/docs/backends/types/s3.html

which could look something like this

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

a spot in .envrc exists for this exact purpose

### Terraform

## Generate your pki

copy you pki

deploy



```
./deploy.sh
```

copy your personal pki to the pki  directory in terraform folder that will embed your pki in the openvpn do

```
./cp_pki.sh
```

## Destroy the infra

```
terraform destroy
```

## Getting the Image into the Droplet

Using scheduling like Kubernetes is overkill for a project like this

By default there is a terraform provisioner that pulls a specified

## Building the Docker image

starting off you can build the docker image on your dev machine just make sure
your .envrc is filled out.

## Once you are up and running
### sshing into your droplet
### Adding clients
### viewing clients
### revoking clients
### connecting
