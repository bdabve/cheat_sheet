#!/bin/bash
#: Title 	: quik-menu
#: Date		: 29-Jan-2016
#: Author	: Dabve
#: Descreption	: This script alow you to create a quik menu
#: Option	: none

# Creating function
diskspace(){
	clear
	df -k
}

whoseon(){
	clear
	who
}

memusage(){
	clear
	cat /proc/meminfo
}

PS3="Enter Option (1-4): "
select option in "Display disk space" "Display logged on users" "Display memory usage" "Exit program"; do
	case $option in
		"Exit program")
			break;;
		"Display disk space")
			diskspace ;;
		"Display logged on users")
			whoseon ;;
		"Display memory usage")
			memusage ;;
		*)
			clear
			echo "Sorry, wrong selection";;
	esac
done
clear
exit

