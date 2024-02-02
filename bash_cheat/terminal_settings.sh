#!/bin/bash
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
clear
echo -e "$Bold[+] Terminal Settings Commands$colorOff

$Green$ tty$colorOff                     # Current tty
$Green$ stty -a$colorOff                 # Terminal Current settings
$Green$ stty -echo$colorOff              # Turns off screen echo usefull with password read.
$Green$ stty echo$colorOff               # Restore screen echo.
$Green$ stty -g$colorOff                 # Save old settings.
$Green$ stty erase '#'$colorOff          # Set '#' as erase character instead of baskspace
$Green$ stty cols n$colorOff             # Set columns to N number

# The setterm command can be used to change the appearance of text written to stdout
$Green$ settterm -cursor off$colorOff
$Green$ setterm -bold on$colorOff

# tset command show or initialize terminal settings. This is a less capable version of stty
$Green$ tset -r$colorOff                  # terminal type

# The mesg command Enables or Disables write access to the current user's terminal.
$Green$ dmesg$colorOff             # With no arguments show mesgs status.
$Green$ dmesg y$colorOff           # Allow mesgs
$Green$ dmesg n$colorOff           # Disallow mesgs

# The wall command: Sending a message to all users at every terminal logged into the machine and network
$Green$ wall 'System going down for maintenance in 5 minutes!'$colorOff

# The write command: send a msg to another user.
Syntax: $Greenwrite user [ttyNumber]$colorOff"
