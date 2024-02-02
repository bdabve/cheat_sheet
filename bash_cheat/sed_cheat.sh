#!/bin/bash
#: Title 	: sed-use.sh
#: Date		: 09-01-2015
#: Author	: Dabve
#: Descreption	: Description about how to use sed
# ---------------------------------------- Declaring Function --------------------------------------------------
#
# Source cliColor
if [ -s /home/dabve/bin/lib/cliColor ];then
    source /home/dabve/bin/lib/cliColor
fi
# pause function
if [ -s /home/dabve/bin/lib/functions_lib ];then
    source /home/dabve/bin/lib/functions_lib
fi
#
path="/home/dabve/programming/bash/cheat_sheet/sed"
sedOption()
{
	echo -e "\n$Bold[*] Basic SED Options:$colorOff

| -e script   | Adds commands specified in the script to the commands run while processing the input
| -f file     | Adds the commands specified in the file to the commands run while processing the input
| -n          | Doesn't produce output for each command, but waits for the print command
| -i          | Edit files in place

"
}
#
#
printCommand(){
echo -e "$Bold[+] Printing with sed$colorOff

# We want sed to find erors and print the result with p:
    $Green$ sed '/erors/p' example0.txt$colorOff

# Only print those lines matching our pattern we use the -n option:
    $Green$ sed -n '/erors/p' example0.txt$colorOff

# Lines starting with a given pattern and ending in a second pattern:
    $Green$ sed -n '/^This.*errors.$/p' example0.txt$colorOff

# Take out lines containing the erors WITH RANGES OF LINES
    $Green$ sed '2,4d'  example0.txt$colorOff

# This only prints the first two lines of the example file:
    $Green$ sed '3,\$d' example0.txt $colorOff

# The equal sign command print the current line number.
    $Green$ sed '=' example2.txt$colorOff

# The l command allow you to print both the text and non printable character.
    $Green$ sed -n 'l' example2.txt$colorOff"
}
#
#
searchAndReplace(){
echo -e "$Bold[+] Search and Replace :$colorOff

$Green$ echo 'This is a test' | sed 's/test/big test/'$colorOff             # Only the first occurrence has been replaced
$Green$ sed 's/erors/errors/' example0.txt$colorOff                         # Only the first occurrence has been replaced
$Green$ sed -i 's/erors/errors/' example0.txt$colorOff                      # Edit the file in place.

$Green$ sed 's/erors/errors/2' example0.txt$colorOff                        # Use a number 'N' to indicate to examine the 'N' occurance:
$Green$ sed 's/erors/errors/g' example0.txt$colorOff                        # Use the g command to indicate to examine the intire line:

$Green$ sed -e 's/erors/errors/g;s/This is/it is/g' example0.txt'$colorOff  # To execute more than one command, Just use -e option.
$Green$ sed 's/^/> /' example0.txt$colorOff                                 # To insert a string at the beginning of each line of a file
$Green$ sed 's/$/EOL/' example0.txt$colorOff                                # Insert strings in the end of each line:

# The w substitution flag produces the same output but stores the output in the specified file:
    $Green$ sed 's/erors/errors/w output.txt' example0.txt$colorOff

# Replacing characters:

    $Green$ sed 's/\/bin\/bash/\/bin\/csh/' /etc/passwd$colorOff          # First example working with slash '/':
    $Green$ sed 's!/bin/bash!/bin/csh!' /etc/passwd$colorOff              # Using !

# Second example using addresses:
    $Green$ sed '2s/dog/cat/' example2.txt$colorOff
    $Green$ sed '2,3s/dog/cat/' example2.txt$colorOff"
}
#
#
deletingInsertingAppending(){
echo -e "$Bold[#] Deleting lines:$colorOff

    $Green$ sed '/erors/d' example0.txt$colorOff        # Deleting lines of input containing a pattern:
    $Green$ sed '3d' example1.txt$colorOff              # Delete line number 3.
    $Green$ sed '3,\$d' example1.txt$colorOff           # Delete from line number 3 until the end of file
    $Green$ sed '/number 1/d' example1.txt$colorOff     # Delete line containing 'number 1'"
#
pause
#
echo -e "$Bold[+] Inserting and Appending Text:$colorOff

# When you use the insert command, the text appears before the data stream text:
    $Green$ echo \"Test line 2\" | sed 'i\\Test line 1'$colorOff

# When you use the append command, the text appears after the data stream text:
    $Green$ echo \"Test line 2\" | sed 'a\\Test line 1'$colorOff

# Here's an example of adding a new line after line 3 in the data stream:
    $Green$ sed '3a\\This is an appended line.' example1.txt$colorOff

# Here's an example of adding a new line in the end of file:
    $Green$ sed '\$a\\This is an appended line.' example1.txt$colorOff"
#
pause
#
echo -e "$Bold[+] Changing Line:$colorOff

# The change command work the same way as the insert and append command, in that you must specify the line separately from the rest
    $Green$ sed '3c\\This is a changing line of text.' example1.txt$colorOff

# You can also use a text pattern for the address:
    $Green$ sed '/number 3/c\\This is a changing line of text.' example1.txt$colorOff

# You can use an address range in the change command, but the results may not be what you expect:
    $Green$ sed '2,3/c\\This is a changing line of text.' example1.txt$colorOff"

    #
    pause
    ##

echo -e "$Bold[+] Reading data from a file:$colorOff

    # Simple example
    $Green$ cat script.sed
    s/brown/green/
    s/fox/elephant/
    s/dog/cat
    $ sed -f script.sed data.txt$colorOff

    $Green$ sed '3r addingdata.txt' example1.txt$colorOff


    $Green$ sed '/LIST/{
    r addingdata1.txt
    d
    }' notice.std$colorOff"
}
##
#
readingSedFromFile()
{
	echo -e "$Bold[+] If you have lots of sed commands. Use the -f to specify the file in the sed commands$colorOff"
    echo
    echo -e "\t$Green$ cat script1.sed"
    echo
    cat "$path/script1.sed"
    echo
	echo -e "\t\n$Green$ sed -f script1.sed example0.txt$colorOff"
}

#================================ Main script =============================================================

menu(){
	clear
    echo -e "${Bold}[+] Sed menu$colorOff

    1. SED Options.
    2. Use SED from file.
    3. Printing with SED.
    4. Search and Replace with SED.
    5. Deleting, Inserting, Appending Character with SED.
    6. Advanced SED
    0. Exit."
    echo
    echo -en "$Yellow[:] Choose From the Menu: $colorOff"; read -rn 1 choice ;clear
}
#
while true;do
	menu
	case $choice in
		1)  sedOption; pause ;;
		2)  readingSedFromFile; pause ;;
		3)  printCommand; pause ;;
		4)  searchAndReplace; pause ;;
		5)  deletingInsertingAppending; pause ;;
		6)  .$path/sedAdvanced.sh; pause ;;
		0)  echo -e "\nBye"; break ;;
		*)  echo -e "\n$Red[-] Wrong choice $colorOff\n" ;pause ;;
	esac
done
