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
groffCommand()
{
	echo -e "
    $Bold[+] The GROFF Command:$colorOff
# groff is a suite of programs containing the GNU implementation of troff.
# It also includes a script that is used to emulate nroff and the rest of the roff family as well.
# This utility acts like a compiler for the input supplid (plain text content and formatting commands) to it and it creates a formatted document as its ouput

# Example:
	$Green$ zcat /usr/share/man/man1/ls.1.gz | groff -mandoc -T ascii | head$colorOff"
zcat /usr/share/man/man1/ls.1.gz | groff -mandoc -T ascii | head
echo -e "$Green$ zcat /usr/share/man/man1/ls.1.gz | groff -mandoc > ~/desktop/man-ls.ps$colorOff"
zcat /usr/share/man/man1/ls.1.gz | groff -mandoc > ~/desktop/man-ls.ps
echo -e "# NOTE: Linux systems often include many comman line program for file format conversion. They are named: \e[0;32mformat2format\e[0m"
#
pause
#
echo -e "\t\e[1;4mOur sed example for Linux distros:\e[0m"
cat /home/dabve/bin/configFile/distros-groff.sed
echo -e "\t\e[0;32msort -k 1,1 -k 2n $DISTROS | sed -f /home/dabve/bin/configFile/distros-groff.sed | groff -t -T ascii 2>/dev/null\e[0m"
sort -k 1,1 -k 2n "$DISTROS" | sed -f /home/dabve/bin/configFile/distros-groff.sed | groff -t -T ascii 2>/dev/null
echo -e "\t\e[0;32msort -k 1,1 -k 2n $DISTROS | sed -f /home/dabve/bin/configFile/distros-groff.sed | groff -t > ~/desktop/man-ls1.ps\e[0m"
sort -k 1,1 -k 2n "$DISTROS" | sed -f /home/dabve/bin/configFile/distros-groff.sed | groff -t > ~/desktop/man-ls1.ps
}

