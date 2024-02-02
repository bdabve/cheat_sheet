#!/bin/bash
#============================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019
#===========================================

set -o nounset        # Treat unset variables as an error
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
wildcardAndPathnameExpansion(){
    clear
    echo -e "$Bold[+] Wildcard And Pathname Expansion:$colorOff

Expression      | 		Matches
-----------------------------------------------------------
[abc]           | a, b, or c
[.,;]           | Period, comma, or semicolon
[-_]            | Dash or underscore
[a-c]           | a, b, or c
[a-z]           | All lowercase letters
[!0-9]          | All non-digits
[!.;]           | Matches any character except period and semicolon;
[0-9!]          | All digits and exclamation point
[a-zA-Z]        | All lower- and uppercase letters
[a-zA-Z0-9-_]   | All letters, digits, underscore, dash
------------------------------------------------------------

    $Green$ ls /usr*$colorOff            # list all file in /usr and /usr2.
    $Green$ ls /usr*/[be]*$colorOff      # list all file in /usr and /usr2 beginning with b and e.
    $Green$ ls *.[cho]$colorOff          # list all file end in period(.) followed by a c, h, or o "
}
#
#
braceExpansion(){
    clear
    echo -e "$Bold[+] Brace Expansion:$colorOff

    $Green$ echo b{ed,olt,ar}s$colorOff         # beds, bolts, and bars
    $Green$ echo b{ar{d,n,k},ed}s$colorOff      # bards, barns, barks, and beds.
    $Green$ echo {2..5}$colorOff                # 2 3 4 5.
    $Green$ echo {2...5}$colorOff
    $Green$ echo {2..8}$colorOff
    $Green$ echo {d..h}$colorOff                # d e f g h.

    $Green$ ls *.{c,h,o}$colorOff.
    $Green$ mkdir -p app/{lib,bin,dir}          # app/lib, app/bin, app/dir"
}
#
#
#
menu(){
    clear
    echo -e "\n$Bold[+] Files in linux:$colorOff

    1. wildcard and pathname expansion.
    2. brace expansion.
    0. exit"
    echo -en "\n$Bold[:] Your Choice: $colorOff"
    read -rn 1 choice
}
# ------------------------- Main Script
#
while true; do
    menu
    case $choice in
        1)  wildcardAndPathnameExpansion;  pause ;;
        2)  braceExpansion;  pause ;;
        0)  echo -e "\nBye"; exit 0 ;;
        *)  echo -en "$Red[-] Wrong choice "; pause
            ;;
    esac
done

