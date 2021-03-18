#!/bin/bash
#
#

sudo systemctl stop NetworkManager.service
sudo systemctl disable NetworkManager.service

# and three more services:
sudo systemctl stop    NetworkManager-wait-online.service
sudo systemctl disable NetworkManager-wait-online.service

sudo systemctl stop    NetworkManager-dispatcher.service
sudo systemctl disable NetworkManager-dispatcher.service

sudo systemctl stop    NetworkManager.service
sudo systemctl disable NetworkManager.service


./LM-status.sh
