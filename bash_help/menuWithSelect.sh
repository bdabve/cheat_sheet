#!/bin/bash - 
#===============================================================================
#
#          FILE: menuWithSelect.sh
# 
#         USAGE: ./menuWithSelect.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: daBve (), dabve@outlook.fr
#  ORGANIZATION: 
#       CREATED: 04/30/2017 20:36
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

PS3="Select a day (1-4): "
select day in mon tue wed exit; do
    
    case $day in
        mon) echo "Monday"
            ;;

        tue) echo "Tuesday"
            ;;
        wed) echo "Wednesday"
            ;;
        exit) exit
            ;;

        *) echo "Sorry wrong answer"
            ;;

    esac    # --- end of case ---
done
