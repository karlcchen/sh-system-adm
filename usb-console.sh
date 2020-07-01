#!/bin/bash

EXE_NAME=`realpath $0`
EXE_DIR=`dirname ${EXE_NAME}`

# use ~/bin as where asc is installed
ASC_DIR="`realpath ~/bin`"

WHOAMI=`whoami`

if [ "${WHOAMI}" = "root" ] ; then 
    SUDO_CMD=""  
else
    SUDO_CMD="sudo"
fi

SCR_LS=`${SUDO_CMD} screen -ls`
if [ $? -eq 0 ] ; then 
    ${ASC_DIR}/asc yellow blink
    printf "\n A sudo screen session is running:\n"
    ${ASC_DIR}/asc unblink red
    printf "\n%s\n\n" "${SCR_LS}"
    ${ASC_DIR}/asc reset
    exit 1 
fi 

SCREENRC_FILE=""/etc/screenrc.d/usbcon-screenrc""

if [ -f "${SCREENRC_FILE}" ] ; then 
    ${SUDO_CMD} screen -c ${SCREENRC_FILE} -d -m
else
    printf "ERROR1: cannot find file: %s" "${SCREENRC_FILE}"
    exit 1
fi
