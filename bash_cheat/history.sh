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
history_var(){
    clear
    echo -e "\t$Bold[+]History Variables$colorOff

HISTCMD         | histroy number of the current command
HISTCONTROL     | A list of patterns, separated by (:), which can have the folowing value.
                | ignorespace: lines beginning with a space are not entered into the history list
                | ignoredups: lines matching the last history line are not entered.
                | erasedups: all previous lines matching the current line are removed
                | ignoreboth: enable both ignorespace and ignoredups
HISTIGNORE      | list of paterns, separated by (:), used to decide which commands lines to save.
HISTFILE        | Name of history file in which the command history is saved.
HISTFILESIZE    | the maximum number of lines to store in the history file.
HISTSIZE        | the maximum number of commands to remember in the command history
HISTTIMEFORMAT  | its value is used as a format string to print the time stamp associated with each history entry"
}
#
fcCommand(){
    clear
    echo -e "\t$Bold[+] The FC Commend:$colorOff

$Bold[+] fc:$colorOff used to examine the most recent commamnds you entered, to edit one or more commands with your favorite editor.

### Somme Example:
    $Green$ fc -l$colorOff           # list the command line history.
    $Green$ fc -ln$colorOff          # supresses the line number.
    $Green$ fc -l N$colorOff         # go to N number.
    $Green$ fc -l v$colorOff         # show history from the last command who beggin with string v.
    $Green$ fc -l 5 7$colorOff       # show history from 5 to 7

# fc is usually used to fix a recent command.

    $Green$ fc -s ct=cat$colorOff    # Change the string ct with cat"
}
#
#
#
eventDesignators(){
    clear
    echo -e "\t$Bold[+] Event Designators:$colorOff

Command     |       Description
--------------------------------------------------------------------------------
!           | Start a history substitution
!!          | Refers to the last command
!n          | Refers to command n
!-n         | Refers to the current command line
!string     | Refer to the recent cmd start with string
!?string?   | Refer to the most recent cmd containing string the ending ? is optional
^str1^str2  | Repeat the last command, replacing str1 with str2
--------------------------------------------------------------------------------"
}
#
#
#
wordDesignators(){
    clear
    echo -e "\t$Bold[+] Word Designators:$colorOff

Designator	|	Description
--------------------------------------------------------------------------------
0           | The zeroth (first) word in a line
n           | The nth word in a line
^           | The first argument (the second word)
$           | The last argument in a line
%           | The word matched by the most recent ?string search
x-y         | Arange of word from x to y. -y is synonymous with 0-y
*           | All words but the zeroth; synonymous with 1-\$. if there is only one word, an empty strinf is returned
x*          | synonymous with x-$
x-          | The words from x to the second to last word
--------------------------------------------------------------------------------

# The word designator follows the event designator, separated by a colon EX: !!:0

    $Green$ cat file$colorOff
    $Green$ !!:0 -n file$colorOff     # to add the -n option to"
}
#
#
#
modifiers(){
    clear
    echo -e "\t$Bold[+] Modifiers:$colorOff

Modifier	|	Description
--------------------------------------------------------------------------------
h           | Remove a trailing pathname component, leaving the head
r           | Removes a trailing suffix of the form .xxx
e           | Removes all but the trailing suffix
t           | Removes all leading pathname components, leaving the tail
p           | Prints the resulting command but doesn't execute it
q           | Quotes the substituted words, escaping further substitutions
x           | Quotes the substituted words, breaking them into words at blanks and newlines
s/old/new   | Substitutes new for old
--------------------------------------------------------------------------------

# More than one modifier may be used with an event designator; each one is separated by a colon."
}
#
#
#
examples(){
    clear
    echo -e "\t$Bold[+] Examples:$colorOff

$Green$ !12:p$colorOff              # print the 12 command from history
$Green$ !vim:p$colorOff             # print the last command vim
$Green$ !!:p$colorOff               # print the last command

$Green$ cat !^$colorOff             # first argument from previous command
$Green$ vim !\$$colorOff            # last argument from previous command
$Green$ ls !*$colorOff              # take all argument from previous command
$Green$ ls !vim:2$colorOff          # take the argument N 2 from vim command

$Green$ ls -l !vim:^$colorOff       # first argument from vim command
$Green$ ls -l !vim:\$$colorOff      # last argument from vim command

$Green$ ^gog^goog$colorOff          # modify gog to goog"
}
#
#
# ----------
menu(){
    clear
    echo -e "\n$Bold[+] The Bash History:$colorOff

    1. The FC Command.
    2. Event Designators
    3. Word Designators.
    4. Modifiers.
    5. Examples.
    0. Exit"
    echo -en "\nYour Choice: "
    read -rn 1 choice
}
# ------------------------- Main Script
#
while true; do
    menu
    case $choice in
        1) fcCommand && pause ;;
        2) eventDesignators && pause ;;
        3) wordDesignators && pause ;;
        4) modifiers && pause ;;
        5) examples && pause ;;
        0) echo -e "\nBye" && exit 0 ;;
        *) clear; echo -en "$Red[-] Wrong choice$colorOff"; pause ;;
    esac
done
