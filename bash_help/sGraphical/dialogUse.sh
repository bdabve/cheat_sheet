#!/bin/bash
#: Title 	:
#: Date		: 30-Jan-2016
#: Author	: Dabve
#: Version	:
#: Descreption	:
#: Option	:

pause(){
	printf "\nHit [ENTER] to continue\n"
	read -n 1
}
clear
printf "\n\t\tWelcome to $(basename $0)\n
SYNOPSIS
	dialog --clear
	dialog --create-rc file
	dialog --print-maxsize
	dialog common-options box-options

DESCRIPTION
       Dialog  is a program that will let you to present a variety of questions or display messages using dialog boxes from a shell script.  These
       types of dialog boxes are implemented (though not all are necessarily compiled into dialog):

	   buildlist, calendar, checklist, dselect, editbox, form, fselect, gauge, infobox, inputbox, inputmenu, menu, mixedform, mixedgauge,
	   msgbox (message), passwordbox, passwordform, pause, prgbox, programbox, progressbox, radiolist, rangebox, tailbox, tailboxbg,
	   textbox, timebox, treeview, and yesno (yes/no).

	You can put more than one dialog box into a script:

	. Use the "--and-widget" token to force dialog to proceed to the next dialog unless you have pressed ESC to cancel, or

        · Simply add the tokens for the next dialog box, making a chain.  Dialog stops chaining when the return code from a  dialog  is  nonzero,
	  e.g., Cancel or No (see DIAGNOSTICS).

	Some widgets, e.g., checklist, will write text to dialog's output. Normally that is the standard error, but there are options for changing
	this: "--output-fd", "--stderr" and "--stdout". No text is written if the Cancel button (or ESC) is pressed; dialog exits  immediately  in
	that case.\n"
pause
clear
printf "*) The EXIT code status of the dialog command:
	If an OK or Yes button is selected: returns a 0 exit status.
	If a Cancel or No button is selected: returns a 1 exit status.
	You can use the standard \$? variable to determine which button was selected\n\n"
printf "*) If a widget returns any data:
	the dialog command sends the data to STDERR. You can use the standard redirecting the STDERR output to another file or file descriptor:\n
	EXEMPLE:
		dialog --inputbox \"Enter your age:\" 10 20 2>age.txt\n"
pause
clear
printf "*) The msgbox widget EXEMPLE:\n"
echo -e "\t\t\e[1;36m\$dialog --title Testing --msgbox \"This is a test\" 10 20\e[0m"

printf "\n*) The yesno widget:\n"
echo -e "\t\t\e[1;36m\$dialog --title "Please answer" --yesno "Is this thing on?" 10 20\e[0m"
echo "after that you have to use \"echo \$?\" to determine which button was selected"

printf "\n*) The inputbox widget:\n"
echo -e "\t\t\e[1;36m\$dialog --inputbox \"Enter your age\" 10 20 2>age.txt\e[0m"
echo "The dialog command sends the value of the text string to STDERR. You must redirect that to retrieve the answer"

printf "\n*)The textbox widget:\n"
echo -e "\t\t\e[1;36m\$dialog --textbox /etc/passwd 15 45 \e[0m"

printf "\n*) The menu widget:\n"
echo -e "\t\t\e[1;36m\$dialog --menu \"Sys Admin Menu\" 20 30 10 1 \"Dis diskspace\" 2 \"Dis users\" 3 \"Dis memusage\" 4 \"Exit\" 2>test.txt \e[0m"

printf "\n*) The fselect widget:\n"
echo -e "\t\t\e[1;36m\$dialog --title "select a file" --fselect \$HOME/ 10 50 2>file.txt \e[0m"

