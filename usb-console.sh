#!/bin/bash

SCREENRC_FILE=""/etc/screenrc.d/usbcon-screenrc""

if [ -f "${SCREENRC_FILE}" ] ; then 
    sudo screen -c ${SCREENRC_FILE} -d -m
else
    printf "ERROR1: cannot find file: %s" "${SCREENRC_FILE}"
    exit 1
fi
