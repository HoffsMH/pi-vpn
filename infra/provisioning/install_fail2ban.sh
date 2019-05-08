#!/bin/bash

apt-get install fail2ban -y

systemctl stop fail2ban.service

touch /var/log/openvpn.log
cp -r /opt/infra/config/fail2ban/* /etc/fail2ban/

systemctl restart fail2ban.service
