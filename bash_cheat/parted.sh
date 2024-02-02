#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
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
clear
echo -e "
$Green(parted) print$colorOff               # List Linux Disk Partitions
$Green(parted) select /dev/sdX$colorOff     # List or Switch to Different Disk

[+] Create Primary or Logical Partition in Linux

# To create new partition, parted uses 'mkpart'.
# You can give it additional parameters like 'primary' or 'logical' depending on the partition type that you wish to create.
# Now the first step is to give the new disk a label name with:

  $Green(parted) mklabel msdos
  (parted) mkpart
  Partition type?  primary/extended? primary
  File system type?  [ext2]?
  Start? 1
  End? 10000$colorOff

# Next, exit parted with 'quit' command.

# We will format our new partition in ext4 file system using mkfs.
  $Green$ mkfs.ext4 /dev/sdb1$colorOff
# Note: It’s important to select the right disk and partition when executing the above command!"
#
pause
#
echo -e "$Bold[+] Resize Linux Disk Partition$colorOff

# Parted includes multiple useful functions and one of them is 'resizepart'.

# As you have probably figured this out by now, 'resizepart' helps you resize a partition.

  # First you will need to know the number of the partition that you will be resizing.

  # This can be easily found by using 'print':

  $Green(parted) print
  (parted) resizepart
  Partition number? 1
  End?  [10.0GB]? 15000$colorOff
"
#
pause
#
echo -e "
$Bold[+] Delete Linux Partition$colorOff

# To do this, you will need to use the 'rm' command within parted.

# To delete a disk partition you will need to know it’s number using 'print'.

    $Green(parted) rm 1$colorOff"
#
pause
#
echo -e "$Bold[+] Rescue Linux Disk Partition$colorOff

# Parted supports a 'rescue' utility that helps you recover a lost partition between a starting and ending point.
# If a partition is found within that range, it will attempt to restore it.

  $Green(parted) rescue
  Start? 1
  End? 15000
  Number Start End Size File system Flags
  1 0.00B 15.0GB 15.0GB ext4$colorOff

$Bold[+] Linux Partition Flag$colorOff

# Using parted, you can change the state of a flag for disk partitions.  The supported flags are:
    1. boot     2. root
    3. swap     4. hidden
    5. raid     6. lvm
    7. lba      8. legacy boot
    9. irst     10. esp
    11. palo

# The states can be either 'on' or 'off'.
# To change a flag simply run 'set' command within parted:
    $Green(parted) set 2 lba on$colorOff      # The above command sets lba flag to on for second partition."
