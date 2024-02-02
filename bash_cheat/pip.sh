#!/bin/bash -
#===============================================================================
#
#          FILE: pipUse.sh
#         USAGE: ./pipUse.sh
#   DESCRIPTION: How to use pip
#        AUTHOR: Dabve (Admin), dabve@outlook.fr
#  ORGANIZATION: Local Host
#       CREATED: 13/09/17 17:37:27
#===============================================================================
#
if [ -f "/home/dabve/bin/lib/cliColor" ]; then
    . "/home/dabve/bin/lib/cliColor"
fi
#
clear
echo -e "
    $Bold[+] pip cheat sheet:$colorOff

$Green$ pip search SomePackage$colorOff                                         # Search for packages
$Green$ pip install SomePackage$colorOff                                    # Install some packages
$Green$ pip install --user SomePackage$colorOff                             # Install some package in user space
$Green$ pip install --upgrade SomePackage$colorOff                          # Upgrade some package
$Green$ pip install -I SomePackage1==1.1.0 'SomePackage2>=1.0.4'$colorOff   # Install specific version of a package

# Output and install packages in a requirement file
$Green$ pip freeze > requirements.txt$colorOff
$Green$ pip install -r requirements.txt$colorOff
$Green$ pip show SomePackage$colorOff                           # Show details of a package
$Green$ pip list --format=columns$colorOff
$Green$ pip list --outdated$colorOff                        # List outdated packages
$Green$ pip help$colorOff                                   # Display help
$Green$ pip help install$colorOff                           # Display help of install
$Green$ pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U$colorOff # Upgrade all outdated packages.
$Green$ pip list --outdated --format=freeze | cut -d = -f 1 | xargs -n1 pip install -U$colorOff # Upgrade outdated packages on latest version of pip
"
