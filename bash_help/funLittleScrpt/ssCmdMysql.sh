#!/bin/bash
#: Title 	: sendingSingleCmd
#: Date		: 04-Feb-2016
#: Author	: Dabve
#: Version	:
#: Descreption	: sending single command from bash script to mysql
#: Option	: none

# In this script we use the employees database with the test user
MYSQL=$(which mysql)
$MYSQL myTest -u test -e 'select * from employees'


