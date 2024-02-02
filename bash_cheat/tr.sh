#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
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
echo -e "$Bold[+] The tr command$colorOff

$Green$ echo 'Hello world' | tr [:lower:] [:upper:]$colorOff

$Green$ echo 'script_name.sh' | tr -d '_'$colorOff                  # -d for delete

$Green$ echo 'www.google....com' | tr -s '.'$colorOff               # Remove repeated character and leaving only one

$Green$ echo \$PATH | tr ':' '\\\n'$colorOff

$Green$ echo -n script file name.txt | tr '[:space:]' '_'$colorOff  # useful with file name that contains spaces

$Green$ tr -cd [:print:] < file.txt$colorOff                        # Remove all non-printable character from a file

$Green$ tr -s '\\\n' ' ' < file.txt$colorOff                         # Join all the lines in a file into a single line
"
