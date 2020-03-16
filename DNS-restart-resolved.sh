#!/bin/bash

#sudo service resolvconf restart
sudo systemctl restart systemd-resolved
sudo systemctl status systemd-resolved
