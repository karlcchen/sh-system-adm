#!/bin/bash
#
sudo service nfs-kernel-server restart
# refresh /etc/exports for nfs
sudo export -ra
