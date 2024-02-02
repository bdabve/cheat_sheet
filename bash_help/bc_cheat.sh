#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================
#
set -o nounset                              # Treat unset variables as an error
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
clear
echo -e "
## The Basic of bc:

# The bash calculator recognizes these:
    * Numbers (both integer and floating point).
    * Variables (both	simple variables and arrays).
    *	Comments (lines	starting with a	pound sign or the C language /*	\*/ pair)
    *	Expressions.
    *	Programming statements (such as if-then statements).
    *	Functions.
    *
# The floating-point is controlled by a built-in variable called scale.
# You must set this value to the desired number of decimal places you want in your answers:
"
#
pause
#
echo -e "$Bold[+] Example:$colorOff

  $Green$ var1=\$( echo\"scale=4; 3.44/5\" | bc )
  $ echo the answer is \$var1

  $ var1=100
  $ var2=45
  $ var3=\$(echo \"scale=3; \$var / \$var2\" | bc)
  $ echo \"The answer for this \$var3\"$colorOff

# This method works fine for short calculations, but sometimes you need to get more involved with your numbers.
"
#
pause
#
echo -e "
# There’s a solution to this problem. The bc command recognizes input redirection, allowing you to redirect a file to the bc command for processing
$Bold[+] Example:$colorOff

  $Green$ var1=10.46
  $ var2=43.67
  $ var3=33.2
  $ var4=71
  $ var5=$(bc << EOF
  scale=4
  a1=($var1 * $var2)
  b1=($var3 * $var4)
  a1 + b1
  EOF )
  $ echo \"The final answer for this mess is $var5\"$colorOff "
