#!/bin/bash
# 
# mnt-dfs3.sh
#

USER_NAME="kchen"
PASSWORD="KpHar5023$"
#SRC_IP="10.50.128.91"
#SRC_IP="10.203.20.242"
SRC_IP="dfs3.sv.us.sonicwall.com"
MNT_BASE="/home/kchen"
SUDO="sudo" 

# =========================================================
SRC_DIR="${SRC_IP}/Engineering Public"
MNT_DIR="${MNT_BASE}/mnt/winshare/dfs3-eng-public"
mkdir -p ${MNT_DIR}
if [ $? -ne 0 ] ; then 
    printf '\nERROR-1: mkdir %s failed!\n' "${MNT_DIR}"
    exit 1
fi
${SUDO} mount -t cifs -o username=${USER_NAME},password=${PASSWORD} //"${SRC_DIR}" ${MNT_DIR}
if [ $? -ne 0 ] ; then 
    printf '\nERROR-2 mount cifs source dir: \"//%s\" on \"%s\" failed!\n' "${SRC_DIR}" "${MNT_DIR}"
    exit 2
fi
if [ ! -d "${MNT_DIR}/${USER_NAME}" ] ; then 
    printf '\nERROR-3: cannot find mounted dir %s\n' "${MNT_DIR}/${USER_NAME}"  
    exit 3
fi
printf '\nINFO: mounted CIFS \"//%s\" on DIR \"%s\"\n' "${SRC_DIR}" "${MNT_DIR}"

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
printf '\nINFO: mounted CIFS \"//%s\" on DIR \"%s\"\n' "${SRC_DIR}" "${MNT_DIR}"


