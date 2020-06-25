#!/bin/bash

EXE_NAME=`realpath $0`
EXE_DIR=`dirname ${EXE_NAME}`

SCR_LS=`sudo screen -ls`
if [ $? -eq 0 ] ; then 
    asc yellow blink
    printf "\n A sudo screen session is running:\n"
    asc unblink red
    printf "\n%s\n\n" "${SCR_LS}"
    asc reset
    exit 1 
fi 

SCREENRC_FILE=""/etc/screenrc.d/usbcon-screenrc""

if [ -f "${SCREENRC_FILE}" ] ; then 
    sudo screen -c ${SCREENRC_FILE} -d -m
else
    printf "ERROR1: cannot find file: %s" "${SCREENRC_FILE}"
    exit 1
fi
