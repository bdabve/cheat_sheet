#!/bin/bash
#
# Command Line Kung Fu
# By Jason Cannon
#
# Import cliColor
if [ -f '/home/dabve/bin/lib/cliColor' ]; then
    . /home/dabve/bin/lib/cliColor
fi
#
# Pause Function
if [ -s /home/dabve/bin/lib/functions_lib ];then
    source /home/dabve/bin/lib/functions_lib
fi
# ----------
# Shell History
shellHistory(){
    clear
    echo -e "\t$Bold[*] Shell History:$colorOff

    $Green $ ping -c1 !^$colorOff   # reuse the first arg from the previous cmd
    $Green $ rm -r !$ $colorOff     # reuse the last arg from the previous cmd

[+] Reuse the Nth Word from a Previous Command
    $Green $ avconv -i screencast.mp4 podcast.mp3$colorOff
    $Green $ mv !!:2 converted/$colorOff                        # mv screencast.mp4 converted/

[+] find out which commands you use most often
    $Green$ history | awk '{print \$2}' | sort | uniq -c | sort -rn | head$colorOff
"
}
# ----------
# Text Processing and Manipulation
textProcessingManipulation(){
    clear
    echo -e "\t$Bold[*] Text Processing and Manipulation:$colorOff"
    echo -e "
    $Green $ grep -E -v '^#|^$' httpd.conf | head$colorOff  # strip out comments and blank lines

    $Green $ awk -F: '{print \$1,\$NF}' /etc/passwd | sort | column -t$colorOff     # Grab the Last Word on a Line of Output.

    $Green $ ls --color=always -l /etc | less -R$colorOff                   # View Colorized Output with Less
    $Green $ ls -l --color=always *mp3 | grep --color=never jazz$colorOff   # Preserve Color When Piping to Grep.

    $Green $ echo 'PRODUCTION Environment' | sudo tee -a /etc/motd$colorOff # Append Text to a File Using Sudo.
    $Green $ echo \$PATH | tr ':' '\\\n'$colorOff       # Display Your Command Search Path in a Human Readable Format

    $Green $ sudo dmidecode | awk /Processor/,/Manuf/$colorOff  # display a Block of Text between Two Strings, dmidecode Good cmdline

    $Green $ sed '/#/,/^$/d' ports.conf$colorOff                # delete a Block of Text between Two Strings

[+] Use a Spreadsheet from the Command Line:
    $Green $ sc$colorOff                    # /usr/share/doc/sc/tutorial.sc"
}
# ----------
# Networking
networking(){
    clear
    echo -e "\t$Bold[*] Networking:$colorOff"
    echo -e "
    $Green $ curl ifconfig.me || curl ifconfig.me/ip || curl ifconfig.me/host$colorOff # public IP

[+] Show Open Network Connections
    $Green $ sudo lsof -Pni$colorOff
    -P: conversion of port numbers to port names.
    -n: prevents the conversion of IP addresses to host names.
    -i: tells lsof to display network connections.

    $Green $ echo 'message' | mail -s 'subject' recipient@domain.com$colorOff   # Send Email from the Command Line:

    $Green $ echo 'message' | mail -s 'subject' -a /path/to/attachment recipient@domain.com$colorOff # Email with Attachment

[+] Find out Which Programs Are Listening on Which Ports:
    $Green $ sudo netstat -nutlp$colorOff
    -n: show numerical addresses instead of determining symbolic names
    -u: UDP protocol
    -t: TCP protocol
    -l: show only listening sockets
    -p: show the PID and program name
"
}
# ----------
# System Administration
systemAdministration(){
    clear
    echo -e "\t$Bold[*] System Administration:$colorOff"
    echo -e "
    $Green $ sudo pkill -9 httpd $colorOff                          # kill Command and all processes
    $Green $ sudo killall -u bob sshd $colorOff                     # Kill command by user

[+] Find Who Is Using the Most Disk Space:
    $Green$ sudo du -s /home/* | sort -n$colorOff
    $Green$ ncdu /home$colorOff

    $Green$ sudo find /var -xdev -type f -exec wc -c {} \; | sort -n$colorOff # Find the Files That Are Using the Most Disk Space:

    $Green$ ps aux| head -1 && ps aux | sort -nk 4 | tail -5$colorOff          # list Processes, Sorted by Memory Usage:
    $Green$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head$colorOff
    $Green$ ps aux| head -1 && ps aux | sort -nk 3 | tail -5$colorOff           # list Processes, Sorted by CPU Usage:
    $Green$ ps -e --format pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head$colorOff

[+] Execute a Command at a given Time:
    $Green $ echo 'reboot' | at midnight$colorOff
    $Green $ atq $colorOff                               # To list your at jobs with atq
    $Green $ atrm N $colorOff                            # Delete your at job with atrm.

"
}
# ----------
# Files and Directories
fileDirectories(){
    clear
    echo -e "\t$Bold[*] files and directories:$colorOff

$Green $ cd -$colorOff  # Change to the Previous Working Directory

$Green$ sudo cp /etc/passwd{,.bak} $colorOff       # make a Backup of a File
$Green$ mv report.{txt,doc}$colorOff
$Green$ mv jazz{,.mp3}$colorOff                    # change extension.
$Green$ sudo cp httpd.conf httpd.conf.\$(date +%F)$colorOff        # create a backup with date, alias d='date +%F'

$Green$ tail -f /var/log/syslog$colorOff               # follow a file as it grows.

$Green$ find . -type d -empty -delete$colorOff         # delete Empty Directories and Files, -type f for file (DANGER)

$Green$ sudo grep -lr dabve /var/log$colorOff      # print a list of files That Contain a given String

$Green$ find /path -type f -exec sed -i.bak 's/string/replacement/g' {} \;$colorOff # Replace a String in Multiple Files

$Green$ awk 'NR==74' fileName.sh $colorOff     # Extract the Nth Line from a File:"
}
# ----------
# menu
menu(){
    clear
    echo -e "$Underline Welcome To Command Line Kung Fu:$colorOff

    1. Shell History.
    2. Text Processing and Manipulation.
    3. Networking.
    4. System Administration.
    5. Files and Directories.
    0. Exit"

    echo -en "\nChoose From the Menu: "
    read -rn 1 choise
}
#
# ------------------------- Main Script
while true; do
    menu
    case $choise in
        1)  shellHistory
            pause
            ;;
        2)  textProcessingManipulation
            pause
            ;;
        3)  networking
            pause
            ;;
        4)  systemAdministration
            pause ;;
        5)  fileDirectories
            pause
            ;;
        0)  exit 0
            ;;
        *)  echo -en "\n\n$Red[-] Wrong choice :("
            pause
            ;;
    esac
    clear
done
