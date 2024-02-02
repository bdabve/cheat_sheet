#!/bin/bash -
#===============================================================================
#
#          FILE: variable.sh
#
#         USAGE: ./variable.sh
#
#   DESCRIPTION: This script describe usage of variable in bash
#
#        AUTHOR: daBve (), dabve@outlook.fr
#       CREATED: 05/02/2017 20:25
#===============================================================================
#
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
#
global_var(){
    clear
    echo -e "
    $Bold[+] Global variables$colorOff

$Green$ printenv $colorOff               # To view global environment variables, use the ${Green}env$colorOff or ${Green}printenv$colorOff
$Green$ CDPATH=:~/programming$colorOff   # Define your CDPATH to be the empty string (the current directory) followed by ~/programming.
$Green$ shopt -s cdable_vars$colorOff    # Any argument supplied to the cd command that is not a directory is assumed to be a variable.

$Green$ anim=~/sipp/demo/animation/voyager$colorOff
$Green$ cd anim$colorOff                   # the current directory will become ~/sipp/demo/animation/voyager.

$Green$ export var=value$colorOff          # Any variable can become an environment variable.

$Green$ declare -f$colorOff                # Find out what functions are defined in login session (name and difinition)
$Green$ declare -F$colorOff                # Print just the name of defined functions in login session

    $Bold[+] MAIL Variables$colorOff

$Green$ MAIL=/usr/mail/yourname$colorOff   # Name of file to check for incoming mailIJKJ
$Green$ MAILCHECK=$colorOff                # How often, in seconds, to check for new mail(default 60 second)
$Green$ MAILPATH=/usr/mail/you/?You have mail in \$_$colorOff   # List of filenames, separated by (:) to check for incoming mail
    "
}
substr_varlength(){
    clear
    echo -e "
$Bold[+] Substr and Variables length$colorOff

    $Green\${variable:start:length}$colorOff

# Starting from the third character           : $Green\${myvar:3}$colorOff
# Take too character starting from third      : $Green\${myvar:3:2}$colorOff
# Starting from zero to the third character   : $Green\${myvar:0:3}$colorOff
# Take foor character starting from end       : $Green\${myvar: -4}$colorOff

# Length of string variable

    $Green$ echo \${#message}$colorOff
    "
}
#
#
#
strippingStringsWithPathens(){
    clear
    echo -e "
    $Bold[+] Stripping Strings with Patherns:$colorOff

| Variable                | Purpose
|-------------------------|-----------------------------------------------------------------
| \${var#pattern}          | if the pattern matches the beginning of the variable's value, delete the shortest part that matches
| \${var##pattern}         | if the pattern matches the beginning of the variable's value, delete the longest part that matches
| \${var%pattern}          | if the pattern matches the end of the variable's value, delete the shortest part that matches and return the rest
| \${var%%pattern}         | if the pattern matches the end of the variable's value, delete the longest part that matches and return the rest
| \${var/pattern/string}   | the longest match to pattern in variable is replaced by string. Only the first match is replaced
| \${var//pattern/string}  | the longest match to pattern in variable is replaced by string. All matches are replaced
| \${#varname}             | returns the length of the value of the variable as a character string

[+] The $Green\${variable#word}$colorOff  : uses non-greedy pattern matching at the start of the string.
[+] The $Green\${variable##word}$colorOff : uses greedy pattern matching at the start of the string.
[+] The $Green\${variable%word}$colorOff  : uses non-greedy pattern matching at the end of the string.
[+] The $Green\${variable%%word}$colorOff : uses greedy pattern matching at the end of the string.

# non-greedy: Means that the shortest possible pattern that matches the expression will be selected.
# greedy    : Means that the longest possible pattern that matches the expression will be selected."
    echo
    #
    pause
    #
    phone="555-456-1414"
    echo -e "$Bold[+] Examples$colorOff

[+] Our Example   : $phone

Non-greedy    : Strip until first -:                $Green\${phone#*-}$colorOff  : ${phone#*-}
greedy        : Strip until last -:                 $Green\${phone##*-}$colorOff : ${phone##*-}
Non-greedy    : Strip out the first two section -:  $Green\${phone#*-*-}$colorOff: ${phone#*-*-}
                Striping from the end with %        $Green\${phone%-*}$colorOff  : ${phone%-*}
                Striping from the end with %        $Green\${phone%%-*}$colorOff : ${phone%%-*}

$Bold[+] More about Stripping$colorOff

# Our Example: $Green$ path='/home/cam/book/long.file.name'$colorOff

    $Green$ \${path##/*/}$colorOff      # long.file.name
    $Green$ \${path##*/}$colorOff       # long.file.name, this much more like the basename command
    $Green$ \${path#/*/}$colorOff       # cam/book/long.file.name
    $Green$ \${path%.*}$colorOff        # /home/cam/book/long.file
    $Green$ \${path%%.*}$colorOff       # /home/cam/book/long
    $Green$ \${PATH//:/'\\\n'}$colorOff # Print the PATH variable in human redable
    "
}
#
#
#
searchingReplaceStrings(){
    clear
    echo -e "$Bold[+] Searching and replacing strings:$colorOff"
    user=$(grep dabve /etc/passwd)
    echo -e "
$Bold[+] Our Example:$colorOff  $user

[+] Change dabve to Ibrahim, the first instance: $Green\${user/dabve/Ibrahim}$colorOff: ${user/dabve/Ibrahim}

[+] Change dabve to Ibrahim, all instance: $Green\${user//dabve/Ibrahim}$colorOff: ${user//dabve/Ibrahim}

$Green\${user/#dabve/BAND}$colorOff : ${user/#dabve/BAND}
$Green\${user/1000/1111}$colorOff   : ${user/1000/1111}
$Green\${user/#1000/1111}$colorOff  : ${user/#1000/1111}
$Green\${user/%bash/ksh}$colorOff   : ${user/%bash/ksh}
$Green\${user/d*e/BAND}$colorOff    : ${user/d*e/BAND}
$Green\${user/d???e/BAND}$colorOff  : ${user/d???e/BAND}
$Green\${user//d???e/BAND}$colorOff : ${user//d???e/BAND}"

}
#
#
#
deletingStrings(){
    clear
    echo -e "\t$Bold[+] Deleting strings:$colorOff

$Bold[+] Our Example: $user$colorOff

    $Green\${user/dabve}$colorOff : ${user/dabve}
    $Green\${user//dabve}$colorOff: ${user//dabve}
    $Green\${user/#dabve}$colorOff: ${user/#dabve}
    $Green\${user/%bash}$colorOff : ${user/%bash}

$Bold[+] Changing case with bash:$colorOff

    $Green\${user^^}$colorOff # UPPER: ${user^^}
    $Green\${user,,}$colorOff # lower: ${user,,} "
}
default_value(){
    clear
    echo -e "

$Bold[+] Default value with bash:$colorOff

| Variable                | Purpose
|-------------------------|-----------------------------------------------------------------
| \${count:-0}            | Returning a default value if the variable is undefined.
| \${count:=0}            | Setting a variable to a default value if it is undefined.
| \${count:?'undefined!'} | Catching errors that result from variables being undefined..
| \${count:+1}            | Testing for the existence of a variable.
| count=frogfootman       | \${count:4} returns footman. \${count:4:4} returns foot.

    $Green\${EDITOR:-\`which vim\`} \${myfile}$colorOff  # Set Editor to vim
    $Green\${EDITOR:=\`which vim\`} \${myfile}$colorOff  # Set Editor to vim as default value next time: \${EDITOR} \${myfile}
    ${Green}filesys=\${1:-/home/dabve}$colorOff          # Set first argument if not givin by user to /home/dabve
    ${Green}logFile=\${1:-/home/dabve/log.\`basename \$0\`_\`date +%b%d%Y\`}$colorOff"
    # useful Example:
    name=$(basename "$0")
    echo -e "
$Bold[+] Useful Examples:$colorOff
    Name of this script: $name
    Change extension: $Green\${name/%.sh}.txt$colorOff : ${name/%.sh}.txt

    ${Green}filename=\$1
    filename=\${1:?'filename missing.'}$colorOff     # check the first argument if exists.

    $Green$ sort -nr \$1 | head -\${2:-10}$colorOff     # Program that prints the N highest lines"
}
#
#
#
typedVariables(){
    clear
    echo -e "\t$Bold[+] Typed Variables:$colorOff

# You can set variable attrubutes with the declare built in

    ${Green}declare -i myvar$colorOff            # arthmetique variable

| Option  | Meaning
|⁻⁻⁻⁻⁻⁻⁻⁻⁻|⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻
| -a      | Array
| -f      | Function names only
| -F      | Display function names without definitions
| -i      | Integers
| -r      | Read-only
| -x      | Marks the variables for export via the environment.
"
}
#
pattern_matching(){
    clear
    echo -e "\t$Bold[+] Pattern Matching$colorOff

# You must switche on extglob

    $Green$ set -s extglob$colorOff

| Variable                | Purpose
|-------------------------|-----------------------------------------------------------------
| *(patternlist)               | matches zero or more occurrences of the given patterns
| +(patternlist)               | matches one or more occurrences of the given patterns
| ?(patternlist)               | matches zero or one occurrence of the given patterns
| @(patternlist)               | matches exactly one of the given patterns
| !(patternlist)               | matches anything except one of the given patterns

$Bold[+] Some examples:$colorOff

    ${Green}*(alice|hatter|hare)$colorOff # would match zero or more occurrence of alice, hatter and hare
    ${Green}+(alice|hatter|hare)$colorOff # would do the same except not match the null string.
    ${Green}?(alice|hatter|hare)$colorOff # would only match the null string, alice, hatter, or hare
    ${Green}@(alice|hatter|hare)$colorOff # would only match alice, hatter, or hare
    ${Green}!(alice|hatter|hare)$colorOff # match everything except alice, hetter, and hare
"
}
#
#
menu(){
    clear
    echo -e "
    $Bold[+] Bash Variables:$colorOff

# This script will help to understand how BASH work with variable: \n

    1. Globel variables
    2. Stripping Strings With Patherns.
    3. Searching And Replacng Strings
    4. Deleting Strings.
    5. Typed Variables.
    6. Sub String and Variables Length
    7. Patteern Matching.
    0. Exit.
    "
    echo
    echo -en "$Bold[:] Choose From The Menu: $colorOff"; read -rn 1 choice
}
#
while true;do
    clear
    menu
    case $choice in
        1)  global_var; pause ;;
        2)  strippingStringsWithPathens; pause ;;
        3)  searchingReplaceStrings; pause ;;
        4)  deletingStrings; pause ;;
        5)  typedVariables; pause ;;
        6)  substr_varlength; pause ;;
        7)  pattern_matching ; pause ;;
        0)  echo -e "\nBye"; break ;;
        *)  echo -en "$Red[-] Bad Choice$colorOff"; pause ;;
    esac
done
