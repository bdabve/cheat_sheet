#!/bin/bash
#
#
if [ -f '/home/dabve/bin/lib/cliColor' ];then
    . '/home/dabve/bin/lib/cliColor'
fi
#
if [ -f '/home/dabve/bin/lib/functions_lib' ];then
    . '/home/dabve/bin/lib/functions_lib'
fi
#
find_options(){
    clear
    echo -e "$Bold[+] find common options$colorOff

| Option        | Meaning
|---------------|-----------------------------------------------------------
| -atime n      | File was last accessed exactly n days ago.
| -mtime n      | File was last modified exactly n days ago.
| -newer file   | File was modified more recently than file was.
| -size n       | File is n 512-byte blocks long (rounded up to next block).
| -type c       | Specifies the file type: f=plain file, d=directory, etc.
| -fstype typ   | Specifies filesystem type.
| -name name    | The filename is nam.
| -perm p       | The file’s access mode is p.
| -user usr     | The file’s owner is usr.
| -group grp    | The file’s group owner is grp.
| -nouser       | The file’s owner is not listed in the password file.
| -nogroup      | The file’s group owner is not listed in the group file.

    $Green -atime +60 -mtime +120$colorOff          # Last accessed more than two month and last modified more than 4 month
    $Green \\(-atime +7 -o -mtime +30)$colorOff     # (-o for OR) Last accessed more than 7 days OR last modified more than 30 days
    $Green ! -name gold.dat -name \\*.dat$colorOff  # (! for not) Specify all.dat files except gold.dat
    $Green -perm 755$colorOff                       # Permission = rwxr-xr-x "
#
pause
#
echo -e "$Bold[+] find actions$colorOff

| Option    | Meaning
|-----------|--------------------------------------------
| -print    | Display pathname of matching file.
| -ls a     | Display long directory listing for matching file.
| -exec cmd | Execute command on file.
| -ok cmd   | Prompt before executing command on file.
| -xdev     | Restrict the search to the filesystem of the starting directory (typically used to bypass mounted remote filesystems).
| -prune    | Don’t descend into directories encountered."
}
#
#
findBasics(){
    clear
    echo -e "\t$Bold[+] Find Basics:$colorOff

$Green$ find /dir/ -name 'name*'$colorOff               # files starting with name under /dir/.
$Green$ find /dir/ -user username$colorOff              # files owned by the username under /dir.

$Green$ find -name 'spkg.sh'$colorOff
$Green$ find /home/dabve/ -name 'spkg.sh'$colorOff

$Green$ find \$HOME -size +500M$colorOff                # all the files greater than certain size

$Green$ find ~/bin -name '*.sh' -mtime +2$colorOff      # files that are not modified in the last x number of days
$Green$ find ~/bin -name '*.sh' -mtime -2$colorOff      # files that are modified in the last x number of days
$Green$ find ~/bin -name '*.sh' -atime -7$colorOff      # files with the last 7 days access time

$Green$ find ~ -name bin -type d$colorOff               # by type (f) for files.

$Green$ find . -name '*.jpg' -printf '%p - %u\\\n'$colorOff                   # Use printf with find
$Green$ find . -size +2048 -mtime +30 -ls$colorOff                            # Find file greater then 1Mb that haven't been modified in a month
$Green$ find /home -size +2048 \\( -mtime +30 -o -atime +120 \\) -ls$colorOff # Search for file not modified in a month or not accessed in 3 month
"

}
#
#
deletingFile(){
    clear
    echo -e "\t$Bold[+] Deleting File:$colorOff

$Green$ find -name '*.jpg' -delete$colorOff
$Green$ find / -type f -name '*.tar.gz' -size +100M -delete$colorOff          # Danger command delete all the *.tar.gz and greater than 100Mb

# Be careful with the following. Best practice is to execute ls -l to make sur you now which file will get deleted
$Green$ find / -type f -name '*.tar.gz' -size +100M -exec ls -l {} \\;$colorOff
$Green$ find / -type f -name *.tar.gz -size +100M -exec rm -f {} \\;$colorOff"
}
#
#
executeCommand(){
    clear
    echo -e "\t$Bold[+] Execute Commande:$colorOff

$Green$ find -name '*.sh' -exec chmod u+x {} \\;$colorOff      # To confirm use '-ok' in place of -exec

$Green$ find . -type -f -name '.mp3' -exec mv {} /home/dabve/music \;$colorOff

$Green$ find . -type f -exec rename 's/ /_/g' {} \;$colorOff"
}
#
#
advancedFind(){
    clear
    echo -e "\t$Bold[+] Find with REGEX:$colorOff

# Find all files under /etc/ that start with the letter p and end in anything using the following command:
$Green$ find / -regex '^/etc/p[a-z]*$'$colorOff

# Find all files that are called configuration, ignoring case, and accommodating abbreviations such as confg, cnfg, and cnfig :
$Green$ find / -regex '^[/a-z_]*[cC]+[Oo]*[nN]+[fF]+[iI]*[gF]+$'$colorOff

# Archive all the file that are not modified in the last x number of days:
$Green$ find \$HOME -type f -mtime +60 | xargs tar -cvf /tmp/\$(date '+%d%m%Y'_archive.tar)$colorOff

# -execdir: This works the same way –exec does, except it will isolate execution of the specified command to the directory of the match file.
# -print0: This prints the file's full name to standard output."
}
#
#
menu(){
    clear
    echo -e "

$Bold[+] Find Commande:$colorOff

    1. Find Options and Actions.
    2. Find Basics.
    3. Deleting File
    4. Execute Command
    5. Find with REGEX
    0. Exit"
    echo -en "\n[:] Your Choice: " && read -rn 1 choice
}
# ------------------------- Main Script
#
while true; do
    menu
    case $choice in
        1)  find_options ; pause ;;
        2)  findBasics ; pause ;;
        3)  deletingFile ; pause ;;
        4)  executeCommand ; pause ;;
        5)  advancedFind ; pause ;;
        0)  echo -e "\nBye"; exit 0 ;;
        *)  echo -en "\n\n$Red[:] Wrong choice$colorOff"; pause ;;
    esac
done
