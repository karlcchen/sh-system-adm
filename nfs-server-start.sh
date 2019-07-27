#!/bin/bash

sudo systemctl restart nfs-kernel-server
./nfs-server-status.sh
