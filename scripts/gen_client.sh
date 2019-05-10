#!/bin/bash

# after running this there should be a config/openvpn/pki/CLIENT_NAME.tar.gz that contains 
# keys and config needed to connect to the server
docker run -v $(pwd)/config/openvpn:/etc/openvpn --log-driver=none --rm -it $IMG ovpn_genclient $@

