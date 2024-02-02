#!/bin/bash
#: Title 	: regex.sh
#: Date		: 12-Feb-2016
#: Author	: Dabve
#: Descreption	: regex

tmpFile=$(mktemp -t regex.XXXXXX)
tmpFile2=$(mktemp -t regex2.XXXXXX)
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
regex_type(){
    clear
    echo -e "$Bold[+] Type of regular expressions:$colorOff
	# The POSIX Basic regex (BRE) engine: Most linux utilities coform to it such as SED
	# The POSIX Extended regex (ERE) engine: Found in programming languages conform to it and GAWK for example.

$Bold[+] Special characters:$colorOff

# $Green.*[]^\${}\\+?|()$colorOff: You can't use these characters by themselves, you need to escape them to use them as a normal charactere."

    echo -en "$Green$ echo \"3 / 2\" | sed -n '/\//p'$colorOff  # Out: "
    echo "3 / 2" | sed -n '/\//p'
#
    echo -e "
$Bold[+] Anchor characters:$colorOff

# You can use two special characters (^$) to anchor a pattern to either the beginning or the end of line.\n"

    echo -en "$Green$ echo 'Books are great' | sed -n '/^Book/p'$colorOff                                   # Out: "
    echo "Books are great" | sed -n '/^Book/p'
    echo -en "$Green$ echo 'This is a good book' | sed -n '/book$/p'$colorOff                               # Out: "
    echo "This is a good book" | sed -n '/book$/p'
    echo -e "$Green$ echo 'Good books' | sed -n '/book$/p'$colorOff                                         # Out Nothings"
    echo -en "$Green$ echo \"This is a test of using both anchor\\\nTest\" | sed -n '/^Test$/p'$colorOff    # Out: "
    echo -e "This is a test of using both anchor\nTest" | sed -n '/^Test$/p'
    echo -e "$Green$ sed '/^$/d' file.txt$colorOff                                                          # Deleting Empty lines"
}
#
#
dot(){
    clear
    echo -e "$Bold[+] The dot character:$colorOff
# The dot (.) is used to match any single character exept a newline character.
# The dot must match a character, however, if there's no character in the place of the dot, then the pattern fails.

$Bold# EXAMPLE:$colorOff"
    echo "This is a test of line.
The cat is sleeping.
That is a very nice hat.
This test is at line four.
at ten o'clock we'll go home." > "$tmpFile"
    echo
    cat "$tmpFile"
    echo
    echo -e "\t$Green$ sed -n '/.at/p' $tmpFile$colorOff"
    sed -n '/.at/p' "$tmpFile"
    echo
    echo -e "# The space take count in regex"
}
#
#
character_classes(){
    clear
    echo -e "$Bold[+] Character classes:$colorOff

# To define a class of characters class, you use square brackets [], The brackets should contain any character you want to include.
# If one of the characters from the character class is in the data stream, it matches the pattern.
    $Green$ sed -n '/[ch]at/p' $tmpFile$colorOff"
    sed -n '/[ch]at/p' "$tmpFile"
    echo -en "$Green$ echo 'Yes' | sed -n '/[Yy]es/p'$colorOff          # Out: "
    echo 'Yes' | sed -n '/[Yy]es/p'
    echo -en "$Green$ echo 'yes' | sed -n '/[Yy]es/p'$colorOff          # Out: "
    echo 'Yes' | sed -n '/[Yy]es/p'
    echo -en "$Green$ echo 'yes' | sed -n '/[Yy][eE][sS]/p'$colorOff    # Out: "
    echo 'yEs' | sed -n '/[Yy][eE][sS]/p'
#
    echo -e "$Bold[+] Using numbers:$colorOff"
    echo
    echo "This line doesn't contain a number.
This line has 1 number on it.
This line a number 2 on it.
This line has a number 4 on it." > "$tmpFile2"
    cat "$tmpFile2"
    echo -e "$Green\t$ sed -n '/[0123]/p' $tmpFile2$colorOff"
    sed -n '/[0123]/p' "$tmpFile2"
    echo -e "# Place a caret (^) character at the beginning of the character class range to reverse the effect.
	$Green$ sed -n '/[^ch]at/p' $tmpFile$colorOff"
    sed -n '/[^ch]at/p' "$tmpFile"
#
pause
##
    echo -e "# We can use a range of character within a character class by using the dash symbole (-):
	$Green$ sed -n '/[c-h]at/p' $tmpFile$colorOff"
    sed -n '/[c-h]at/p' "$tmpFile"
    echo -e "$Bold[+] Special character classes:$colorOff

# To define your own character classes, the BRE contain special character classes, use to match against specific type of character.
    [[:alpha:]]	== Matches any alphabetical character, either upper or lower case.
    [[:alnum:]]	== Matches any alphanumeric character 0-9 A-Z or a-z
    [[:blank:]]	== Matches space or tab character.
    [[:digit:]]	== Matches numerical digit 0-9.
    [[:lower:]]	== Matches any lowercase alphabetical a-z.
    [[:print:]]	== Matches any printable character.
    [[:punct:]]	== Matches a punctuation character.
    [[:space:]]	== Matches any space character: space, tab, NL, FF, VT, CR.
    [[:upper:]]	== Matches any uppercase alphabetical A-Z."
    echo
    echo -en "$Green$ echo 'abc' | sed -n '/[[:alpha:]]/p'$colorOff             # Out: "
    echo "abc" | sed -n '/[[:alpha:]]/p'
    echo -en "$Green$ echo 'abc123' | sed -n '/[[:digit:]]/p'$colorOff          # Out: "
    echo "abc123" | sed -n '/[[:digit:]]/p'
    echo -en "$Green$ echo 'This is, a test' | sed -n '/[[:punct:]]/p'$colorOff # Out: "
    echo "This is, a test" | sed -n '/[[:punct:]]/p'
    echo -en "$Green$ echo 'This is a test' | sed -n '/[[:punct:]]/p'$colorOff  # Out: "
    echo "This is a test" | sed -n '/[[:punct:]]/p'
    echo
    echo -e "# Using the special character classes is an easy way to define ranges. instead of having to use a range [0-9], we can use [[:digit:]]."
}
#
#
character_ranges(){
    clear
    echo -e "$Bold[+] Range of charecters$colorOff"
    echo
    echo -en "$Green$ echo '18392' | sed -n '/^[0-9][0-9][0-9][0-9][0-9]$/p'$colorOff # Out: "
    echo "18392" | sed -n '/^[0-9][0-9][0-9][0-9][0-9]$/p'
    echo -e "$Green$ echo 'A8392' | sed -n '/^[0-9][0-9][0-9][0-9][0-9]$/p'$colorOff  # Out: "
    echo "A8392" | sed -n '/^[0-9][0-9][0-9][0-9][0-9]$/p'
    echo -en "$Green$ echo 'a18392' | sed -n '/[0-9][0-9][0-9][0-9][0-9]/p'$colorOff  # Out: "
    echo "a18392" | sed -n '/[0-9][0-9][0-9][0-9][0-9]/p'
    echo
    echo "# You can also specify multiple, non-continuous ranges in a single character class"
    echo -e "$Green$ sed -n '/[a-ch-m]at'$tmFile$colorOff"
    sed -n '/[a-ch-m]at/p' "$tmpFile"
    echo
    echo -e "$Green$ echo 'Im getting too fat' | sed -n '/[a-ch-m]at/p'$colorOff # Out: "
    echo "Im getting too fat" | sed -n '/[a-ch-m]at/p'
}
#
#
asterisk(){
    clear
    echo -e "$Bold[+] The asterisk (*):$colorOff

# Placing the asterisk after a character signifies that the character must appear zero or more time in the text to match the pattern:\n"

    echo -en "$Green$ echo 'ik' | sed -n '/ie*k/p' | sed -n '/ie*k/*p'$colorOff             # Out: "
    echo "ik" | sed -n '/ie*k/p'
    echo -en "$Green$ echo 'ieeek' | sed -n '/ie*k/p' | sed -n '/ie*k/*p'$colorOff          # Out: "
    echo "ieek" | sed -n '/ie*k/p'
    echo "# The e* in the pattern indicates that the letter e may or may not appear in the test."
    echo
    echo -en "$Green$ echo 'I ate a potatoe with my lunch.' | sed -n '/potato*/p'$colorOff  # Out: "
    echo "I ate a potatoe with my lunch." | sed -n '/potato*/p'
    echo -en "$Green$ echo 'I ate a potato with my lunch.' | sed -n '/potato*/p'$colorOff   # Out: "
    echo "I ate a potato with my lunch." | sed -n '/potato*/p'
    echo
    echo -e "# Another handy feature is combining the dot special character with the asterisk special character.
    # This combination provides a pattern to match any number of any characters."
    echo -en "$Green$ echo 'this is a regular pattern expression' | sed -n '/regular.*expression/p'$colorOff # Out: "
    echo "This is a regular pattern expression" | sed -n '/regular.*expression/p'
    echo
    echo -en "$Green$ echo 'bt' | sed -n '/b[ae]*t/p'$colorOff          # Out: "
    echo "bt" | sed -n '/b[ae]*t/p'
    echo -en "$Green$ echo 'bat' | sed -n '/b[ae]*t/p'$colorOff         # Out: "
    echo "bat" | sed -n '/b[ae]*t/p'
    echo -en "$Green$ echo 'baaeeet' | sed -n '/b[ae]*t/p'$colorOff     # Out: "
    echo "baaeeet" | sed -n '/b[ae]*t/p'
}
#
#------------------------------------------------------
#
question_mark(){
    clear
    echo -e "$Bold[+] Extended Regular Expressions:$colorOff

# The POSIX ERE pattern include a few additional symbole that are used by some Linux application and utilities.
# The gawk programme recognizes the ERE pattern, but the sed editor doesn't.\n"
    echo -e "$Bold[+] The question mark (?):$colorOff

# The question mark is similar to the asterisk, but the question mark indicat that the preceding character can appear zero or one time.\n"

    echo -en "$Green$ echo 'bt' | gawk '/be?t/{print \$0}'$colorOff     # Out: "
    echo "bt" | gawk '/be?t/{print $0}'
    echo -en "$Green$ echo 'bt' | gawk '/be?t/{print \$0}'$colorOff     # Out: "
    echo "bet" | gawk '/be?t/{print $0}'
    echo -e "$Green$ echo 'beet' | gawk '/be?t/{print \$0}'$colorOff   # Out: "
    echo "beet" | gawk '/be?t/{print $0}'
    echo -en "$Green$ echo 'bt' | gawk '/b[ae]?t/{print \$0}'$colorOff  # Out: "
    echo "bt" | gawk '/b[ae]?t/{print $0}'
    echo
    echo -en "$Green$ echo 'bet' | gawk '/b[ae]?t/{print \$0}'$colorOff # Out: "
    echo "bet" | gawk '/b[ae]?t/{print $0}'
    echo -en "$Green$ echo 'bat' | gawk '/b[ae]?t/{print \$0}'$colorOff # Out: "
    echo "bat" | gawk '/b[ae]?t/{print $0}'
    echo -e "$Green$ echo 'bot' | gawk '/b[ae]?t/{print \$0}'$colorOff # Out: "
    echo "bot" | gawk '/b[ae]?t/{print $0}'
    echo
    echo "# If zero or one character from the character class appears, the pattern match passes.
# However, if both characters appear, or if one of the characters appears twice, the pattern match fails."
}
#
#
plus_sign(){
    clear
    echo -e "$Bold[+] The plus (+) sign:$colorOff

# The + sign is another pattern symbol that's similar to the asterisk.
# The + sign indicat the preceding character ca appears one or more time, but must present at least once."
    echo
	echo -en "$Green$ echo 'beeet' | gawk '/be+t/{print \$0}'$colorOff      # Out: "
    echo "beeet" | gawk '/be+t/{print $0}'
	echo -e "$Green$ echo 'bt' | gawk '/be+t/{print \$0}'$colorOff         # Out: "
    echo "bt" | gawk '/be+t/{print $0}'
	echo -en "$Green$ echo 'bet' | gawk '/be+t/{print \$0}'$colorOff        # Out: "
    echo "bet" | gawk '/be+t/{print $0}'

    echo -e "# If the e is not present, the pattern match fail.

# The + sign also works with character classes, the same way as the asterisk and question mark do:"
    echo
	echo -e "$Green$ echo 'bt' | gawk '/b[ae]+t/{print \$0}'$colorOff          # Out: "
    echo "bt" | gawk '/b[ae]+t/{print $0}'
	echo -en "$Green$ echo 'bat' | gawk '/b[ae]+t/{print \$0}'$colorOff         # Out: "
    echo "bat" | gawk '/b[ae]+t/{print $0}'
	echo -en "$Green$ echo 'beat' | gawk '/b[ae]+t/{print \$0}'$colorOff        # Out: "
    echo "beat" | gawk '/b[ae]+t/{print $0}'
	echo -en "$Green$ echo 'beeat' | gawk '/b[ae]+t/{print \$0}'$colorOff       # Out: "
    echo "beeat" | gawk '/b[ae]+t/{print $0}'
}
#
#
braces(){
    clear
    echo -e "$Bold[+] Using braces:$colorOff
# Curely braces {} are available in ERE to allow you to specify a limit on a repeatable regular expression.
# This is referred as an interval. we can express the interval in tow formats:

	*) m: The regex appears exactly m tomes.
	*) m, n: The regex appears at least m times, but no more than n times.

