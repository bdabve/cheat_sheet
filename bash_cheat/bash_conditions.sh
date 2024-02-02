#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/25/2019 08:02:45 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

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
clear
echo -e "$Bold[+] Working with the 'if else' Statement$colorOff

    $Green user='dabve'

    if grep \$test_user /etc/passwd; then
        echo \"The user \$test_user does not exist on this system\"
    elif ls -d /home/\$test_user; then
        echo \"The user \$test_user does not exist on this system.\"
        echo \"However, \$test_user has a directory\"
    else
        echo \"The user \$test_user does not exist on this system.\"
        echo \"And, \$test_user\ does not have a directory\"
    fi$colorOff
"
#
pause
#
echo -e "
[+] The bash shell provides an alternative way of testing a condition
# Numiric Comparison
    ${Green}value1=12
    value2=14
    if [ \$value1 -eq \$value2 ]; then
        echo 'The values are equal'
    else
        echo 'The values are different'
    fi$colorOff

# String Comparison
    ${Green}if [ \$user != 'dabve' ]; then
        echo 'This is not dabve'
    else
        echo 'Hello dabve';
    fi$colorOff

# Compound comparison
    ${Green} if [ -d \$HOME ] && [ -w \$HOME/testing ]; then
        echo 'The file exists and you can write to it'
    else
        echo 'I cannot write to the file'
    fi$colorOff"
#
pause
#
echo -e "

## Using double parentheses
* The double parentheses command allows you to incorporate advanced mathematical formulas in your comparisons.
* The test command allows for only simple arithmetic operations in the comparison.

$Bold[+] Using Double parenthesis$colorOff

* The double parentheses command provides more mathematical symbols, which programmers who have used other programming languages may be familiar with using. Here’s the format of the double parentheses command: $Green(( expresion ))$colorOff

    ${Green}val=10
    if (( \$val **2 > 90 ));then
        (( val2 = \$val1 ** 2 ))
        echo \"The square of \$val1 is \$val2\"
    fi$colorOff

$Bold[+] Using Double bracktes$colorOff

* The double bracket command provides advanced features for string comparisons.
* Here’s the double bracket command format: $Green[[ expression ]]$colorOff

    ${Green}if [[ \$USER == r* ]]; then
        echo \"Hello \$USER\"
    else
        echo 'Sorry, i do not know you'
    fi$colorOff
"
#
pause
#
echo -e "
$Bold[+] Considering the case Command$colorOff
    ${Green}case \$user in
        rich | barbara)
            echo \"Welcome, \$USER\"
            echo \"Please enjoy your visit\";;
        testing)
            echo \"Special testing account\";;
        jessica)
            echo \"Do not forget to log off when you're done\";;
        *) echo \"Sorry, you are no allowed here\";;
    esac$colorOff

$Bold[+] The select$colorOff

    ${Green}select name [in list]; do
        statements that can use \$name
    done$colorOff
"
