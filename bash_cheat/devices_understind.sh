#!/bin/bash -
#===============================================================================
#
#          FILE: devices_understind.sh
#         USAGE: ./devices_understind.sh
#
#   DESCRIPTION: Devices
#
#        AUTHOR: Dabve (), bdabve@gmail.com
#       CREATED: 07/07/2019 01:35:11 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#
if [ -f /home/dabve/bin/lib/cliColor ]; then
    source /home/dabve/bin/lib/cliColor
fi
#
clear
echo -e "
- The driver code allows the kernel to pass data back and forth to the device, acting as a middle man between applications and hardware.
- Two methods are used for inserting device driver code in the linux kernel
    - Drivers compiled in the kernel
    - Driver modules added to the kernel


[+] Block device:
    - Block files are for devices that can handle data in a large blocks at a time, such as disk drives.
    - Programs access data in a block device in fixed chunks.
    - A block device's total size is fixed, and a program has random access to any block in the device.

[+] Character device:
    - Character device files are for devices that can only handle data one character at a time.
    - Most types of modems and terminals are created as character files.
    - Work with data streams. You can only read characters from or write characters to these devices, like /dev/null.
    - Character devices don't have a size; when you read or wrie to a character device, the kernel usually performs a read or write operation on
      device, leaving no record of the activity inside the kernel.
    - Printers are character devices, and after the kernel sends data to a printer, the responsibility for that data passes to the printer,
      the kernel cannot back up and reexamine the data stream.

[+] The newtwork file types are used for devices tha use packets to send and receive data. This includes network cards and a
    special loopback device that allows the Linux system to communicate with itself using common network programming protocols.

[+] Pipe device:
    - Named pipes are like character devices, but there is another process at the other end of the I/O stream instead of a kernel driver.

[+] Socket device:
    - Sockets are special-purpose I/O files offering a type of network interface.

[*] Device Name Summary
    - Guess the name from the output of the ${Green}dmesg$colorOff command.
    - Run $Green$ cat /proc/devices$colorOff: Each line consist of a number and name. The number is the major number of the device.
"
