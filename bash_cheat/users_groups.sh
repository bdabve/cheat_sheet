#!/bin/bash
#
#
# Sourcing cliColor
if [ -f /home/dabve/bin/lib/cliColor ];then
  source /home/dabve/bin/lib/cliColor
fi
# Sourcing pause function
if [ -f /home/dabve/bin/lib/functions_lib ];then
    source /home/dabve/bin/lib/functions_lib
fi
#
basicUsage(){
    clear
    echo -e "$Bold[*] Basic Usage: $colorOff

| -c comment          | Adds text to the new user's comment field
| -d home_dir         | Specifies a different name for the HOME directory othe than the login name
| -e expire_date      | Specifies a date, in YYYY-MM-DD format, when the account will expire
| -f inactive_days    | Specifies the number of days after a password expire when the account will be disabled.
|                     | A value of 0 disable the account as soon as the password expire. A value of -1 disable this feature
| -g initial_group    | Specifies the group name or GID of the user's login groupe
| -G  group ...       | Specifies one or more supplementary groups the user belongs to
| -k                  | Copies the /etc/skel directory contents into the user’s  HOME directory (must use -m as well)
| -m                  | Creates the user’s HOME directory
| -M                  | Doesn’t create a user’s HOME directory (used if the default setting is to create one)
| -n                  | Creates a new group using the same name as the user’s login name
| -r                  | Creates a system account
| -p passwd           | Specifies a default password for the user account
| -s shell            | Specifies the default login shell
| -u uid              | Specifies a unique UID for the account
| -U                  | Create a group with the same name as the user

# See the man page for configuration variables and configuration file."
#
pause
#
echo -e "
$Bold[+] Examples$colorOff

$Green# useradd -D$colorOff                         # System default value
$Green# useradd -D -s /bin/tsch$colorOff            # Change the default value of SHELL

$Green# useradd dabve$colorOff                                      # Add new user
$Green# useradd -u 999 dabve -g 500 -d /data/projects$colorOff      # Specify UID and GID, and location of home directory
$Green# useradd -G admins,webadmin,developers dabve$colorOff        # Adding a user dabve into multiple groups
$Green# useradd -M dabve$colorOff                                   # Create user dabve without home directory

$Green# useradd -m -d /var/www/badi -s /bin/zsh -c 'This is badi -u 555 -g 555 -U badi'$colorOff
$Green# useradd -m test -g dabve -p passwd -s /bin/bash$colorOff

$Green# userdel -r test$colorOff                   # remove a user from the system, -r remove the user's HOME directory.
$Green# deluser dabve sudo$colorOff                # Remove dabve from the sudo group

# Create user dabve with account expiry date, and passwd expire in 45 days
    $Green# useradd -e 2020-03-27 dabve -f 45$colorOff"
}
#
#
command_deal(){
    clear
    echo -e "

$Bold[+] Commands for dealing with users$colorOff

| Commend           | Meaning
|-------------------|---------------------------------------------
| ${Green}usermod$colorOff          | Edits user account fields, as well as specifyng primary and secondary group membership
| ${Green}passwd$colorOff           | Changes the password for an existing user
| ${Green}chpasswd$colorOff         | Reads a file of login name and password pairs, and updates the passwords
| ${Green}chage$colorOff            | Change the password's expiration date
| ${Green}chfn$colorOff             | Change the user's account's comment information
| ${Green}chsh$colorOff             | Change the user account's default shell"
}
#
#
usermodComman(){
    clear
    echo -e "$Bold[*] usermod Usage: $colorOff

[+] The usermod command is the most robust of the user account modification utilities.

| -l      | Changes the login name of the user account.
| -d      | To modify the directory for any existing user.
| -e      | Make the account expire in specific period.
| -g      | Change the primary group.
| -G      | Add a supplementary groups.
| -a      | To Add anyone of the group to a secondary group.
| -L      | Locks the account so the user can't log in.
| -p      | Change the password for the account.
| -m      | Moving the contents of the home directory from existing home dir to new dir.
| -s      | Create a Specified shell for new accounts
| -u      | Used to assigned UID for the user account.
| -U      | unlock the account so the user can log.
"
#
pause
#
echo -e "
$Bold[+] Examples$colorOff

    $Green# usermod -c 'This is dabve' dabve$colorOff       # Set a brief comment, this comment can be viewed in /etc/passwd
    $Green# usermod -d /opt/ dabve$colorOff                 # Change home directory to /opt/
    $Green# usermod -e 2020-11-01 dabve$colorOff            # Change expiry status for dabve
    $Green# usermod -g admins dabve$colorOff                # Set the admins group as a primary group to user dabve
    $Green# usermod -G admins dabve$colorOff                # Add a new group 'admins' to dabve user
    $Green# usermod -a -G sudo dabve$colorOff               # Add dabve to sudo group
    $Green# usermod -a -G wheel dabve$colorOff              # Adding user dabve to a secondary group wheel
    $Green# usermod -l dabve Badi$colorOff                  # Change login name dabve to Badi
    $Green# usermod -L dabve$colorOff                       # Disable password
    $Green# usermod -d /home/dabve -m /opt$colorOff         # Move the home directory to /opt
    $Green# usermod -s /bin/zsh -u 888 dabve$colorOff       # Change the default shell, and set UID 888 to dabve
    $Green# usermod -d /opt/ -s /bin/bash -e 2014-12-10 -c 'This is jack' -u 555 -aG apple jack$colorOff
    "
}
#
#
passwdAndChpasswdCommand(){
    clear
    echo -e "$Bold[*] passwd and chpasswd Usage: $colorOff

[+] A quick way to change just the password for a user.

$Green# passwd dabve$colorOff
$Green# passwd --lock dabve$colorOff    # Locking the user account, this will prevent a user from running processes on the system
$Green# chpasswd < users.txt$colorOff   # reads a list of login name and passwd(separated by a colon).

[+] Force user to change password at next login
    $Green# passwd --expire dabve$colorOff
# Cause a user's password to expire, once dabve tries to login next time, he will be prompted to change his password

[+] chsh, chfn, groupadd:

    $Green# chsh -s /bin/csh dabve$colorOff
    $Green# finger dabve $colorOff          # The finger command allows you to find information about people on your linux system
    $Green# chfn dabve$colorOff             # Change finger information for specific user

    $Green# groupadd -g 2000 shared$colorOff                # Specify the GID
    $Green# groupadd shared$colorOff                        # The groupadd command allows you to create new groups
    $Green# groupmod -n sharing shared -g 1500$colorOff     # change name of group shared to sharing and gid to 1500
"
}
#
#
chageCommand(){
    clear
    echo -e "$Bold[*] The chage command: $colorOff

[+] The chage command: is used to modify user password expiry information. and view user account informations.

| -d  | Sets the numer of days since the passwd was last changed
| -E  | Sets the date the passwd expires
| -I  | Sets the number of days of inactivity after the passwd expires to lock the account
| -m  | Sets the minimum number of dayx between passwd changes
| -W  | Sets the number of days before the passwd expires that a warning message appears

# The date values can be expressed like: YYYY-MM-DD format

    $Green# chage -d 2018-02-11 dabve$colorOff   # Set the date when the passwd was last changed
    $Green# chage -l dabve$colorOff              # Check the current expiry status
    $Green# chage -E 2018-02-16 dabve$colorOff   # date or number of days on which the user's account will no longer be accessible
    $Green# chage -w 10 dabve$colorOff           # Set the number of days of warning before a password change is required.
    $Green# chage -I 2 dabve$colorOff            # After dabve's passwd expires, his account will be inactive for 2 days
    $Green# chage --lastday 0 dabve$colorOff     # Force a user to change his password
"
}
#
#
menu(){
    clear
    echo -e "$Bold[*] Users and Groups: $colorOff

    1. Command for dealing with users
    2. Basic Usage.
    3. Usermod Comman.
    4. Passwd And Chpasswd Command.
    5. Chage Command.
    0. Exit."

    echo -en "\n[:] Choose From The Menu: "
    read -rn 1 choice
}
#
while true; do
    menu
    case $choice in
       1)  command_deal; pause ;;
       2)  basicUsage; pause ;;
       3)  usermodComman; pause ;;
       4)  passwdAndChpasswdCommand; pause ;;
       5)  chageCommand; pause ;;
       0)  echo -e "\nBye"; break ;;
       *)  echo -e "\n\n$Red[-] Wrong Choice :($colorOff"
           pause
           ;;
    esac
    clear
done
