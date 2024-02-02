#!/bin/bash
# Test using at command
#
echo "This script ran at $(date +%B%d,%T)" >tstAtCmd2.out
echo >>tstAtCmd2.out
sleep 5
echo "This is the script's end..." >>tstAtCmd2.out
