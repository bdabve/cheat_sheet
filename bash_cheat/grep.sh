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
#
grepOptins(){
    clear
    echo -e "\t\e[4mGrep Options:\e[0m

-v              # show lines that don't match.
-c              # Return the number of matches.
-f              # get the search patterns form file.
-i              # ignore case distinctions.
-n              # Print the line number of where matches were found
-r              # recursive
-R              # read all files under each directory, recursively.
-H              # print the filename with each match

-A              # Print n number of lines after the match
-B              # Print n number of lines before the match

-x              # return only an exact match
-q              # Don't output anything, but exit with status 0 if any match is found
-e              # Specify the string.
-w              # To select only those lines containing matches that form whole words.
--include       # Specify the type of files to be searched for instance.
-m              # stop reading file after n number of matches"
}
#
regex(){
    clear
    echo -e "$Bold[+] Using Regular Expressions$colorOff

    : disregard the system meaning of (escape) the next character. Useful when entering carats for code, dots for IP addresses, etc.
[ ] : a bracket is a list of characters, and matches any character in that list.
      If the first character is ^ then it matches what’s not in the list
-   : a hyphen indicates a range, so [a-d] means [abcd]
[^ ]: shows what doesn’t include those characters
^   : matches at the beginning of the line
$   : matches at the end of the line
.   : matches any single character, except end of line
+   : matches one or more of the preceding thing (at least once)
*   : matches zero or more of the preceding thing
{x,y}: matches x to y occurrences of the preceding thing
{x} : matches exactly x occurrences of the preceding thing
{x,}: matches x or more occurrences of the preceding thing

[[:alnum:]] : any alphanumeric character
[[:alpha:]] : any alphabetic character
[[:contrl:]]: any control character
[[:digit:]] : any number
[[:lower:]] : any lower case character
[[:print:]] : any printable character
[[:space:]] : any space character, including space, tab, newline, CR, FF, etc.
"
}
#
basicUsage(){
    clear
    echo -e "\t$Bold[+]Grep Basic Usage:$colorOff

$Green$ grep root /etc/passwd$colorOff                         # lines from /etc/passwd containing the string root.
$Green$ grep -r 'string' *$colorOff                            # look for string in the current directory recursively.
$Green$ grep -ril 'string' .$colorOff                          # only the name of the file that matches the pattern

$Green$ grep -Rinw ~/bin -e 'Root' -e 'netstat'$colorOff       # Search for more than one pattern.
$Green$ grep -Rinw ~/bin -e 'Root'$colorOff                    # all files containing 'Root' in ~/bin
$Green$ grep -rnw 'directory' -e \"pattern\"$colorOff
$Green$ grep -Rnw --include=\*.sh ~/bin -e 'Root'$colorOff

$Green$ grep -n root /etc/passwd$colorOff                      # line numbers containing the search string.
$Green$ grep -v bash /etc/passwd | grep -v nologin$colorOff    # users are not using bash and nologin.
$Green$ grep -c false /etc/passwd$colorOff                     # number of accounts that have /bin/false as the shell.
$Green$ grep -f pattern_file file$colorOff                     # Read search patterns from a file (one per line)

$Green$ ps aux | grep '[h]ttpd'$colorOff                       # Exclude grep output of ps, Add [] to the first letter.

$Green$ grep -i psx ~/.bash* | grep -v history$colorOff
# Displays the lines from all the files in home directory starting with ~/.bash, excluding matches containing the string history,
# So as to exclude matches from ~/.bash_history which might contain the same string, in upper or lower cases."
}
#
#
grepAndRegularExpressions(){
    clear
    echo -e "\t$Bold[+] Grep And Regex:$colorOff

$Green$ grep ^root /etc/passwd$colorOff      # lines starting with the string 'root'
$Green$ grep :$ /etc/passwd$colorOff         # search for lines ending in ':'

$Green$ grep export ~/.bashrc | grep '\<PATH'$colorOff
# select 'export' lines and then search for lines starting with the string 'PATH'.
# Similarly, \> matches the end of a word.

$Green$ grep -w 'is' fileName$colorOff     # looking only for the WORD 'is' and not 'this'.

    $Bold[+] Character Classes$colorOff

$Green$ grep [yf] /etc/group$colorOff           # All the lines containing either a 'y' or 'f' character are displayed.
$Green$ grep \"^00\" file$colorOff                                                  # Match lines starting with 00
$Green$ grep -E \"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\" file$colorOff    #Find IP add

    $Bold[+] Wildcards$colorOff
# Get a list of all five-character English dictionary words starting with 'c' and ending in 'h'
$Green$ grep '\<c...h\>' /usr/share/dict/words$colorOff

# Selects all words starting with 'c' and ending in 'h' from the system's dictionary
$Green$ grep '\<c.*h\>' /usr/share/dict/words$colorOff

$Green$ grep '*' /etc/profile$colorOff                       # Find the literal asterisk character in a file or output."
}
#
#
lineAfterBefore(){
    clear
    echo -e "\t$Bold[+] Displaying Lines before/after/around Match:$colorOff

$Green$ grep -A <N> 'string' fileName$colorOff             # display N lines after match
$Green$ grep -B <N> 'string' fileName$colorOff             # display N Lines before the match
$Green$ grep -C <N> 'string' fileName$colorOff             # display N Lines in both side (after/before) match"
}
#
#
menu(){
    clear
    echo -e "\n$Bold[+] Grep Examples:$colorOff

    1. Grep Options.
    2. Grep Basic Usage.
    3. Grep And REGEX.
    4. Displaying Lines before/after/around Match.
    5. Using Regular Expressions.
    0. Exit"
    echo -en "\n[:] Your Choice: "
    read -rn 1 choice
}
# ------------------------- Main Script
#
while true; do
    menu
    case $choice in
        1)  grepOptins && pause ;;
        2)  basicUsage && pause ;;
        3)  grepAndRegularExpressions && pause ;;
        4)  lineAfterBefore && pause ;;
        5)  regex; pause ;;
        0)  echo -e "\nBye" && exit 0 ;;
        *)  clear; echo -en "$Red[-] Wrong choice$colorOff"; pause ;;
    esac
done
