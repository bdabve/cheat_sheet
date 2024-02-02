#!/bin/bash
#:------------------------------------------------------------------------------
#: Title        : sendDataMysql
#: Date	        : 06-Feb-2016
#: Author       : Dabve
#: Descreption	: this script help to send somme data to mysql databases
#: Option       : you have to specifie 4 argument
#:------------------------------------------------------------------------------
#
if [ -f /home/dabve/bin/lib/cliColor ];then
    . /home/dabve/bin/lib/cliColor;
fi
#
MYSQL=$( which mysql )
#
#
if [ $# -ne 4 ];then
	echo -e  "\nUsage: $(basename "$0") empid lastname firstname salary\n"
else
    echo
    echo -e "\t[*] Enter Data Base Informations\n"
    echo -ne "[+] User name: "; read -r user_name
    echo -ne "[+] Data base name: "; read -r db
    echo -ne "[+] Table name: "; read -r table
    echo -n "[+] "
	statement="INSERT INTO $table VALUES('$1', '$2', '$3', '$4');"
    fetch="SELECT * FROM $table;"
	$MYSQL -u "$user_name" -p "$db" -t<<EOF
	$statement
    $fetch
EOF
  if [ $? -eq 0 ];then
	echo -e "\n$Green[+] Data succefully added$colorOff"
  else
	echo -e "\n$Red[-] Problem adding data$colorOff"
  fi
fi
