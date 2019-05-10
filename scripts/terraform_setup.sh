#! /bin/bash


cd terraform
terraform init
terraform state pull
terraform plan
