#!/bin/bash

echo =====  File /etc/resolv.conf  =====
cat /etc/resolv.conf
echo ===================================================

echo =====  file /etc/resolvconf/resolv.conf.d/head  =====
cat /etc/resolvconf/resolv.conf.d/head
echo =====================================================

sudo systemctl status  systemd-resolved
# systemd-resolve --status

