#!/bin/bash
# testing $* and $@
#
if [ $# -lt "2" ];then
	echo -e "\n\tusage: $( basename "$0" | sed s,\.sh$,,) param1 param2\n"
	exit 1
fi
echo
count=1
#
for param in $*; do
	echo "\$* Parameter #$count = $param"
    count=$(( count + 1 ))
done
#
echo
count=1
#
for param in "$@"; do
	echo "\$@ Parameter #$count = $param"
    count=$(( count + 1 ))
done
