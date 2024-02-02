#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
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
echo -e "
    $Bold[+] Trans: translate-shell cheat sheet$colorOff

$Green$ trans vorto$colorOff                                        # Google translate can identify the language of the source text.
$Green$ trans -L ar$colorOff                                        # Print details of languages
$Green$ trans -T$colorOff                                           # Print reference table of languages
$Green$ trans -S$colorOff                                           # List available translation engines
$Green$ trans -shell -brief en:fr$colorOff                          # Interactive shell

$Green$ trans :fr word$colorOff                                     # Translate a word into french
$Green$ trans :fr+ar word$colorOff                                  # Translate a word into french and arabic languages
$Green$ trans -t fr+ar word$colorOff                                # -t == -target
$Green$ trans fr:ar word$colorOff                                   # From french to arabic
$Green$ trans en:ar \"Multiple words\"$colorOff                       # Translate as a whole word
$Green$ trans en:ar Multiple words$colorOff                         # Translate each word alone
$Green$ trans -b :fr \"Saluton, Mondo\"$colorOff                      # -b == -brief
$Green$ trans -b -p :fr \"Saluton, Mondo\"$colorOff                   # -p == -play: Listen to the translation
$Green$ trans -id salut$colorOff                                    # -id == identify: To identify the language of the text

$Green$ trans -b -i input.txt :fr$colorOff                          # -i == -input
$Green$ echo 'Hello, World' | trans -b -o ouput.txt :fr$colorOff
$Green$ trans :fr file://input.txt$colorOff                         # translate a file
$Green$ trans :fr http://www.w3.org$colorOff                        # Translate a web page
$Green$ trans -browser firefox :fr http://www.w3.org$colorOff       # Open in browser
"

