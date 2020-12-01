#!/bin/bash
#
# adduser-developer.sh
#

USER_PASSWORD="bsplab"
USER_GROUP="developer"
b_DEL_USER=0

if [ "$1" = "--deluser" ] ; then 
    shift 1
    b_DEL_USER=1
fi 

NEW_USER="$1"
LOOP=0
while [[ ! "${NEW_USER}" == "" ]] ; 
do 
    LOOP=$((LOOP+1))
    if [ ${b_DEL_USER} -ne 0 ] ; then 
        cat /etc/passwd | grep ${NEW_USER} >/dev/null
        if [ $? -eq 0 ] ; then 
            printf '\n Warning: delete user and its home dir: \"%s\"' "${NEW_USER}"
            read -p " Are you sure? (Yes/No/Skip)" -n 1 -r
            echo    # (optional) move to a new line
            printf '\nINFO: REPLY=%s\n' "${REPLY}"
            # 
            if [[ ! ${REPLY} =~ ^[YySs]$ ]] ; then
                if [[ "$0" == "${BASH_SOURCE}" ]] ; then 
                    printf '\n aborted this shell script: %s !\n' "$0"
                    exit 10
                else
                    printf '\n return from this shell script: %s\n' "$0"
                    return 1
                fi         
            elif [[ ${REPLY} =~ ^[Yy]$ ]] ; then 
                sudo userdel ${NEW_USER}
                if [ $? -eq 0 ] ; then 
                    printf '\nERROR-11: sudo userdel %s failed!\n' "${NEW_USER}"
                    exit 11
                fi 
                if [ -d "/home/${NEW_USER}" ] ; then  
                    sudo rm -rf /home/${NEW_USER}
                    if [ $? -eq 0 ] ; then 
                        printf '\nERROR-12: sudo rm -rf %s failed!\n' "/home/${NEW_USER}"
                        exit 12 
                    fi 
                else
                    printf '\nUser Home dir \"%s\" not found!\n' "/home/${NEW_USER}"
                fi
            else
                printf '\nINFO: SKIP delete user \"%s\"\n' "${NEW_USER}"
            fi
        else 
            printf '\nINFO: user \"%s\" not found in /etc/passwd!\n' "${NEW_USER}"
        fi
    fi 
#
    cat /etc/passwd | grep ${NEW_USER} >/dev/null
    if [ $? -eq 0 ] ; then 
        printf '\nERROR-1: user \"%s\" already exist!\n' "${NEW_USER}"
        exit 1
    fi 
#
    sudo useradd --create-home --password "${USER_PASSWORD}" -g "${USER_GROUP}" ${NEW_USER}
    if [ $? -ne 0 ] ; then 
        printf '\nERROR-2: \"sudo useradd %s\" failed!\n' "${NEW_USER}"
        exit 2
    fi
#
    sudo usermod -g developer ${NEW_USER}
    if [ $? -ne 0 ] ; then 
        printf '\nERROR-3: \"sudo usermod -g developer %s\" failed!\n' "${NEW_USER}"
        exit 3
    fi
#
    sudo usermod -aG sudo ${NEW_USER}
    if [ $? -ne 0 ] ; then 
        printf '\nERROR-4: \"sudo usermod -aG sudo %s\" failed!\n' "${NEW_USER}"
        exit 4
    fi
#
    printf '\nset new passwored for %s\n' "${NEW_USER}"
    sudo passwd ${NEW_USER}
    shift 1 
    NEW_USER="$1"
done

if [ ${LOOP} -eq 0 ] ; then 
    printf '\nERROR-9: no input user name found!\n'
    exit 9
else
    printf '\n %d user added\n\n' ${LOOP}
fi 

