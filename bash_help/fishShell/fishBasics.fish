#!/usr/bin/env fish
# This script will help on fish shell and basics
#
function pause
    echo
    read -P "Hit Any <KEY> To Continue: " -n 1
    clear 
end
#
clear
echo -e "\n\e[1;34m[+] Fish Shell Basics: \e[0m

\$ set varName 'value'               # Syntax to declare variable in fish
\$ set -x varName 'value'            # Exports Shell variable with -x || --export option
\$ set -e varName                    # Erase a variable with -e || --erase option
\$ set PATH \$PATH /usr/sbin         # Append to a list
\$ set -U EDITOR vim                 # Universal Variable

\$ echo \$status                     # Exit Status

\$ echo in (pwd), running (uname)            # Command Substitutions
\$ touch \"testing_\"(date +%s)\".txt\"      # Command Substitutions
\$ echo 'Hello World' | string split ' '    # Split space to newline
\$ cp file.txt file_back.txt; and echo 'Backup successful'; or echo 'Backup Failed'"
#
pause
#
echo -e "\n\e[1;34m[+] Conditionals Statement : \e[0m

[+] if, else if , else

if grep fish /etc/shells
    echo Found fish
else if grep bash /etc/shells
    echo Found bash
else
    echo Got Nothings
end

[+] Switch Statement

switch (uname)
case Linux
    echo Hi Tux
case FreeBsd NetBsd DragonFly
    echo Hi Beastie!
case '*'
    echo Hi, Stranger!
end
"
#
pause
#
echo -e "\n\e[1;34m[+] Functions: \e[0m

function sayHello
    echo Hello \$argv
end

\$ sayHello dabve            # Call function

\$ functions                # List all functions
\$ function ls              # See the source for ls

[+] Autoload functions are defined in: ~/.config/fish/functions
function ll
    ls -lh \$argv
end >> ~/.config/fish/functions/ll.fish"
#
pause
#
echo -e "\n\e[1;34m[+] Loops: \e[0m

[+] While

while true
    echo 'Loop forever'
end

[+] For loop

for file in *.txt
    cp \$file \$file.bak
end"
#
pause
#
echo -e "\n\e[1;34m[+] Input Output Redirection: \e[0m
\$ cat < source_file        # Read standard input
\$ cat > source_file        # Write standard input
\$ cat ^ source_file        # Write standard Error"

