#!/bin/bash -
#===========================================
#       NAME   : reminder.sh
#       CREATED: 17 Fev 2019
#===========================================
set -o nounset        # Treat unset variables as an error

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
newInstalledCmd (){
    clear
    echo -e "
$Bold [*] useful commands $colorOff

    $Green[+] ncdu$colorOff            # Presents file and directory sizes in an interactive ncurses
    $Green[+] typecatcher$colorOff     # Install google fonts
    $Green[+] cargo$colorOff           # the Rust package manager
    $Green[+] fselect$colorOff         # find files with SQL-like queries (cargo install fselect)
    $Green[+] statecode$colorOff       # https:// State code
    $Green[+] trans$colorOff           # Google translation with in terminal
    $Green[+] katoolin$colorOff        # Kali linux tools
    $Green[+] whohas$colorOff          # Find a package is available for your linux destribution.
    $Green[+] sosreport$colorOff       #
    $Green[+] how2$colorOff            # stack overflow from terminal.
    $Green[+] awesome-finder$colorOff  # Easily find awesome projects and resources hosted in github
    $Green[+] pdfgrep$colorOff         # Search pdf files for a regular expression
    $Green[+] dstat$colorOff           # Versatile tool for generating system resource statistics
    "
}
#
commandsTips (){
    clear
    echo -e "
$Bold [*] Reminder: $colorOff

    $Green$ :w !sudo tee % $colorOff                            # save a file with root previleges in vim.
    $Green$ tail -f /var/log/apt/history.log $colorOff          # continuously monitor the output of a file
    $Green$ cd() { builtin cd \"\$@\" && ls -l ;}$colorOff      # automatically ls when changing dire
    $Green$ sudo -l -U user_name$colorOff                       # list the privileges for user

    $Green$ date | gawk '{print \$3\"-\"\$2\"-\"\$6}'$colorOff  # out: 03-Mars-2019, useful with file name
    $Green$ var=\$(date | gawk '{print \$3\"-\"\$2\"-\"\$6}').\$(hostname).log$colorOff     # Out: 03-Mars-2019.Lenovo.log

    $Green$ date +junk_'%d-%b-%y'.log$colorOff                      # Out: junk_08-Mar-19.log
"
#
pause
#
echo -e "
# create directory with permission
    $Green$ mkdir -m 755 ./people$colorOff
    $Green$ mkdir -m u=rwx,go=rx ./places$colorOff
    $Green$ mkdir -m g+x ./places$colorOff
    $Green$ mkdir -p app/{lib,bin,dir}$colorOff          # app/lib, app/bin, app/dir

# create a backup file with date
    $Green$ cp foo.txt{,.'\$(date +%Y%m%d-%H%M%S)'}$colorOff

# duplicating an entire directory tree
    $Green$ tar -cf - -C . olddir | tar -xvpf - ; mv olddir newdir$colorOff

# sum with find and awk \$7 is the field of file size
    $Green$ find . -name '*.sh' -user dabve -ls | gawk '{sum+=\$7}; END {print \"User dabve total disk use = \" sum}'$colorOff

# enable minimize on click for the Ubuntu Dock
    $Green$ gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'$colorOff
    $Green$ set show_video true$colorOff                         # Show Video on mpsYoutube

# enable Ctrl + Alt + Backspace to kill x server
    $Green$ setxkbmap -option terminate:ctrl_alt_bksp$colorOff
"
}
#
menu(){
    clear
    echo -e "$Bold[+] Important Notes:$colorOff

    1. New Installed Commands
    2. Reminder.
    0. Exit"

    echo
    echo -en "$BYellow[:] Choose From the Menu: $colorOff"; read -rn 1 Choice
}
#
while true; do
    clear
    menu
    case $Choice in
        1)  newInstalledCmd; pause ;;
        2)  commandsTips; pause ;;
        0)  echo -e "\nBye"; exit 0 ;;
        *)  echo -e "\n[-] $Red Wrong Choice $colorOff"; pause ;;
    esac
done
