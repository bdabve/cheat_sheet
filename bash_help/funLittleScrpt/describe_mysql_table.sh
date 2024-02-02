#!/bin/bash
#:------------------------------------------------------------------------------
#: Date	        : 04-Feb-2016
#: Author       : Dabve
#: Descreption  : sending multiple commands to mysql from bash script
#: Option       : none
#:------------------------------------------------------------------------------
#
if [ -f /home/dabve/bin/lib/cliColor ];then
    . /home/dabve/bin/lib/cliColor;
fi
#
MYSQL=$( which mysql )
#
echo
echo -e "\t[*] Enter Data Base Informations\n"
echo -n "[+] User name: "; read -r user_name
echo -n "[+] Password: "; read -rs pass
echo -ne "\n[+] Data base name: "; read -r db
echo
#
$MYSQL -u "$user_name" --password="$pass" "$db" -e "SHOW TABLES"
#
echo -en "\n[+] Table name to describe: "; read -r table
$MYSQL -u "$user_name" --password="$pass" "$db" -e "DESCRIBE $table" -t;
#
if [ $? -ne 0 ];then
	echo -e "\n$Red[-] Ther was a problem, Please try again$colorOff"
fi
