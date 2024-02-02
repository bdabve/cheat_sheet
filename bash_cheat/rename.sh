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
clear
echo -e "
$Bold[+] rename Command$colorOff

    $Green$ rename [-v -n -f] <pcre> <files>$colorOff
    # <pcre> is a Perl-compatible regular expression. This regular expression is in the form of 's/old-name/new-name/'.
        '-v' : shows the details of file name changes (e.g., XXX renamed as YYY).
        '-n' : show how the files would be renamed without actually changing the names.
        '-f' : force overwriting existing files.

    $Green$ rename *.JPG *.jpg$colorOff       # Renaming \*.JPG to \*.jpg

    $Green$ rename 's/ /_/g' *$colorOff       # Replace space in the filenames with the '\_' character:

# Convert any filename of files from upper to lower
    $Green$ rename 'y/A-Z/a-z/' *$colorOff
    $Green$ rename 'y/a-z/A-Z/' *$colorOff"
#
pause
#
echo -e "$Bold[+] Change File Name Patterns$colorOff

# More complex regular expressions which involve subpatterns.
# In PCRE, a subpattern captured within round brackets can be referenced by a number preceded by a dollar sign (e.g., \$1, \$2).

# The following command will rename 'img_NNNN.jpeg' to 'dan_NNNN.jpg'.
  $Green$ rename -v 's/img_(\d{4})\.jpeg$/dan_\$1\.jpg/' *.jpeg$colorOff

# The next command will rename 'img_000NNNN.jpeg' to 'dan_NNNN.jpg'.
  $Green$ rename -v 's/img_\d{3}(\d{4})\.jpeg$/dan_\$1\.jpg/' *jpeg$colorOff"
