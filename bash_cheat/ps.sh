#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 03/02/2019 08:03:30 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#
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
#
ps_output(){
  clear
  echo -e "$Bold[+] PS Output:$colorOff

# The GNU ps command that’s used in Linux systems supports three different types of com-mand line parameters:
    * Unix-style parameters, which are preceded by a dash
    * BSD-style parameters, which are not preceded by a dash
    * GNU long parameters, which are preceded by a double dash

| Output    | Meaning
|-----------|-----------------------------------------------------------
| UID       | The user responsible for launching the process
| PID       | The process ID of the process
| PPID      | The PID of the parent process (if a process is started by another process)
| C         | Processor utilization over the lifetime of the process
| STIME     | The system time when the process started
| TTY       | The terminal device from which the process was launched
| TIME      | The cumulative CPU time required to run the process
| CMD       | The name of the program that was started

    "
    #
    pause
    #
echo -e "

[+] When we use the $Green$ ps -l$colorOff

* F       : System flags assigned to the process by the kernel.
* S       : The state of the process.
    - O   : running on processor.
    - S   : sleeping.
    - R   : runnable, waiting to run.
    - Z   : zombie, process terminated but parent not available.
    - T   : process stopped.
* PRI     : The priority of the process (higher numbers mean lower priority).
* NI      : The nice value, which is used for determining priorities.
* ADDR    : The memory address of the process.
* SZ      : Approximate amount of swap space required if the process was swapped out.
* WCHAN   : Address of the kernel function where the process is sleeping.
"
}
#
#
ps_bsd(){
    clear
    echo -e "$Bold[+] PS BSD STAT column output$colorOff

# Many system administrators like the BSD-style ${Bold}l$colorOff options because it produces a more detailed state code for processes (the STAT columns)
    $Green$ ps l$colorOff

- VSZ  : The size in kilobytes of the process in memory.
- RSS  : The physical memory that a process has used that isn't swapped out.
- STAT : A two-character state code representing the current process stat
    - < : The process is running at high priority.
    - N : The process is running at low priority.
    - L : The process has pages locked in memory.
    - s : The process is a session leader.
    - l : The process is multi-threaded.
    - + : The process is running in the foreground.
    "
}
ps_examples(){
    clear
    echo -e "$Bold[+] PS Examples$colorOff

    $Green$ ps -ef$colorOff                         # -e: all processes are running, -f: show a few useful columns
    $Green$ ps -e --forest$colorOff                 # process tree
    $Green$ ps -e --forest -C sshd$colorOff         # process tree for a givin process
    $Green$ ps au$colorOff                          # all process in BSD format or you can use $Bold$ ps aux$colorOff
    $Green$ ps -fU dabve$colorOff                   # a user's process.
    $Green$ ps -fu 1000$colorOff                    # By UID
    $Green$ ps -fG apache$colorOff                  # all processes owned by a certain group
    $Green$ ps -fp 1178$colorOff                    # processes by PID
    $Green$ ps -f --ppid$colorOff                   # process by PPID
    $Green$ ps -fp 2226,1154,1146$colorOff          # selection using PID
    $Green$ ps -t pst/0$colorOff                    # processes by tty

    $Green$ ps -e --format pid,ppid,user,cmd$colorOff       # format about a givin format
    $Green$ ps -L$colorOff                                  # all format

    # Top running processes by highest MEM usage
    $Green$ ps -e --format pid,ppid,cmd,%mem,%cpu --sort=-%mem - head$colorOff

    # Top running processes by highest CPU usage
    $Green$ ps -e --format pid,ppid,cmd,%mem,%cpu --sort=-%cpu - head$colorOff

    $Green$ ps -ef | egrep 'dabve|PID' | gawk '{print \$2 \" --> \" \$8}'$colorOff
    # Exclude grep from your grepped output of ps, add [] to the first letter. Ex: sshd -> [s]shd

    $Green$ ps aux | grep '[h]ttpd'$colorOff
    "
}
#
#
menu(){
    clear
    echo -e "${Bold}[+] PS Cheat Sheet:$colorOff

    1. PS Output
    2. PS BSD STAT column output.
    3. Examples.
    0. Exit"
    echo
    echo -en "$Bold[:]Choose From the Menu: $colorOff"; read -rn 1 Choice
}
#
while true; do
    clear
    menu
    case $Choice in
        1)  ps_output; pause ;;
        2)  ps_bsd; pause ;;
        3)  ps_examples; pause ;;
        0)  echo -e "\nBye"; exit 0 ;;
        *)  echo -e "\n[-] $Red Wrong Choice $colorOff"; pause ;;
    esac
done
