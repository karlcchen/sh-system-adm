#!/bin/bash
# 
# mk-swapfile.sh 
#


if [ ! -e "/swapfile" ] ; then  
	sudo fallocate -l 128G /swapfile
#
# If faillocate is not installed or if you get an error message saying fallocate failed: 
# Operation not supported then you can use the following command to create the swap file:
# sudo dd if=/dev/zero of=/swapfile bs=1024 count=1048576
#
	sudo chmod 600  /swapfile
	sudo mkswap     /swapfile
	sudo swapon     /swapfile
#
        printf '\n add "/swapfile swap swap defaults 0 0" to /etc/fstab\n\n'
#
fi

sudo swapon --show
echo 

sudo free -h
echo
#
# Swappiness is a Linux kernel property that defines how often the system will use the swap space. 
# Swappiness can have a value between 0 and 100. A low value will make the kernel to try to avoid 
# swapping whenever possible, while a higher value will make the kernel to use the swap space more 
# aggressively.
#
# The default swappiness value is 60. You can check the current swappiness value by typing the following command:
#
printf '\nSwappiness='
cat /proc/sys/vm/swappiness
echo
