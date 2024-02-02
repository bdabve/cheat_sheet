#!/bin/bash -
#===============================================================================
#
#          FILE: formatUSB.sh
#   DESCRIPTION: Format a USB memory stick with, From ubuntu kung fu book.
#       CREATED: 04/08/2018
#===============================================================================
#
# Source CliColor
if [ -f $HOME/bin/lib/cliColor ]; then
    . $HOME/bin/lib/cliColor
fi
#
clear
echo -e "\t\e[4mFormat a USB memory stick\e[0m

$Green$ mount | grep /dev/sdx | column -t$colorOff

$Green$ umount /dev/sdx$colorOff                        # Your USB stick

$Green$ sudo cfdisk /dev/sdx$colorOff                 # If you see an error try this command

Make all your changes in cfdisk
d                                       # To delete the partition
n                                       # To create a new partition.
t                                       # For type.
W                                       # Write changes.
q                                       # To quit

$Green$ sudo mkfs.vfat -F 32 -n UsbName -i /dev/sdb$colorOff"
#
echo
read -p "Hit Any <Key> To Continue: "
clear
#
echo -e "

Error: physical block size is 2048 bytes, but Linux says it is 512” when formatting USB

1. Make sure the device has no mounted filesystem and unmount it if necessary.
    $Green$ udisksctl unmount -b /dev/sdb1 $colorOff

2. Destroy existing partition table:
    $Green$ sudo sgdisk --zap-all /dev/sdb $colorOff

3. Create new GPT:
    $Green$ sudo sgdisk --new=1:0:0 --typecode=1:ef00 /dev/sd $colorOff

4. Format as FAT32:
    $Green$ sudo mkfs.vfat -F32 /dev/sdb1 $colorOff"
