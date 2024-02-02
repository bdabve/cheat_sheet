#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#
# Sourcing cliColor from the lib directory
if [ -f /home/dabve/bin/lib/cliColor ]; then
    source /home/dabve/bin/lib/cliColor
fi
#
# Pause function
if [ -s /home/dabve/bin/lib/functions_lib ];then
    source /home/dabve/bin/lib/functions_lib
fi
#
#
change_editing_mode() {
    clear
    echo -e "
    $Bold[+] Change Editing Mode$colorOff

$ set -o emacs      // Change editing mode to emacs
$ set -o vi         // Change editing mode to vi
    "
}

emacs_editing_mode() {
    clear
    echo -e "
    $Bold[+] Emac's Editing Mode$colorOff

| Command           | 	Description
|-------------------|-------------------------------------------------
| ALT + b           | Move one word backward
| ALT + f           | Move one word forward
| ALT + Backspace   | Kill one word backward
| ALT + d           | Kill one word forward
| Ctrl + Left/right | Jump from word to word
|----------------------------------------------------------------------
| ALT + u           | Change word after point to all capital letters
| ALT + l           | Change word after point to all lowercase letters
| ALT + c           | Capitalize word after point
|----------------------------------------------------------------------
| Ctrl + y          | Retrieve last item killed
| Ctrl + a          | Move to beginning of line
| Ctrl + e          | Move to end of line
|----------------------------------------------------------------------
| Ctrl + k          | Delete forward to end of line
| Ctrl + u          | Delete backward to beginning of line
| Ctrl + w          | Delete everything to the begining of word
| Ctrl + y          | Retrieve killed text
|----------------------------------------------------------------------
| ALT  + <          | Move to first line of history list
| ALT  + >          | Move to last line of history list
| ALT + .           | Insert last word in previous cli after point
    "
}
#
completion_command() {
    clear
    echo -e "
    $Bold[+] Completion Command$colorOff

| Command       |       Description
|---------------|----------------------------------------
| Tab           | perform general completion of text
| ALT + ?       | List the possible completion
| ALT + /       | Attempt file-name completion
| ALT + ~       | Attempt user-name completion
| ALT + \$       | Attempt variable completion
| ALT + !       | Attempt command completion
| ALT + @       | Attempt host-name completion
| ALT + Tab     | Attempt completion from history list
|--------------------------------------------------------
| Ctrl + x + /  | List possible file-name completion
| Ctrl + x + ~  | List possible user-name completion
| Ctrl + x + $  | List possible variable completion
| Ctrl + x + !  | List possible command completion
| Ctrl + x + @  | List possible host-name completion
"
}
#
miscellaneous_commands() {
    clear
    echo -e "
    $Bold[+] Miscellaneous Command$colorOff

| Command               |   Description
|=======================|==============================================================================
| Ctrl + j              | Same as RETURN
| Ctrl + m              | Same as RETURN
| Ctrl + o              | S A RETURN, Then display next line in cmd history
| Ctrl + t              | Transpose two character on either side of point and move point forward by one
| Ctrl + v              | Quoted insert
| Ctrl + [              | Same as ESC (most keyboard)
| ALT + _               | Same as ESC + .
| CTRL-\\                | Stop current cmd if CTRL-c doesn't work
| CTRL-S                | Halt output to screen
| CTRL-Q                | Restart output to screen
    "
}
#
menu(){
    clear
    echo -e "${Bold}Emac's Editing Mode:$colorOff

    1. Change Editing Mode
    2. Emac's Editing Mode
    3. Completion Command
    4. Miscellaneous Commands
    0. Exit"

    echo -en "\nChoose From the Menu: "
    read -rn 1 Choice
}
#
while true; do
    menu
    case $Choice in
        1)  change_editing_mode; pause ;;
        2)  emacs_editing_mode; pause ;;
        3)  completion_command; pause ;;
        4)  miscellaneous_commands; pause ;;
        0)  echo -e "\nBye"; exit 0 ;;
        *)  echo -e "\n\n[-] $Red Wrong Choice $colorOff"; pause ;;
    esac
done
