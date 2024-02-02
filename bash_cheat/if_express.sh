#!/bin/bash
#
#
# Source cliColor
if [ -s /home/dabve/bin/lib/cliColor ];then
    source /home/dabve/bin/lib/cliColor
fi
#
pause(){
	echo -en "\n$Yellow[:] Hit Any <Key> to Continue: $colorOff"
    read -rn 1
    clear
}
#
#
expressionsUsedWithIf(){
	clear
	echo -e "\t$Bold[*] Expressions used with if$colorOff
| Parameter     | Meaning
|---------------|----------------------------------------------------------------
| -a FILE       |  FILE exists.
| -e FILE       |  FILE exists same -a.
| -f FILE       |  FILE exists and is a regular file (i.e., not a directory or other special type of file).
| -s FILE       |  FILE exists and has a size greater than zero (not empty).
| -h FILE       |  FILE exists and is a symbolic link.
| -w FILE       |  FILE exists and is writable, you have write permission.
| -r FILE       |  FILE exists and is readable, you have read permission.
| -x FILE       |  FILE exists and is executable.
| -d FILE       |  FILE exists and is a directory.
|---------------------------------------------------------------------------------
| -O FILE       |  FILE exists and is owned by the effective user ID.
| -G FILE       |  FILE exists and is owned by the effective group ID.
| -b FILE       |  FILE exists and is a block-special file.
| -c FILE       |  FILE exists and is a character-special file.
| -g FILE       |  FILE exists and its SGID bit is set.
| -k FILE       |  FILE exists and its sticky bit is set.
| -p FILE       |  FILE exists and is a named pipe (FIFO).
| -t FD         |  File descriptor FD is open and refers to a terminal.
| -u FILE       |  FILE exists and its SUID (set user ID) bit is set.
| -L FILE       |  FILE exists and is a symbolic link.
| -N FILE       |  FILE exists and has been modified since it was last read.
| -S FILE       |  FILE exists and is a socket."
#
	pause
#
	echo "
FILE1 -nt FILE2         # FILE1 has been changed more recently than FILE2, or if FILE1 exists and FILE2 does not.
FILE1 -ot FILE2         # FILE1 is older than FILE2, or is FILE2 exists and FILE1 does not.
FILE1 -ef FILE2         # FILE1 and FILE2 refer to the same device and inode numbers.
-o OPTIONNAME           # shell option 'OPTIONNAME' is enabled."
}
#
#
numericComparison(){
	clear
	echo -e "\t$Bold[*] Numeric Comparison:$colorOff"
	echo "

| Command         | Meaning                                    |
|-----------------|--------------------------------------------|
| n1 -eq n2       | n1 is equal to n2
| n1 -ge n2       | n1 is greater than or equal to n2
| n1 -gt n2       | n1 is greater than n2
| n1 -le n2       | n1 is less than or equal to n2
| n1 -lt n2       | n1 is less than n2
| n1 -ne n2       | n1 is not equal to n2"
}
#
##
StringComparison(){
	clear
	echo -e "
    $Bold[*] String Comparison:$colorOff

| Command             | Meaning                                    |
|---------------------|--------------------------------------------|
| str1 == str2        |  str1 matches str2, '=' can be used
| str1 != str2        |  str1 does not match str2
| str1 < str2         |  str1 is less than str2 (alphabetically)
| str1 > str2         |  str1 is greater than str2 (alphabetically)
| -n str1             |  str1 is not null (has length greater than 0)
| -z str1             |  str1 is null (has length 0)

# The > and < must be escaped, or shell uses them as redirection symbols, with the string values as filenames.
# The > and <  order is not the same as that used with the sort command.
# Capitalized letters are treated as less than lowercase letters in test comparisons.

$Bold[+] FLOW CONTROLS$colorOff

| Command                   | Meaning                                    |
|---------------------------|--------------------------------------------|
| statement1 && statement2  |  and operator
| statement1 || statement2  |  or operator
| -a                        |  and operator inside a test conditional expression
| -o                        |  or operator inside a test conditional expression

# Double parentheses for mathematical expressions
# Double square brackets for advanced string handling functions"
#
	pause
#
	echo "
Symbol  |	 Description
-------------------------------------------
val++   |	Post-increment
val—    |	Post-decrement
++val   |	Pre-increment
—val    |	Pre-decrement
!       |	Logical negation
∼       |	Bitwise negation
**      |	Exponentiation
<<      |	Left bitwise shift
>>      |	Right bitwise shift
&       |	Bitwise Boolean AND<
|       |	Bitwise Boolean OR
&& (-a) |	Logical AND
|| (-o) |	Logical OR
-------------------------------------------"
}
#
## ----------------- Main Script ---------------------------
menu(){
    clear
    echo -e "\n$Bold[*] IF Expression:$colorOff

    1. Expressions used with if
    2. Numeric Comparison.
    3. String Comparison.
    0. Exit"
    echo -en "\n$Bold[:]Choose From The Menu: "
    read -rn 1 choice
}
# ------------------------- Main Script
#
while true; do
    menu
    case $choice in
        1)  expressionsUsedWithIf
            pause
            ;;
        2)  numericComparison
            pause
            ;;
        3)  StringComparison
            pause
            ;;
        0)  exit 0
            ;;
        *)  clear
            echo -en "$Red[-] Wrong choice :("
            pause
            ;;
    esac
done
