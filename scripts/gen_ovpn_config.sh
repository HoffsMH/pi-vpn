#!/bin/bash

docker run -v $(pwd)/config/openvpn:/etc/openvpn --log-driver=none --rm $IMG ovpn_genconfig -u udp://$VPN_ADDRESS
docker run -v $(pwd)/config/openvpn:/etc/openvpn --log-driver=none --rm -it $IMG ovpn_initpki