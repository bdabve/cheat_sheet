#!/bin/bash
#: Title 	: menu
#: Date		: 02-Feb-2016
#: Author	: Dabve
#: Descreption	: this menu is for all cmd-use
#: Option	: none

answer_cat=$( mktemp -t answer_cat.XXXXXX )
choise(){
	dialog --menu "Select from the menu" 10 30 10 1 "See file" 2 "Execute file" 2> $answer_cat
}
printf_use(){
	choise
	selection=$(cat $answer_cat)
	if [ $selection -eq  1 ];then
		cat printf_use.sh
	else
		./printf_use.sh
	fi
}
printf_use
