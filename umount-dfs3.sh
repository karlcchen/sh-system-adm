#!/bin/bash
#
# umount-dfs3.sh
#

MNT_DIR="/mnt/winshare/dfs3-eng-public"

sudo umount ${MNT_DIR}
if [ $? -ne 0 ] ; then 
    printf 'ERROR-1: umount %s failed!\n' "${MNT_DIR}"
#    exit 1
fi 
MNT_DIR="/mnt/winshare/SWBuilds"
sudo umount ${MNT_DIR}
if [ $? -ne 0 ] ; then 
    printf 'ERROR-2: umount %s failed!\n' "${MNT_DIR}"
#    exit 2
fi 