# This feature allows you to fine-tune exactly how many times you allow a character to appear in a pattern
# By default the gawk programme doesn't recognize regex interval. we must specify the $Bold--re-interval$colorOff command for gawk."
    echo
	echo -en "$Green$ echo 'bet' | gawk --re-interval '/be{1}t/{print \$0}'$colorOff    # Out: "
    echo 'bet' | gawk --re-interval '/be{1}t/{print $0}'
	echo -e "$Green$ echo 'beet' | gawk --re-interval '/be{1}t/{print \$0}'$colorOff   # Out: "
    echo 'beet' | gawk --re-interval '/be{1}t/{print $0}'
    echo
    echo -e "# By specifying an enterval of one, we restrict the number of time the character can be present."
    echo
	echo -e "$Green$ echo bt | gawk --re-interval '/be{1,2}t/{print \$0}'$colorOff         # Out: "
    echo bt | gawk --re-interval '/be{1,2}t/{print $0}'
	echo -en "$Green$ echo bet | gawk --re-interval '/be{1,2}t/{print \$0}'$colorOff        # Out: "
    echo bet | gawk --re-interval '/be{1,2}t/{print $0}'
	echo -en "$Green$ echo beet | gawk --re-interval '/be{1,2}t/{print \$0}'$colorOff       # Out: "
    echo beet | gawk --re-interval '/be{1,2}t/{print $0}'
	echo -e "$Green$ echo beeet | gawk --re-interval '/be{1,2}t/{print \$0}'$colorOff      # Out: "
    echo beeet | gawk --re-interval '/be{1,2}t/{print $0}'
	echo -e "$Green$ echo bt | gawk --re-interval '/b[ae]{1,2}t/{print \$0}'$colorOff      # Out: "
    echo bt | gawk --re-interval '/b[ae]{1,2}t/{print $0}'
	echo -en "$Green$ echo beat | gawk --re-interval '/b[ae]{1,2}t/{print \$0}'$colorOff    # Out: "
    echo beat | gawk --re-interval '/b[ae]{1,2}t/{print $0}'
	echo -e "$Green$ echo beeat | gawk --re-interval '/b[ae]{1,2}t/{print \$0}'$colorOff     # Out: "
    echo beeat | gawk --re-interval '/b[ae]{1,2}t/{print $0}'
}
#
#
pip_symbol(){
    clear
    echo -e "$Bold[+] The pipe symbol:$colorOff
# The pipe symbol == OR."
    echo
	echo -en "$Green$ echo The cat is asleep | gawk '/cat|dog/{print \$0}'$colorOff         # Out: "
    echo The cat is asleep | gawk '/cat|dog/{print $0}'
	echo -en "$Green$ echo The dog is asleep | gawk '/cat|dog/{print \$0}'$colorOff         # Out: "
    echo The dog is asleep | gawk '/cat|dog/{print $0}'
	echo -e "$Green$ echo The sheep is asleep | gawk '/cat|dog/{print \$0}'$colorOff       # Out: "
    echo The sheep is asleep | gawk '/cat|dog/{print $0}'
    echo
	echo -en "$Green$ echo He has a hat | gawk '[ch]at|dog/{print \$0}'$colorOff       # Out: "
    echo He has a hat | gawk '/[ch]at|dog/{print $0}'
}
#
#
grouping_expressions(){
    clear
    echo -e "$Bold[+] Grouping expressions:$colorOff
# Regex patterns can also be grouped by using parantheses."
    echo
	echo -en "$Green$ echo 'cat' | gawk '/(c|b)a(b|t)/{print \$0}'$colorOff         # Out: "
    echo "cat" | gawk '/(c|b)a(b|t)/{print $0}'
	echo -en "$Green$ echo 'bat' | gawk '/(c|b)a(b|t)/{print \$0}'$colorOff         # Out: "
    echo "bat" | gawk '/(c|b)a(b|t)/{print $0}'
	echo -e "$Green$ echo 'tab' | gawk '/(c|b)a(b|t)/{print \$0}'$colorOff          # Out: "
    echo "tab" | gawk '/(c|b)a(b|t)/{print $0}'
	echo -e "$Green$ echo 'tac' | gawk '/(c|b)a(b|t)/{print \$0}'$colorOff          # Out: "
    echo "tac" | gawk '/(c|b)a(b|t)/{print $0}'
    echo
	echo -en "$Green$ echo 'Sat' | gawk '/Sat(urday)?/{print \$0}'$colorOff             # Out: "
    echo "Sat" | gawk '/Sat(urday)?/{print $0}'
	echo -en "$Green$ echo 'Saturday' | gawk '/Sat(urday)?/{print \$0}'$colorOff        # Out: "
    echo "Saturday" | gawk '/Sat(urday)?/{print $0}'
}
#
#
regex_action(){
    clear
    echo -en "$Bold[+] Regular Expressions in Action$colorOff"
}
#
menu(){
    clear
    echo -e "${Bold}[+] Regular Expressions:$colorOff

    1. Introductions.
    2. The dot (.) character.
    3. Character classes .
    4. Range of charecters.
    5. The asterisk (*).
    6. The plus (+) sign
    7. Using braces.
    8. The pip (|) symbol.
    9. Grouping expressions.
    0. Exit"

    echo
    echo -en "$BYellow[:] Choose From the Menu: $colorOff"; read -rn 1 Choice
}
#
while true; do
    clear
    menu
    case $Choice in
        1)  regex_type; pause ;;
        2)  dot; pause ;;
        3)  character_classes; pause ;;
        4)  character_ranges; pause ;;
        5)  asterisk; pause ;;
        6)  plus_sign; pause ;;
        7)  braces; pause ;;
        8)  pip_symbol; pause ;;
        9)  grouping_expressions; pause ;;
        0)  echo -e "\nBye"; exit 0 ;;
        *)  echo -e "\n[-] $Red Wrong Choice $colorOff"; pause ;;
    esac
done
