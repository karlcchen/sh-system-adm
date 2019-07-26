#!/bin/bash
#
# sudo -H gedit /etc/systemd/logind.conf
#
# edit: Add a line HandleLidSwitch=ignore (make sure it's not commented out!)
#
#      
sudo systemctl restart systemd-logind
sudo systemctl status  systemd-logind

