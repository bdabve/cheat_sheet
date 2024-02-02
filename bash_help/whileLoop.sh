#!/bin/bash -
#===============================================================================
#
#          FILE: whileLoop.sh
#
#         USAGE: ./whileLoop.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: daBve (), dabve@outlook.fr
#  ORGANIZATION:
#       CREATED: 05/02/2017 19:30
#      REVISION:  ---
#===============================================================================


while [ "$myfruit" != "quit" ]; do
    for fruit in apples bananas pears $myfruit; do
        echo "I like $fruit"
    done
    read -rp "What is your favorite fruit? " myfruit
done
echo "Okay, bye!"
