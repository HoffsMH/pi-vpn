#!/bin/bash

/opt/infra/provisioning/install_docker.sh
/opt/infra/provisioning/install_fail2ban.sh

# disallow passwords and restart ssh
sed -i -e s/#PasswordAuthentication\ yes/PasswordAuthentication\ no/

systemctl restart sshd

