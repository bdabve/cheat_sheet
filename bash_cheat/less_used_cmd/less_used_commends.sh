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
## Collection of Less Commonly Used Commands:

* join        : like a database join but for text
* comm        : file comparison like a db join
* paste       : put lines in a file next to each other
* rs          : reshape arrays
* jot         : generate data
* expand      : replace spaces and/or tabs
* time        : track time and resourcing
* watch       : execute something on a schedule in realtime
* iftop       : visually show network traffic
* jnettop     : a more detailed iftop
* xxd         : manipulate files in hex
* mtr         : powerful traceroute replacement
* iotop       : i/o stats
* dig         : dns queries
* host        : dns queries
* man ascii   : lookup your ascii
"
#
pause
echo -e "
* sshfs       : mount a directory through ssh
* dstat       : powerful system statistics
* tmux        : a better screen
* jq          : command line JSON parsing
* pushd       : push your pwd to a stack
* popd        : pop pwd off your stack
* ncat        : nmap-based replacement for nc
* fuser       : kills locking processes
* tac         : cat in reverse
* slurm       : network interface stats
* bmon        : a simple bandwidth monitor
* lsmod       : show kernel modules
* timeout     : execute something and kill it soon after
* disown      : protect a job from disconnect
* pgrep       : greps through processes
* pkill       : kills processes based on search
* fmt         : text formatter
* multitail   : see logs in separate views
* apropos     : info on commands
* strace      : the uber debug tool
"
#
pause
#
echo -e "
* man units   : interesting
* pstree      : shows processes in a…well…tree
* ddate       : wtf
* zgrep       : grep within compressed files
* zless       : look at compressed files
* nping       : nmap-based custom packet creation
* readlink    : read values of links
* iostate     : look at your disk i/o
* atop        : another top
* split       : break a file into pieces
* ndiff       : show differences in nmap scans"
