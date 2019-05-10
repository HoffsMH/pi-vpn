#!/bin/bash

# https://stackoverflow.com/questions/17188146/how-to-run-ansible-without-specifying-the-inventory-but-the-host-directly

ansible-playbook -i $VPN_ADDRESS, ansible/main.yml
