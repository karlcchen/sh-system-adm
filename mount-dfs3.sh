#!/bin/bash
# 
# mnt-dfs3.sh
#

USER_NAME="kchen"
PASSWORD="GeeZan5023$"
#SRC_IP="10.50.128.91"
SRC_IP="10.203.20.242"
MNT_BASE="/home/kchen"
SUDO="sudo" 

# =========================================================
SRC_DIR="${SRC_IP}/Engineering Public"
MNT_DIR="${MNT_BASE}/mnt/winshare/dfs3-eng-public"
mkdir -p ${MNT_DIR}
if [ $? -ne 0 ] ; then 
    printf 'ERROR-1: mkdir %s failed!\n' "${MNT_DIR}"
    exit 1
fi
${SUDO} mount -t cifs -o username=${USER_NAME},password=${PASSWORD} //"${SRC_DIR}" ${MNT_DIR}
if [ $? -ne 0 ] ; then 
    printf 'ERROR-2 mount cifs source dir: %s failed!\n' "${SRC_DIR}" 
    exit 2
fi
if [ ! -d "${MNT_DIR}/${USER_NAME}" ] ; then 
    printf 'ERROR-3: cannot find mounted dir %s\n' "${MNT_DIR}/${USER_NAME}"  
    exit 3
fi

# =========================================================
SRC_DIR="${SRC_IP}/SWBuilds"
MNT_DIR="${MNT_BASE}/mnt/winshare/SWBuilds"
mkdir -p ${MNT_DIR}
if [ $? -ne 0 ] ; then 
    printf 'ERROR-4: mkdir %s failed!\n' "${MNT_DIR}"
    exit 4
fi
${SUDO} mount -t cifs -o username=${USER_NAME},password=${PASSWORD} //"${SRC_DIR}"  ${MNT_DIR}
if [ $? -ne 0 ] ; then 
    printf 'ERROR-5: mount cifs source dir: %s failed!\n' "${SRC_DIR}" 
    exit 5
fi


