#!/bin/bash
# Trying to access script parameters inside a function

bdl(){
	echo $[ $1 * $2 ]
}
if [ $# -eq 2 ]
then
	value=$(bdl $1 $2)
	echo "The result is $value"
else
	echo "Usage: $(basename $0) a b"
fi
