#!/bin/bash
#
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
# <center>Loop in Bash</center>

for_loop(){
    clear
    echo -e "
$Bold[+] The for loop

    ${Green}for test in Nevada 'New Hampshire' 'New Mexico' 'New York'; do echo 'Now going to \$test'; done$colorOff

[+] Reading from a variable

    ${Green}list='Alabama Alaska Arizona Arkansas Colorado'
    list=\$list 'Connecticut'
    for state in \$list; do echo 'Have you ever visited $state?'; done$colorOff

[+] Reading from a file

    ${Green}file='states'
    for state in \$(cat \$file); do echo 'Visit beautiful \$state'; done$colorOff

[+] iterate through all the files in a directory

    ${Green}for file in /home/rich/test/*; do
        if [ -d '\$file' ]; then
            echo '\$file is a directory'
        elif [ -f '\$file' ]; then
            echo '\$file is a file'
        fi
    done$colorOff

[+] loop specified number of times: the brace expansion

    ${Green}for i in {1..10}; do echo \$i; done$colorOff
    ${Green}for i in {1..10..2}; do echo \$i ; done$colorOff

[+] loop with seq command
    ${Green}for i in \$(seq 10); do echo \$i; done$colorOff
    ${Green}for i in \$(seq 10 2 20); do echo \$i; done$colorOff        # increment by 2
    ${Green}for i in \$(seq -w 010 20); do echo \$i; done$colorOff      # add leading 0
    ${Green}for i in \$(seq -s- 10 20); do echo \$i; done               # change separator
    "
}
#
#
c_style(){
    clear
    echo -e "
$Bold[+] The C-Style for Command

    ${Green}for (( i=1; i <= 10; i++ )): do
        echo 'The next number is \$i'
    done$colorOff

[+] Multiple variables

    ${Green}for (( a=1, b=10; a <= 10; a++, b-- )); do
        echo '\$a - \$b'
    done$colorOff

[+] Multiple variable

    ${Green}for (( i=1, j=100; i<=10; i++, j-=2 )); do
        printf \"i=%03d j=%03d\\\n\" \$i \$j
    done$colorOff
    "
}
#
#
#
while_loop(){
    clear
    echo -e "
$Bold[+] The while loop$colorOff

[+] while command test

    ${Green}var1=10
    while [ \$var1 -gt 0 ]; do
        echo \$var1
        var1=\$[ \$var1 - 1 ]
    done$colorOff

[+] testing a multicommand while loop

    ${Green}var1=10
    while echo \$var1
        [ \$var1 -ge 0 ]; do
        echo 'This is inside the loop'
        var1=\$[ \$var1 - 1 ]
    done$colorOff
    "
}
#
until_loop(){
    clear
    echo -e "
$Bold[+] The until loop$colorOff

[+] using the until command

    ${Green}var1=100
    until [ \$var1 -eq 0 ]; do
        echo \$var1
        var1=\$[ $var1 - 25 ]
    done$colorOff

[+] using the until command

    ${Green}var1=100
    until echo \$var1
            [ \$var1 -eq 0 ]
    do
        echo Inside the loop: \$var1
        var1=\$[ \$var1 - 25 ]
    done$colorOff
    "
}
#
nesting_loop(){
    clear
    echo -e "
$Bold[+] Nesting Loops$colorOff

[+] nesting for loops

    ${Green}for (( a = 1; a <= 3; a++ )); do
        echo "Starting loop \$a:"
        for (( b = 1; b <= 3; b++ )); do
            echo " Inside loop: \$b"
        done
    done$colorOff

[+] placing a for loop inside a while loop

    ${Green}var1=5
    while [ \$var1 -ge 0 ]; do
        echo 'Outer loop: \$var1'
        for (( var2 = 1; \$var2 < 3; var2++ )); do
            var3=\$[ \$var1 * \$var2 ]
            echo ' Inner loop: \$var1 * \$var2 = \$var3'
        done
        var1=\$[ \$var1 - 1 ]
    done$colorOff
    "
    #
    pause
    #
    echo -e "[+] using until and while loops

    ${Green}var1=3
    until [ \$var1 -eq 0 ]; do
        echo 'Outer loop: \$var1'
        var2=1
        while [ \$var2 -lt 5 ]; do
            var3=\$(echo \"scale=4; \$var1 / \$var2\" | bc)
            echo 'Inner loop: \$var1 / \$var2 = \$var3'
            var2=\$[ \$var2 + 1 ]
        done
        var1=\$[ \$var1 - 1 ]
    done$colorOff
"
}
#
#
loop_file(){
    clear
echo -e "
$Bold[+] Looping on File Data$colorOff

    ${Green}IFS.OLD=\$IFS
    IFS=$'\n'
    for entry in \$(cat /etc/passwd);  do
        echo 'Values in \$entry –'
        IFS=:
        for value in \$entry; do
            echo ' \$value'
        done
    done$colorOff

[+] With the while loop

    ${Green}while read line; do
        echo $line;
    done < file_name $colorOff
    "
}
#
#
loop_controle(){
    clear
echo -e "
    $Bold[+] Controlling the Loop$colorOff

[+] breaking out of a for loop

    ${Green}for var1 in 1 2 3 4 5 6 7 8 9 10; do
        if [ \$var1 -eq 5 ]; then
            break
        fi
        echo 'Iteration number: \$var1'
    done
    echo 'The for loop is completed'$colorOff

[+] Using the continue command

    ${Green}for (( var1 = 1; var1 < 15; var1++ ));  do
        if [ \$var1 -gt 5 ] && [ \$var1 -lt 10 ]; then
            continue
        fi
        echo 'Iteration number: \$var1'
    done$colorOff
    "
    #
    pause
    #
echo -e "[+] Processing the Output of a Loop

    ${Green}for file in /home/rich/*; do
        if [ -d '\$file' ]; then
            echo '\$file is a directory'
        elif
            echo '\$file is a file'
        fi
    done > output.txt$colorOff

[+] Piping a loop to another command
    ${Green}for state in 'North Dakota' Connecticut Illinois Alabama Tennessee; do
        echo '\$state is the next place to go'
    done | sort
    echo 'This completes our travels'$colorOff
    "
}
#
# ----------
menu() {
    clear
    echo -e "\n$Bold[+] The Bash Loops:$colorOff

    1. for Loop.
    2. C Style for Loop.
    3. while Loop.
    4. until Loop.
    5. Nestingi Loop.
    6. Loop Through File
    7. Contrle The Loop
    0. Exit"
    echo -en "\n$Bold[:] Your Choice: $colorOff"
    read -rn 1 choice
}
# ------------------------- Main Script
#
while true; do
    menu
    case $choice in
        1) for_loop && pause ;;
        2) c_style && pause ;;
        3) while_loop && pause ;;
        4) until_loop && pause ;;
        5) nesting_loop && pause ;;
        6) loop_file && pause ;;
        7) loop_controle && pause ;;
        0) echo -e "\nBye" && exit 0 ;;
        *) echo -en "\n$Red[-] Wrong choice$colorOff"; pause ;;
    esac
done
