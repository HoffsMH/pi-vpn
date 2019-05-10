#!/bin/bash

source /etc/scheduling/env.sh

/usr/bin/docker rm -f $NAME
/usr/bin/docker pull $IMG
