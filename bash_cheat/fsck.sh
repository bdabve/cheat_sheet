#!/bin/bash -
#===============================================================================
#
#          FILE: fsck.sh
#         USAGE: ./fsck.sh
#   DESCRIPTION: How to use fsck to checking an repairing a filesystem
#        AUTHOR: Dabve (), bdabve@gmail.com
#       CREATED: 07/09/2019 07:11:23 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#
if [ -f '/home/dabve/bin/lib/cliColor' ];then
    . '/home/dabve/bin/lib/cliColor'
fi
#
#
clear
echo -e "
[*] ${Bold}fsck$colorOff: used to check and repair most Linux filesystem types.

| Option    | Description
|-----------|---------------------------------------------------------------------------
| -a        | Automatically repairs the filesystem if errors are detected
| -A        | Checks all the fijlesystems listed in the /etc/fstab file
| -C        | Displays a progress bar for filesystems that support that feature
| -N        | Doesn't run the check, only display what checks would be performed
| -r        | Prompts to fix if errors found
| -R        | Skips the root filesystem if using the -A option
| -s        | If checking multiple filesystems, performs the checks one at a time
| -t        | Specifies the filesystem type to check
| -T        | Doesn't show the header information when starting
| -V        | Produces verbose output during the checks
| -y        | Automatically repairs the filesystem if errors detected

# N.B: You can run the fsck command on unmounted filesystems only.
"
