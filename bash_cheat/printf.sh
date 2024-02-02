#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error

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
format_specifiers(){
    clear
    echo -e "$Bold[+] printf format specifiers$colorOff

| specifier | description
|-----------|------------------------
| %c        | ASCII character (prints first character of corresponding argument)
| %d        | Decimal integer
| %i        | Same as %d
| %e        | Floating-point format([-]d.precision[+-]dd)
| %E        | Floating-point format([-]d.precisionE[+-]dd)
| %f        | Floating-point format([-]ddd.precision)
| %g        | %e or %f conversion, whichever is shorter, with trailing zeros removed
| %G        | %E or %f conversion, whichever is shorter, with trailing zeros removed
| %o        | Unsigned octal value
| %s        | String
| %u        | Unsigned hexadecimal.
| %x        | Unsigned hexadecimal number,uses a-f for 10 to 15
| %X        | Unsigned hexadecimal number,uses A-F for 10 to 15
| %%        | Literal %

# The  width  of  the  output  field  is  a  numeric  value.
# When you specify a field width, the contents of the field are right-justified by default.
# You must specify a flag of '-' to get left-justific ation.
# Thus, '%-20s' outputs a left-justifiedstring in a field 20 characters wide.
# If the string is lessthan 20 characters, the field is padded with whitespace tofill."
}
#
examples(){
    clear
    echo -e "$Bold[+] printf Examples$colorOff"

    echo -e "$Green$ printf '|%10s|\\\n' hello$colorOff"; printf '|%10s|\n' hello

    echo -e "$Green$ printf '|%-10s|\\\n' hello$colorOff"; printf '|%-10s|\n' hello

    echo -e "$Green$ printf \"%#x\\\n\" 380$colorOff"; printf "%#x\n" 380

    echo -e "$Green$ printf \"%05d\\\n\" 380$colorOff"; printf "%05d\n" 380
    echo -e "$Green$ printf \"%05.5f\\\n\" 380$colorOff"; printf "%05.5f\n" 380
    echo -e "$Green$ printf \"%010.5f\\\n\" 380$colorOff"; printf "%010.5f\n" 380
    echo -e "$Green$ printf \"%+d\\\n\" 380$colorOff"; printf "%+d\n" 380
    echo -e "$Green$ printf \"%-d\\\n\" 380$colorOff"; printf "%-d\n" 380
    echo -e "$Green$ printf \"%5s\\\n\" abcdefghijk$colorOff"; printf "%5s\n" abcdefghijk
    echo -e "$Green$ printf \"%.5s\\\n\" abcdefghijk$colorOff"; printf "%.5s\n" abcdefghijk
	echo -e "$Green$ printf \"%d, %f, %o, %s, %x, %X\\\n\" 380 380 380 380 380 380$colorOff"
    printf "%d, %f, %o, %s, %x, %X\n" 380 380 380 380 380 380
}
conversion_specifiers(){
    clear
echo -e "$Bold[+] printf Conversion Specification Components:$colorOff

  Component	| Description
------------|----------------------------------------------------------------------------------
#           | Use the 'alternate format' for output. This varies by data type.
            | For o (octal number) conversion, the output is prefixed with 0.
            | For x and X (hexadecimal number) conversions, the output is prefixed with 0x or 0X respectively.
0 (zero)    | Pad the output with zeros. This means that the field will be filled with leading zeros, as in '000380'.
- (dash)    | Left-align the output. By default, printf right-aligns output.
(space)     | Produce a leading space for positive numbers.
+(plus sign)| Sign positive numbers. By default, printf only signs negative numbers.
width       | A number specifying the minimum field width.
.precision 	| For floating point numbers, specify the number of digits of precision to be output after the decimal point.
            | For string conversion, precision specifies the number of characters to output."
}
#
menu(){
    clear
    echo -e "${Bold}[+] printf cheat sheet :$colorOff

    1. printf Format Specifiers
    2. printf Conversion Specification Components
    3. printf Examples.
    0. Exit"
    echo
    echo -en "$BYellow[:] Choose From the Menu: $colorOff"; read -rn 1 Choice
}
#
while true; do
    clear
    menu
    case $Choice in
        1)  format_specifiers; pause ;;
        2) conversion_specifiers; pause ;;
        3)  examples; pause ;;
        0)  echo -e "\nBye"; exit 0 ;;
        *)  echo -e "\n[-] $Red Wrong Choice $colorOff"; pause ;;
    esac
done
