#!/bin/bash

source /opt/infra/config/env.sh

/usr/bin/docker rm -f $NAME
/usr/bin/docker pull $IMG
