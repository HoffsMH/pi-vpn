provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "hoffsmh-pi-vpn-tfstate"
    key    = "state/"
    region = "us-east-1"
  }
}
