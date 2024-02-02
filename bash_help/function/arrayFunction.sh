#!/bin/bash
# Array variable to function

arrayVariable(){
	local newArray
	newArray=$(echo "$@")
	echo "The new array value is: ${newArray[*]}"
}
mayArray=(1 2 3 4 5)
echo "The original array is ${mayArray[*]}"
arrayVariable ${mayArray[*]}
