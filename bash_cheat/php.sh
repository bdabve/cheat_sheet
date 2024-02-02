#!/bin/bash -
#===============================================================================
#
#          FILE: googler.sh
#
#         USAGE: ./googler.sh
#
#   DESCRIPTION: googler examples
#
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#
# Sourcing cliColor from the lib directory
if [ -f /home/dabve/bin/lib/cliColor ]; then
    source /home/dabve/bin/lib/cliColor
fi
clear
echo -e "
    $Bold[+] php command line:$colorOff

$Green$ php -v $colorOff                                                  # To view the php version
$Green$ php -m $colorOff                                                  # To view the installed php modules
$Green$ php -i $colorOff                                                  # To view phpinfo() information
$Green$ php -l file.php $colorOff                                         # To lint a php file
$Green$ find . -name '*.php' -print0 | xargs -0 -n1 -P8 php -l $colorOff  # To lint all php files within the cwd
$Green$ php -a $colorOff                                                  # To enter an interactive shell
$Green$ php -i | grep 'php.ini' $colorOff                                 # To locate the system's php.ini files
$Green$ php -S localhost:3000 $colorOff                                   # To start a local webserver for the cwd on port 3000 (requires php >= 5.4)
"
