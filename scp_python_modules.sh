#!/bin/bash
# PWD = /home/kchen/git-sonic-core-x1/SonicCoreX/build.diags.loma-prieta/build_output/work/aarch64-soniccorex-linux/python/2.7.15-r1/image/usr/lib64/python2.7
#
DEST_IP="192.168.168.167"
DEST_DIR="/usr/lib64/python2.7/"
DEST_PATH=root@${DEST_IP}:${DEST_DIR}
 
scp telnetlib* 	${DEST_PATH}
scp socket* 	${DEST_PATH}
scp functools* 	${DEST_PATH}
scp StringIO* 	${DEST_PATH}
scp subprocess* ${DEST_PATH}
scp pickle* 	${DEST_PATH}
#
scp ./lib-dynload/select.so 	${DEST_PATH}
scp ./lib-dynload/fcntl.so 		${DEST_PATH}
scp ./lib-dynload/_socket.so 	${DEST_PATH}
scp ./lib-dynload/_functools.so ${DEST_PATH}
