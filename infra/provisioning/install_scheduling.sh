#!/bin/bash

chmod +x /opt/infra/scheduling/start_app.service

ln -sf /opt/infra/scheduling/start_app.service /etc/systemd/system/

systemctl start start_app.service
systemctl enable start_app.service
