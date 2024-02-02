#!/bin/bash
#: Title 	: menu
#: Date		: 01-Mar-2016
#: Author	: Dabve
#: Descreption	: This script show how to create a menu in a cmd
#: Option	: none

diskSpace(){
	clear
	df -k
}
whoseOn(){
	clear
	who
}
memUsage(){
	clear
	cat /proc/meminfo
}
menu(){
	clear
	echo -e "\t\t\tSys Admin Menu\n
	\t1. Display disk space
	\t2. Display logged on users
	\t3. Display memory usage
	\t0. Exit program\n\n"
	echo -en "\t\t Enter option: "
	read -n 1 option
}
######
while [ 1 ]; do
	menu
	case $option in
		0) break ;;
		1) diskSpace ;;
		2) whoseOn ;;
		3) memUsage;;
		*)clear; echo "Sorry, wrong selection";;
	esac
	echo -en "\n\n\t\t\tHit any [KEY] to continue"; read -n 1 line
done	
clear
