dcm build

docker push hoffsmh/pi-vpn:latest

cd ./terraform
terraform destroy -auto-approve && terraform plan && terraform apply -auto-approve && ding && ssh pi-vpn.matthecker.com
