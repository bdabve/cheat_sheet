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
echo -e "
    $Bold[+] lsof option to keep in mind:$colorOff

Default: Without options, lists all open files for active processes
-a      : AND the results(instead of OR)
-l      : Show the userID instead of the username in the output
-t      : Get process IDs only
-U      : Get the UNIX socket address
"
#
pause
#
echo -e "
    $Bold[+] Getting information about the Network:$colorOff

$Green$ lsof -i$colorOff                            # Show all open sockets
$Green$ lsof -i6$colorOff                           # Get only IPv6 traffic, you can use -i4
$Green$ lsof -iTCP$colorOff                         # Show only TCP Connections (works for UDP)
$Green$ lsof -i :22$colorOff                        # Working with port number
$Green$ lsof -i TCP:80$colorOff                     # Find which program is using the port 80

$Green$ lsof -i@192.168.1.5$colorOff                # List all connections to a specific host
$Green$ lsof -i@fw.google.com:2150=2180$colorOff    # Show open connections with a port range
$Green$ lsof -i@127.16.12.5$colorOff                # Show connection to a specific host
$Green$ lsof -i@127.16.12.5:22$colorOff             # Show connection to a specific host

$Green$ lsof -i -sTCP:LISTEN$colorOff               # Find listening ports
$Green$ lsof -Pnl +M -i4$colorOff                   # List all listening ports
$Green$ lsof -i | grep -i listen$colorOff           # Find listening ports
$Green$ lsof -i -sTCP:ESTABLISHED$colorOff          # Find ESTABLISHED Connections"
#
pause
#
echo -e "
$Bold[+] User Information:$colorOff
    $Green$ lsof -u dabve$colorOff                          # Show what a given user has open
    $Green$ lsof -u ^dabve$colorOff                         # All user except dabve
    $Green$ kill -9 \$(lsof -t -u dabve)$colorOff           # Kill everything a given user is doing

$Bold[+] Commands and Processes:$colorOff
    $Green$ lsof -c syslog-ng$colorOff                  # List all files/network connections a command is using
    $Green$ lsof -p 10075$colorOff                      # What a given process id has open.
    $Green$ lsof -t -c Mail$colorOff                    # The -t option returns just a PID

$Bold[+] Files and Directories:$colorOff
    $Green$ lsof </path/to/file>$colorOff               # List all processes accessing a particular file/directory
    $Green$ lsof /var/log/messages$colorOff             # Everythiing interacting with a givin directory.
    $Green$ lsof /home/dabve/bin/backup.sh$colorOff     # Everythiing interacting with a givin file.
    $Green$ lsof +f -- </mount/point>$colorOff          # useful for finding which process(es) are using a  mounted USB stick or CD/DVD.

$Bold[+] Advanced Usage:$colorOff
    $Green$ lsof -u dabve -i @1.1.1.1$colorOff             # Everything dabve is doing connected to 1.1.1.1
    $Green$ kill -HUP \$(lsof -t -c sshd)$colorOff          # Using -t -c to HUP Process

# See this primer: http://www.danielmiessler.com/study/lsof/ for a number of other useful lsof tips
"
