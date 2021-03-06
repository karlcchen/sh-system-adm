#!/bin/bash
#
# for user access /dev/ttyUSBx it must belong to the dialout group
#
# to add user to the dialout group:
#
# > sudo usermod -a -G dialout,tty kchen 
# then reboot the machine to take effect 
# > sudo reboot
#
# also set "/usr/bin/screen" with "suid" root 
# > sudo chmod +s /usr/bin/screen 
#

EXE_NAME=`realpath $0`
EXE_DIR=`dirname ${EXE_NAME}`

TEST_DEV="/dev/ttyUSB0"

if [[ -e "${TEST_DEV}" ]]; then 
    DEV_GROUP="`ls -l ${TEST_DEV} | awk '{print $4}'`"
else
    printf '\nERROR-1: serial device %s not found!\n' 
    exit 1
fi 

# use ~/bin as where asc is installed
ASC_DIR="`realpath ~/bin`"

SCR_LS="`screen -ls`"
if [[ $? -eq 0 ]]; then 
    ${ASC_DIR}/asc yellow blink
    printf '\nERROR-2: A GNU screen session already exist:\n'
    ${ASC_DIR}/asc unblink red
    printf '\n%s\n\n' "${SCR_LS}"
    ${ASC_DIR}/asc reset
    exit 2 
fi 

MY_GROUP="`id -Gn`"
echo "${MY_GROUP}" | grep "${DEV_GROUP}" >/dev/null
if [[ $? -ne 0 ]]; then 
    printf '\nERROR-3: must belong to the same group \"%s\" as device \"%s\"\n' "${DEV_GROUP}" "${TEST_DEV}"
    printf '%s Your Groups: %s\n' "$(whoami)" "${MY_GROUPS}"
    exit 3
fi 

# if /usr/bin/screen has sticky bit set, then 755 will be good
# otherwise, need 777 
sudo chmod 777 /run/screen
if [[ $? -ne 0 ]]; then 
    printf '\nERROR-4: chmod 755 %s failed!\n' "/run/screen"
    exit 4
fi 

#    sudo rm -fr /var/run/screen/*
#
#

SCREENRC_FILE="/etc/screenrc.d/usbcon-screenrc"

if [[ -f "${SCREENRC_FILE}" ]]; then 
    screen -d -m -c "${SCREENRC_FILE}" -S shared
else
    printf '\nERROR-9: cannot find file: %s\n' "${SCREENRC_FILE}"
    exit 9
fi
