#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error
path="/home/dabve/programming/bash/cheat_sheet/userInput"
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
internalFieldSeparator()
{
	clear
	echo -e "$Bold[+]Internal Field Separator (IFS):$colorOff

# By default, the bash shell considers the following character as field deparator:
	• A space.
	• A tab.
	• A newline

• A safe practice to use IFS in a long script is coded like this:

	${Green}IFS.OLD=\$IFS
	IFS=\$'\\\n'$colorOff                    # the new IFS = to a newline
	${Green}IFS=\$IFS.OLD$colorOff                   # now return to the old IFS"
}

##
grabbingAllData()
{
	echo -e "$Bold[+] Grabbing all the data:$colorOff

# Using the ${Bold}\$#$colorOff variable to determine how many parameters are on the command line

# The ${Bold}\$*$colorOff and ${Bold}\$@$colorOff variables provide easy access to all your parameters.

# Both of these variables include all the command line parameters within a single variable.

# The ${Bold}\$*$colorOff variable takes all the parameters supplied on the command line as a single word.

# The ${Bold}\$@$colorOff variable, on the other hand, takes all the parameters supplied on the command line as separate words in the same string.
# It allows you to iterate through the values, separating out each parameter supplied.

# For more information see the file suit_importantNote.sh."
}
##
beingShifty()
{
	echo -e "$Bold[+] Being Shifty:$colorOff

# The bash shell provides the shift command to help you manipulate command line parameters.

# When you use the shift command, it moves each parameter variable one position to the left by default.
# Thus, the value for variable \$3 is moved to \$2, the value for variable \$2 is moved to \$1, and the value for variable \$1 is discarded

# for more information: Use this command: $Green$ ./shiftparam.sh param1 param2 param3 param4 $colorOff"
echo -e "$Green"; cat "$path/shiftparam.sh"; echo -e "$colorOff"
}
##
workingWithOptions()
{
	echo -e "$Bold[+] Working with options:$colorOff

# You saw how to use the shift command to work your way down the command line parameters provided with the script program.
# You can use this same technique to process command line options.

# For more information use this command $Green$ ./shiftopt.sh -a -b -c -d$colorOff"
echo -e "$Green"; cat "$path/shiftopt.sh" ; echo -e "$colorOff"
}
##
separatingOptionFromParameters()
{
	echo -e "$Bold[+] Separating option from parameters:$colorOff

# The standard way to do this in Linux is to separate the two with a special character code that tells the script when the options are finished and when the normal parameters start.

# For Linux, this special character is the double dash (--).
# The shell uses the double dash to indicate the end of the option list.

# For more information use $Green$ ./optionWparam.sh -c -a -b -- test1 test2 test3$colorOff"
#
pause
#
echo -e "# Example: $Green\n $(cat "$path/optionWparam.sh") $colorOff"
}
##
processingOptionsWithValues()
{
	echo -e "$Bold[+] Processing options with values:$colorOff

# Some options require an additional parameter value. In these situations, the command line looks something like this:
$Green$(cat "$path/optionWparam01.sh")$colorOff
# Example: $Green$ ./optionWparam01.sh -a -b test1 -d$colorOff"
}
##
getoptCommand()
{
	echo -e "$Bold[+] Using the getopt command:$colorOff

# The getopt command is a great tool to have handy when processing command line options and parameters.
# It reorganizes the command line parametersto make parsing them in your script easier.

# The getopt command can take a list of command line options and parameters, in any form, and automatically turn them into the proper format.
# It uses the following command format: getopt optstring parameters

# Example:
    $Green$ getopt ab:cd -a -b test1 -cd test2 test3
    $ getopt ab:cd -a -b test1 -cde test2 test3$colorOff

# If you prefer to just ignore the error messages, use getopt with the -q option:
	$Green$ getopt -q ab:cd -a -b test1 -cde test2 test3$colorOff
"
#
pause
#
echo -e "\t$Bold[+] Using the getopt on your script:$colorOff
# The trick is to replace the existing command line options and parameters with the formatted version produced by the getopt command.
# The way to do that is to use the set command.

# This looks something like this:  $Green$ set -- \$(getopt -q ab:cd "\$@")$colorOff
$Green$(cat "$path/getopt.sh")$colorOff
# Example: $Green$ ./getopt.sh -a -b test1 -cd test2 test3 test4$colorOff"
}
##
advancingGetopts()
{
	echo -e "$Bold[+] Advancing to getopts:$colorOff

# ${Bold}getopts$colorOff takes two arguments.
    * The first is a string that can contain letters and colons. Each letter is a valid option
    * The second argument is the name of a variable that hold each option letter(without any leading dash) as it is processed
# An initial colon causes ${Bold}getopts$colorOff not to print an error message when the user gives an invalid option.
# If a letter is followed by a colon, the option requires an argument.
# As long as there are options left to process, ${Bold}getopts$colorOff will return exit status 0; when the option are exhausted, it returns exit status 1, causing while loop to exit
# if the user types an invalid option, getopts normaly prints an unfortunate error message (cmd: getopts: illegal option -o) and set opt to ?
# if an option has an argument, ${Bold}getopts$colorOff stores it in the ${Bold}OPTARG$colorOff.
# ${Bold}getopts$colorOff stores in the variable ${Bold}OPTIND$colorOff the number of the next argument to be processd.

$Green$ while getopts \":ab:c\" opt; do
case \$opt in
    a ) process option -a;;
    b ) process option -b
        \$OPTARG is the option's argument ;;
    c ) process option -c ;;
    \?) echo 'usage: script [-a] [-b b_argument] [-c] args.'; exit 1 ;;
