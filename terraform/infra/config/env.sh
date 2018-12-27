#!/bin/bash

export NAME="pi-vpn"
export IMG="hoffsmh/pi-vpn:latest"
export PORT="1194:1194/udp"
export DATA_VOL="/opt/infra/config/openvpn"
