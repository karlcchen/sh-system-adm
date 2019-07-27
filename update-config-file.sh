#!/bin/bash
# check out a config file and upadte with "make menuconfig" 
# file is not submitted afterward if changed
# 
# 



export ANSI_COLOR_BOLD_RED="\033[01;31m"
export ANSI_COLOR_BOLD_GREEN="\033[01;32m"
export ANSI_COLOR_BOLD_YELLOW="\033[01;33m"
export ANSI_COLOR_BOLD_BLUE="\033[01;34m"
export ANSI_COLOR_DEFAULT="\033[00m"
export HIGHLIGHT_ON="\033[01;32m"
export HIGHLIGHT_OFF="\033[00m"

export DO_P4=""
export CONFIG_DIR=../config/armada

Prog_Basename=`basename "$0"`

#
#
#
Usage() {
cat <<EOF

The utility is used to edit( menuconfig) a (embedded_rootfs) configuration file 
the difference before and after menuconfig will be displayed with highlight text

Usage: $Prog_Basename [options] config_file_name

    options:
	-p,--with-p4  	check out file with perforce first 

Example: check out config file (diag-octeon.config) with p4 and edit it with menuconfig 

    $Prog_Basename -p diag-octeon.config

The exit status is 0 if no errors are encountered.  The exit status
is 1 if an error occurred or if the --help option was used.

EOF
    exit 1
}

if [ "$1" = "" ] ; then
    Usage
    exit 9 
fi 

CONFIG_FILE="$1".config
CONFIG_FILE_FULLPATH="${CONFIG_DIR}/${CONFIG_FILE}"

if [ ! -f "${CONFIG_FILE_FULLPATH}" ] ; then 
    echo -e "\n ERROR: ${CONFIG_FILE_FULLPATH} not found !\n" 
    exit 1
fi 

cp ${CONFIG_FILE_FULLPATH} .config
if [ $? -ne 0  ] ; then 
    echo -e "\n ERROR: copy ${CONFIG_FILE_FULLPATH} to .config failed!\n" 
    exit 3
fi 

make menuconfig
if [ $? -ne 0  ] ; then 
    echo -e "\n ERROR: make menuconfig failed!\n" 
    exit 4
fi 
#
# 
echo -e "$ANSI_COLOR_BOLD_YELLOW=== Difference with previous \"make menuconfig\" of \"${CONFIG_FILE_FULLPATH}\":" 
echo -e "$HIGHLIGHT_ON"
diff ${CONFIG_FILE_FULLPATH} .config
if [ $? -ne 0  ] ; then 
    echo -e "$HIGHLIGHT_OFF"
    echo -e "File $HIGHLIGHT_ON\"${CONFIG_FILE_FULLPATH}\"$HIGHLIGHT_OFF modified\n" 
    cp .config $CONFIG_FILE_FULLPATH
    if [ $? -ne 0  ] ; then 
        echo -e "\n ERROR: copy \".config\" to \"${CONFIG_FILE_FULLPATH}\" failed!\n" 
        exit 5
    fi 
else
    echo -e "$HIGHLIGHT_OFF"
    echo -e "${ANSI_COLOR_BOLD_RED}No Modification:${HIGHLIGHT_OFF} \"${CONFIG_FILE_FULLPATH}\"\n" 
fi 

echo -e "$HIGHLIGHT_OFF"
exit 0

