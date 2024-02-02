#!/bin/bash
# demonstrating the local keyword
function func1 {
    local temp=$(( value + 5 ))
    result=$(( temp * 2 ))
    echo "The temp variable in function: $temp"
}
temp=4
value=6
func1
echo "The result is $result"
echo "The temp variable outside function: $temp
and value variable = $value"
if [ $temp -gt $value ]
then
	echo "temp is larger"
else
	echo "temp is smaller"
fi
