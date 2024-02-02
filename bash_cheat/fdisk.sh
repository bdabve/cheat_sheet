#!/bin/bash
#
# The fdisk utility.
#
if [ -f '/home/dabve/bin/lib/cliColor' ];then
    . '/home/dabve/bin/lib/cliColor'
fi
#
#
clear
echo -e "
$Green$ fdisk -l$colorOff           # all Disk Partitions
$Green$ fdisk -l /dev/sdx$colorOff  # specific disk partition

# work on partition:
    $Green$ fdisk /dev/sdx$colorOff
    # type 'm' : list of all available commands of fdisk.
    # type 'p' : print the specific /dev/sdx partition table.

# delete Partition:
    $Green$ fdisk /dev/sdx$colorOff
    # type 'd' : delete partion, and Enter Partition number.
    # type 'w' : Write changes."
#
echo
echo -e "Hit <ENTER> to continue: "
read -rn 1
clear
#
echo -e "
# create new partition:
    $Green $ fdisk /dev/sdx $colorOff
    # type 'n' : new partition, and choose between primary OR Extended
    # enter first cylinder number, last cylinder number
    # you can enter the size of cylinder by adding '+5000M' in last cylinder.
    # type 'w' to Write changes.
    # after the new partition is created, don't skip to format the newly created partition using 'mkfs' command.

# check size of a Partition in Linux:
    $Green$ fdisk -s /dev/sdx$colorOff

# fix partition table order
    $Green$ fdisk /dev/sdx$colorOff
    # type 'x' : enter an extra functionality section.
    # type 'f' : expert command to fix the order of partition table.
    # type 'w' : write changes.

# disable Boot Flag (*) of a Partition
    $Green$ fdisk /dev/sdx$colorOff
    # type 'a' : disable boot flag
    # then enter partition number, This will remove the asterisk (*) flag"
#
echo -e "Hit <ENTER> to continue: "
read -rn 1
#
clear
echo -e "[+] Creating a filesystem

# before you can store data on the partition, you must format it with a filesystem so Linux can use it.
# each filesystem type uses its own command line program to format partitions.

     |----------------------------------------------
     | mkefs        | creates an ext filesystem
     | mke2fs       | creates an ext2 filesystem
     | mkfs.ext3    | creates an ext3 filesystem
     | mkfs.ext4    | creates an ext4 filesystem
     | mkreiserfs   | creates a ReiserFS filesystem
     | jfs mkfs     | creates a JFS filesystem
     | mkfs.xfs     | creates an XFS filesystem
     | mkfs.zfs     | creates a ZFS filesystem
     | mkfs.btrfs   | creates a Btrfs filesystem

     $Green$ sudo mkfs.ext4 /dev/sdx$colorOff"
