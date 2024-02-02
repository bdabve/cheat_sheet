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
## SysRq Command Key:

# sysrq == impec
# It is often used to recover from freezes, or to reboot a computer without corrupting the filesystem.
# The key combination consists of: ${Bold}Alt+SysRq+commandkey$colorOff.
# In many systems the SysRq key is the printscreen key.

| Key   | Meaning
|-------|---------------------------------------------------------------
| k     | Kills all the process running on the current virtual console
| s     | This will attempt to sync all the mounted file system
| b     | Immediately reboot the system, without unmounting partitions or syncing
| e     | Send SIGTERM to all process except init
| m     | Output current memory information to the console
| i     | Send the SIGKILL signal to all process except init
| r     | Switch the keyboard from raw mode (the mode used by programs such as X11), to XLATE mode
| s     | Sync all mounted file system.
| t     | Output a list of current tasks and their information to the console.
| u     | Remount all mounted filesystems in readonly mode.
| o     | Shutdown the system immediately.
| p     | Print the current registers and flags to the console.
| 0-9   | Sets the console log level, controlling which kernel messages will be printed to your console.
| f     | Will call kill to kill process which takes more memory.
| h     | Used to display the help. But any other keys than the above listed will print help.

* We can also do this by echoing the keys to the ${Bold}/proc/sysrq-trigger$colorOff file.
* For example, to re-boot a system you can perform the following.

  $Green$ echo 'b' > /proc/sysrq-trigger$colorOff
"
#
pause
#
echo -e "
* To perform a safe reboot of a Linux computer which hangs up, do the following.
* This will avoid the fsck during the next re-booting.
* i.e Press: ${Bold}Alt+SysRq+letter$colorOff highlighted below.

| Letter    | Meaning
|-----------|-----------------------------------------------
| unRaw     | take control of keyboard back from X11,
| tErminate	| send SIGTERM to all processes, allowing them to terminate gracefully
| kIll      | send SIGKILL to all processes, forcing them to terminate immediately
| Sync      | flush data to disk
| Unmount 	| remount all filesystems read-only
| reBoot.

# The ${Bold}/proc/sysrq-trigger$colorOff file takes one of the keys and behaves as if a user had pressed ${Bold}Ctrl+alt+sysrq$colorOff plus that key on the system console.
# Example: $Green$ echo h > /proc/sysrq-trigger$colorOff
"
