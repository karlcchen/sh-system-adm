#!/bin/bash

#sudo service resolvconf restart

#sudo systemctl restart systemd-resolved
sudo systemctl stop    systemd-resolved
sudo systemctl enable  systemd-resolved
sudo systemctl start   systemd-resolved
sudo systemctl status  systemd-resolved
