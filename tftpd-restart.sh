#!/bin/bash
#
#
sudo systemctl status  xinetd.service

sudo systemctl restart xinetd.service

sudo systemctl status  xinetd.service
