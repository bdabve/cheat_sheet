#!/bin/bash -
#===============================================================================
#
#          FILE: sendMsgTty.sh
#
#         USAGE: ./sendMsgTty.sh
#
#   DESCRIPTION: This shell script utility helps you to quickly send a message
# 		 to someone who is logged onto your linux system.
#       OPTIONS: User to send him/her email
#  REQUIREMENTS: Messages allowed.
#        AUTHOR: daBve (), dabve@outlook.fr
#       CREATED: 05/01/2016 13:57
#===============================================================================

# To check if message are allowed enter this command: <mesg>
# If the result: <is y> message would be allowed.
# To allow message use this command: <mesg y>

# To check everyone else's message status, you can use <who -T> command
# the <-> after each user name indicates that messaging is turned off
# the <+> messaging is turned on

#================================================================================

# Save the username parameter
#
muser=$1
#
# Determine if user is logged on:
#
logged_on=$(who | grep -v "?" 2>/dev/null | grep -i -m 1 "$muser" 2>/dev/null | gawk '{print $1}' )
#
if [ -z "$logged_on" ];then
	echo "[-] $muser is not logged on."
	echo "[-] Exiting script...."
	exit
fi
#
# Determine if user allows messaging:
#
allowed=$(who -T | grep -v "?" | grep -i -m 1 "$muser" | gawk '{print $2}')
#
if [ "$allowed" != "+" ];then
	echo "[-] $muser does not allowing messaging."
	echo "[+] Exiting script...."
	exit
fi
#
# Determine if a message was included:
#
if [ -z "$2" ];then
	echo "[-] No message parameter included."
	echo "[-] Exiting script...."
	exit
fi
#
#
# Determine if there is more to the message
#
shift
while [ -n "$1" ];do
	whole_message=$whole_message' '$1
	shift
done
#
# Send message to user:
#
uterminal=$(who | grep -v ":0" | grep -i -m 1 "$muser" | gawk '{print $2}')
#
# Transmit the message
echo "$whole_message" | write "$logged_on" "$uterminal"
#
exit
