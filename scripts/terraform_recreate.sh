#! /bin/bash

cd terraform
terraform destroy -auto-approve
terraform plan
terraform apply -auto-approve