#!/bin/bash
#: Title 	: advanced sed editor
#: Date		: 16-Feb-2016
#: Author	: Dabve
#: Descreption	: this script show advanced sed use
#: Option	: none

#---------------------------- Global variable and function -----------------------
pause(){
	echo -en "\nHit any <KEY> to continue "
    read -rn 1
    clear
}
#
if [ -s /home/dabve/bin/lib/cliColor ];then
    source /home/dabve/bin/lib/cliColor
fi
#
data1=$(mktemp -t data1.XXXXXX)
data2=$(mktemp -t data2.XXXXXX)
data3=$(mktemp -t data3.XXXXXX)
data4=$(mktemp -t data4.XXXXXX)
#
#---------------------------------------------------------------------------------
#
echo "This is the header line.

This is the last line." > "$data1"
#
clear
echo -e "# Sometimes, you need to perform actions on data that spans more than one line.
# This is especially true if you're trying to find or replace a phrase.
# The sed editor includes three special commands that you can use to process multiline text:

    • N adds the next line in the data stream to create a multiline group for processing.
    • D deletes a single line in a multiline group.
    • P prints a single line in a multiline group."
#
echo -e "# This is our example:"
echo -en "$Blue"
cat "$data1"
echo -en "$colorOff"
echo -e "\n\t$Green$ sed '/^$/d' $data1 $colorOff"
echo -en "$Blue"
sed '/^$/d' "$data1"
echo -en "$colorOff"
echo -e "
# Because the line you want to remove is blank, you don't have any text you can search for to uniquely identify the line.
# The n command moves the sed editor to the next line of text"
echo -e "\t$Green$ sed '/header/{n;n;d}' $data1$colorOff"
echo -en "$Blue"
sed '/header/{n;n;d}' "$data1"
echo -en "$colorOff"
#
pause
#
echo "This is the header line.
This is the first data line.
This is the second data line.
This is the last line." > "$data4"
#
echo -e "\t$Bold [*] Combining lines of text:$colorOff"
echo -e "# The multiline version of the next command (which uses a capital N) adds the next line of text to the text already in the pattern space."
echo -e "[+] Out Example"
echo
echo -en "$Blue"
cat "$data4"
echo -en "$colorOff"
echo
echo -e "\t$Green $ sed '/first/{N;s/\\\n/ /}' $data4$colorOff"
echo
echo -en "$Blue"
sed '/first/{ N;s/\n/ / }' "$data4"
echo -en "$colorOff"
echo -e "
# The sed editor script searches for the line of text that contains the word 'first'.
# When it finds the line, it uses the N command to combine the next line with that line.
# It then uses the substitution command (s) to replace the newline character with a space."
#
pause
#
echo "On Tuesday, the Linux System
Administrator's group meeting will be held.
All System Administrator's should attend.
Thank you for your attendance." > "$data2"
#
echo -e "[+] Our example:"
echo
echo -en "$Blue"
cat "$data2"
echo -en "$colorOff"
echo
echo -e "\t$Green $ sed 'N;s/System Administrator/Desktop User/' $data2$colorOff"
echo
echo -en "$Blue"
sed 'N;s/System Administrator/Desktop User/' "$data2"
echo -en "$colorOff"
echo
echo -e "# In the situation where the phrase is split between two lines, the substitution command doesn't recognize the matching pattern."
#
pause
#
echo -e "\n\t$Green$ sed 'N;s/System.Administrator/Desktop User/' $data2$colorOff"
echo
echo -en "$Blue"
sed 'N;s/System.Administrator/Desktop User/' "$data2"
echo -en "$colorOff"
echo
echo -e "# Notice that the substitution command uses (.) between the word System and Administrator to match both the space and the newline."
echo
echo -en "$Blue"
echo -e "$Green$ sed 'N; s/System\\\nAdministrator/Desktop\\\nUser/; s/System Administrator/Desktop User/' $data2$colorOff"
echo -en "$colorOff"
echo
echo -en "$Blue"
sed 'N; s/System\nAdministrator/Desktop\nUser/; s/System Administrator/Desktop User/' "$data2"
echo -en "$colorOff"
#
pause
#
echo -e "\t$Bold[*] Navigating the multiline delete command:$colorOff"
echo -e "\n\t$Green$ sed 'N; /System\\\nAdministrator/d' $data2$colorOff"
echo -en "$Blue"
sed 'N; /System\nAdministrator/d' "$data2"
echo -en "$colorOff"
echo -e "# The delete command looked for the words System and Administrator in separate lines and deleted both of the lines in the pattern space."
echo -e "\n\t$Green$ sed 'N; /System\\\nAdministrator/D' $data2$colorOff"
echo -en "$Blue"
sed 'N; /System\nAdministrator/D' "$data2"
echo -en "$colorOff"
echo -e "# The multiline delete command (D), deletes only the first line in the pattern space.
# It removes all characters up to and including the newline"
echo
echo -e "# Here's an example of removing a blank line that appears before the first line in a data stram:"
echo -e "\n\t$Green$ sed '/^$/{N ; /last/D}' $data1$colorOff"
sed '/^$/{N; /last/D}' "$data1"
echo
echo -e "# This sed editor script looks for blank lines and then uses the N command to add the next line of text into the pattern space.
# If the new pattern space contents contain the word last, the D command removes the first line in the pattern space."
#
pause
#
echo -e "\t$Bold[*] Navigating the multiline print command:$colorOff"
echo "
# The multline print (P) command follows along using the same technique.
# It print only the first line in a multiline pattern space.
# This include all characters up to the newline character in the pattern space
"
echo -e "\n\t$Green$ sed 'N; /System\\\nAdministrator/P' $data2$colorOff"
echo -en "$Blue"
sed -n 'N; /System\nAdministrator/P' "$data2"
echo -en "$colorOff"
#
pause
#
echo -e "\t$Bold[*] HOLDING SPACE:$colorOff

