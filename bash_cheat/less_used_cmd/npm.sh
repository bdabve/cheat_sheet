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
# Sourcing cliColor from the lib directory
if [ -f /home/dabve/bin/lib/cliColor ]; then
    source /home/dabve/bin/lib/cliColor
fi
#
clear
echo -e "
    $Bold$Underline[+] npm$colorOff

[+] Every command shown here can be used with the $Green-g$colorOff switch for global scope

    $Green$ npm install <package>$colorOff                  # Install a package in the current directory

    $Green$ npm install --save <package>$colorOff           # Install a package, and save it in the 'dependencies' section of 'package.json'

    $Green$ npm install --save-dev <package>$colorOff       # Install a package, and save it in the 'devDependencies' section of 'package.json'

    $Green$ npm root -g$colorOff                            # Root folder for global installation

    $Green$ npm outdated$colorOff                           # Show outdated packages in the current directory

    $Green$ npm update$colorOff                             # Update outdated packages

    $Green$ npm install -g npm$colorOff                     # Update 'npm' (will override the one shipped with Node.js)

    $Green$ npm uninstall <package>$colorOff                # Uninstall a package
"
