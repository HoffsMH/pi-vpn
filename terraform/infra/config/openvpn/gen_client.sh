#!/bin/bash

mkdir /etc/openvpn/$1

# build the certificate for the client
easyrsa build-client-full $*

ovpn_getclient $1 > /etc/openvpn/$1/$1.ovpn

mv /etc/openvpn/pki/private/$1.key /etc/openvpn/$1/

cp /etc/openvpn/pki/issued/$1.crt /etc/openvpn/$1/

tar -cvzf "/etc/openvpn/$1.tar.gz" "/etc/openvpn/$1"

rm -rf /etc/openvpn/$1
