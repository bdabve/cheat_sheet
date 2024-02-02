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
echo -e "\t$Bold[+] SORT Command:$colorOff

$Green$ sort -r file$colorOff                           # Trier on ordre inverse
$Green$ sort -R file$colorOff                           # Trie aleatoirement
$Green$ sort -o file file-out$colorOff                  # Ecrire le resultat dans un fichier
$Green$ sort -n file$colorOff                           # Trier des nombre

$Green$ ls -l /home/dabve | sort -nr -k 5$colorOff      # Use SORT to sort ls -l by file size with the -k option
$Green$ sort -k 1,1 -k 2n file$colorOff

# Example to sort the 3rd fields
$Green$ sort -k 3.7nbr -k 3.1nbr -k 3.4nbr file$colorOff
$Green$ sort -k 3.7nbr -k 3.1nbr -k 3.4nbr file$colorOff"
