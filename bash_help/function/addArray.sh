#!/bin/bash
# Adding value in an array

addArray(){
	local sum=0
	local newArray
	newArray=($(echo "$@"))
	for value in ${newArray[*]};do
        sum=$(( sum + value ))
	done
	echo $sum
}
mayArray=(1 6 4 8 5)
echo "The original array is: ${mayArray[*]}"
result=$(addArray ${mayArray[*]})
echo "The result is: $result"
echo "......Done......"