esac
shift \$(( \$OPTIND - 1 ))
normal processing of arguments$colorOff"

}
#
standardizingOptions()
{
	echo -e "$Bold[+] Standardizing Options:$colorOff
# However, a few letter options have achieved a somewhat standard meaning in the Linux world, your scripts will be more user-friendly.

| Option	|   Description
|-----------|--------------------------------------------------
| -a        | Shows all objects
| -c        | Produces a count
| -d        | Specifies a derectory
| -e        | Expands an object
| -f        | Specifies a file to read data from
| -h        | Displays a help message for the command
| -i        | Ignores text case
| -l        | Produces a long format version of the output
| -n        | Uses a non-interactive (batch) mode
| -o        | Specifies an output file to redirect output to
| -q        | Runs in quiet mode
| -r        | Processes directories and file recursively
| -s        | Runs in silent mode
| -v        | Produces verbose output
| -x        | Excludes an object
| -y        | Answer yes to all questions"
}
#
#
#---------------- Menu -----------------------
menu()
{
	clear
	echo -e "$Bold[+] Options and Parameters in Bash$colorOff

	1.  Internal Field Separator (IFS):
	2.  Grabbing all the data
	3.  Being Shifty
	4.  Working with options
	5.  Separating option from parameters
	6.  Processing options with values
	7.  Using the getopt command
	8.  Advancing to getopts Command
	9.  Standardizing Options
	0.  Exit."
    echo
	echo -en "[:] Choose From The Menu: "; read -rn 1 choice
}
#------------------------------------------- Main Script -----------------------------------------
while true;do
	menu
	case $choice in
		1) clear; internalFieldSeparator;;
		2) clear; grabbingAllData;;
		3) clear; beingShifty;;
		4) clear; workingWithOptions;;
		5) clear; separatingOptionFromParameters;;
		6) clear; processingOptionsWithValues;;
		7) clear; getoptCommand;;
		8) clear; advancingGetopts;;
		9) clear; standardizingOptions;;
		0) echo -e "\nby"; break;;
		*) echo -en  "$Red[-] Sorry Wrong Choice. ";;
	esac
	pause
done
