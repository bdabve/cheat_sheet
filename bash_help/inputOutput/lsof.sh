#!/bin/bash
#testing the lsof with file descriptors
exec 3>testLSOF1
exec 6>testLSOF2
exec 7<test2.sh
lsof -a -p $$ -d0,1,2,3,6,7
