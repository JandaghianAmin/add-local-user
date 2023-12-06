#!/bin/bash

#scripts to add local user
#just root user and sudo can createuser

if [[ "${UID}" -ne 0 ]]
then
	echo "you shoud be root or run as sudo user."
fi

if [[ "${#}" -lt 1 ]]
then
	echo "at lease one argument is needed: USER_NAME"
	exit 1
fi

USER_NAME="${1}"
shift
COMMENTS="${@}"

read -p "You'r username would be ${USER_NAME} accept? y/n :" USER_CONFIRM


if [[ ${USER_CONFIRM} != "y" ]]
then
	echo "user creations canceled by user"
	exit 1
fi	
	
useradd -c "${COMMENTS}" -m "${USER_NAME}"

PASSWORD=${RANDOM}

echo ${USER_NAME}:${PASSWORD} | chpasswd 

passwd -e ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
	echo "user not created."
	exit 1
fi	


echo "user: ${USER_NAME} with password:${PASSWORD}"
exit 0
