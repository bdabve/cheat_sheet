#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 03/03/2019 07:17:40 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
# Sourcing cliColor from the lib directory
if [ -f "/home/dabve/bin/lib/cliColor" ]; then
    source "/home/dabve/bin/lib/cliColor"
fi
#
# Pause function
if [ -s "/home/dabve/bin/lib/functions_lib" ];then
    source "/home/dabve/bin/lib/functions_lib"
fi
#
clear
echo -e "$Bold[+] read Options$colorOff

-a  : Read values into an array
    $Green$ read -a people$colorOff     # echo \${people[2]}

-d  : Read a line up until the first character of the delimiter is reached
    $Green$ read -d k aline$colorOff    # If user type k read will quit

-p  : Prompt
-n  : Specifies how many characters will be read
-r  : Input lets you input lines that are longer than the width your display by providing a backslash as a continuation character.
    : Also preserves any other escape sequences the input might contain.
-s  : Not echo the characters that are typed to the terminal. useful with passwords
-t  : Allows a time in seconds to be specified. read will wait the specified time for input and then finish."
echo
