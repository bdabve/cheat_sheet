#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#
# Sourcing cliColor from the lib directory
if [ -s "/home/dabve/bin/lib/cliColor" ]; then
    source "/home/dabve/bin/lib/cliColor"
fi
#
# Pause function
if [ -s "/home/dabve/bin/lib/functions_lib" ];then
    source "/home/dabve/bin/lib/functions_lib"
fi
#

move(){
    clear
    echo -e "
    $Bold[+] Directory specific shurtcuts$colorOff

| Key   | Meaning
|-------|-------------------
| gh    | cd ~
| ge    | cd /etc
| gu    | cd /usr
| gd    | cd /dev
| go    | cd /opt
| gv    | cd /var
| gm    | cd /media
| gM    | cd /mnt
| gr    | cd /
| gR    | cd to ranger's global configuration directory
    "
}
#
files(){
    clear
    echo -e "
    $Bold[+] Working with Files$colorOff

| Key   | Meaning
|-------|-------------------
| i     | Display file in a pager
| I or E| Open file in default file-handler
| r     | Open file with ...(allow you to choose program to use)
| o     | Change sort order
| z     | Change settings
| zh    | View hidden files
| space | Select current file
| t     | Tag file (you can perform actions on tagged files)
| cw    | Rename current file
| /     | Search for files
| n     | Jump to previous match
| yy    | Yank (copy) file
| dd    | Mark file for cut operation
| dD    | Delete selected files
    "
}
#
#
general_options(){
    clear
    echo -e "
    $Bold[+] General Options$colorOff

| Key   | Meaning
|-------|-------------------
| ?     | View ranger man page
| R     | Reload current directory
| q     | Quit ranger
| !     | Execute a command from the shell
| :     | Execute a ranger command
| du    | Measure disk usage of current directory
| chmod | Change permissions of current file
| %f    | Substitute highlighted file
| %d    | Substitute current directory
| %s    | Substitute currently selected files
| %t    | Substitute current tagged files

# Change the names of multiple files, we could select them all with space, after that, we type:
:bulkrename %s

# It gives you every file you'd like to change in a text editor
"
}
#
menu(){
    clear
    echo -e "$Bold[+] Ranger keybinding :$colorOff

    1. Move
    2. Working with files
    3. General Options
    0. Exit"
    echo
    echo -en "$Bold[:]Choose From the Menu: $colorOff"; read -rn 1 Choice
}
#
while true; do
    clear
    menu
    case $Choice in
        1)  move; pause ;;
        2)  files; pause ;;
        3)  general_options; pause;;
        0)  echo -e "\nBye"; exit 0 ;;
        *)  echo -e "\n[-] $Red Wrong Choice $colorOff"; pause ;;
    esac
done