[+] The sed Editor Hold Space Commands:
 _______________________________________________________________
| Command	| 	Description				|
|⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼|
|      h	| Copies pattern space to hold space		|
|      H	| Appends pattern space to hold space		|
|      g	| Copies hold space to pattern space		|
|      G	| Appends hold space to pattern space		|
|      x 	| Exchange contents of pattern and hold space	|
 ---------------------------------------------------------------"

echo 'This is the header line.
This is the first data line.
This is the second data line.
This is the last line' > "$data3"
echo -e "[+] This is our example:"
echo -en "$Blue"
cat "$data3"
echo -en "$colorOff"
echo -e "\n\t$Green$ sed -n '/first/ {h; p; n; p; g; p}' $data3$colorOff"
echo -en "$Blue"
sed -n '/first/ {h; p; n; p; g; p}' "$data3"
echo -en "$colorOff"
#
pause
#
echo -e "\t$Green$ sed -n '/first/ {h; n; p; g; p}' $data3$colorOff"
echo -en "$Blue"
sed -n '/first/ {h; n; p; g; p}' "$data3"
echo -en "$colorOff"
#
pause
#
echo -e "\t$Bold[*] Negating Command:$colorOff
# The exclamation mark command (!) is used to negate a command.
    $Green$ sed -n '/header/!p' $data1$colorOff"
echo -en "$Blue"
sed -n '/header/!p' "$data1"
echo -en "$colorOff"
echo
echo -e "[+] Creating a line-reversing sed editor script:

    $Green$ cat $data1$colorOff"
echo -en "$Blue"
cat "$data1"
echo -en "$colorOff"
echo -e "\n\t$Green$ sed -n '{1!G; h; \$p}' $data1$colorOff"
echo -en "$Blue"
sed -n '{1!G; h; $p}' "$data1"
echo -en "$colorOff"
#
pause
#
echo -e "$Bold[+] Advanced Examples: $colorOff"
echo
echo "# The (&) is used to represent the matchin pattern in the substitution comman."
echo -en "\t$Green$ echo 'The cat sleeps in his hat.' | sed 's/.at/\"&\"/g'$colorOff                # Out: "
echo 'The cat sleeps in his hat.' | sed 's/.at/\"&\"/g'
#
echo -en "\t$Green$ echo "the System Administrator manuel" | sed 's/\\(System\\) Administrator/\\1 User/'$colorOff     # Out: "
echo "the System Administrator manuel" | sed 's/\(System\) Administrator/\1 User/'
#
echo -en "\t$Green$ echo "That furry cat is pretty" | sed 's/furry \\(.at\\)/\\1/'$colorOff         # Out: "
echo "That furry cat is pretty" | sed 's/furry \(.at\)/\1/'
#
echo -en "\t$Green$ echo "That furry hat is pretty" | sed 's/furry \\(.at\\)/\\1/'$colorOff         # Out: "
echo "That furry hat is pretty" | sed 's/furry \(.at\)/\1/'
#
echo
echo -e "$Green$ $ sed 'G' data2.txt$colorOff       # Insert a blank line between lines in a text file"
echo -e "$Green$ $ sed '\$!G' data2.txt$colorOff    # Insert a blank line between lines in a text file but not the last line"
#
rm "$data1" "$data2" "$data3"
exit
