#!/bin/bash
#

source ~/bin/ansi-color.sh
ATTN_COLOR="${ANSI_YELLOW}"

N_DIR=0 
N_UPDATE=0
#PULL_MSG_DIR="/home/kchen/GIT-PULL-MSG"
PULL_MSG_DIR="./"

PULL_MSG_FILE="${PULL_MSG_DIR}/git-pull.sh.result.txt"
ALREADY_UPDATED_MSG="Already up to date."

#mkdir -p ${PULL_MSG_DIR}
#if [ $? -ne 0 ] ; then 
#    echo -e "ERROR: 'mkdir -p ${PULL_MSG_DIR}' failed!\n" 
#    exit 1
#fi 

while [ ! -z "${1}" ] ; 
do
    pushd . >/dev/null
    cd ${1}
    if [ $? -ne 0 ] ; then 
	echo -e "\nPWD=`pwd`" 
	echo -e "ERROR: 'cd ${1}' failed!\n" 
	exit 2
    fi 
    N_DIR=$((N_DIR+1))
    echo -e "\n### LOOP=${N_DIR}, AT `pwd`"
    git pull --rebase > ${PULL_MSG_FILE}
    LAST_STATUS=$?
    if [ ${LAST_STATUS} -ne 0 ] ; then 
	echo -e "${ANSI_RED}"
	cat ${PULL_MSG_FILE}
	echo -e "\nINFO: PWD=`pwd`"
	echo -e "ERROR: 'git pull --rebase' failed!"
	echo -e "${ANSI_NO_COLOR}"
	exit 3
    fi 
    HEAD_MSG="`cat ${PULL_MSG_FILE} | head -n1`"
# Note: the return status is the last command executed, which is grep 
    if [ ! "${HEAD_MSG}" = "${ALREADY_UPDATED_MSG}" ] ; then
# found the updated message
    	N_UPDATE=$((N_UPDATE+1))
	echo -e "${ATTN_COLOR}"
	cat ${PULL_MSG_FILE}
    else
    	echo -e "${ANSI_GREEN}"
	cat ${PULL_MSG_FILE}
    fi 
    echo -e "${ANSI_NO_COLOR}"
    shift 1
    popd >/dev/null
done 

echo -e "\n === INFO: ${N_UPDATE} 'NOT ${ALREADY_UPDATED_MSG}' out of ${N_DIR} repositories ===\n"

