#!/bin/bash

source /opt/infra/config/env.sh

/usr/bin/docker run --rm --cap-add=NET_ADMIN  -v /var/log:/var/log -v ${DATA_VOL}:/etc/openvpn --name ${NAME} -p ${PORT} ${IMG} ovpn_run $ARGS
