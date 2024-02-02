#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error
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
echo -e "

$Bold[+] Common Linux Directory Names$colorOff

| Directory   |   Usage
| ------------|--------------------------
| /           | root of the virtual directory, where normally, no files are placed.
| /bin        | essential binary.
| /boot       | static files of boat loader.
| /dev        | where Linux creates device nodes.
| /etc        | host specific system config
| /lib        | library and kernel modules.
| /media      | Media directory, a common place for mount points used for removable media.
| /mnt        | mount files for temporary filesystem.
| /opt        | optional directory, store third-party software.
| /proc       | Process directory, where current hardware and process information is stored.
| /root       | ROOT home directory.
| /sbin       | system binary directory, where many GNU admin-level utilities are stored.
| /run        | run directory, where runtime data is held during system operation.
| /srv        | service directory, where local services store their files.
| /sys        | system directory, where system hardware information files are stored.
| /tmp        | tomporary directory, where temporary work files can be created and destroyed.
| /usr        | shaeable and read-only data
| /var        | variable data files, for files that change frequently, such as log files.
"
#
pause
#
echo -e "
$Bold[+] Important File:$colorOff

$Green[+] /etc$colorOff
/etc/sysctl.conf          # config file for all system
/etc/sysctl.d/            # config directory for all system
/etc/os-release
/etc/hostname             # config file for hostname
/etc/hosts                # config file for hosts
/etc/default/apport       # desable crash report
/etc/network/interfaces   # network interfaces
/etc/ssh/sshd_config      # ssh config
/etc/fstab                # to mount a volume at boot

/etc/update-manager/release-upgrade         # Default behavior for the release upgrader, $ sudo do-release-upgrade

$Green[+] /proc$colorOff
/proc/sysrq-trigger       # sysrq for safereboot
/proc/sys/kernel/sysrq    # sysrq for safereboot

$Green[+] /var$colorOff
/var/log/       # log files and dirs.
/var/www/       # apache web server

$Green[+] /usr$colorOff
/usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf    # Remove guest session
/usr/bin                                            # Most user commands
/usr/local                                          # local software
/usr/sbin                                           # non essential binaries.
"
