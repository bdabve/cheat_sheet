#!/bin/bash
#: Description	: print formated sales report

## Build a long string of equals signs
divider=============================================
divider=$divider$divider

## Format string for printf
header="\n %-10s %11s %8s %10s\n"
format=" %-10s %11.2f %8d %10.2f\n"

## Width of divider
totalwidth=44

## Print categories
printf "%s" "$header" ITEM "PER UNIT" NUM TOTAL

## Print divider to match width of report
printf "%$totalwidth.${totalwidth}s\n" "$divider"

## Print line of report
printf "%s" "$format" \
   Chair 79.95 4 319.8 \
  Table 209.99 1 209.99 \
  Armchair 315.49 2 630.93


# The formatting string %-10s means a left-aligned string, at least 10 characters wide.

printf "%-20s %-40s %-10s\n" "Username" "Name" "Shell"
echo
cut -d: -f 1,5,7 /etc/passwd | while IFS=: read -r uname name shell
do
    printf "%-20s %-40s %-10s\n" "$uname" "$name" "$shell"
done
#
#
echo
for i in $(seq 1 10); do
    echo "$i squared is $(expr $i \* $i)"
done
echo
#
#
for i in $(seq 1 10); do
    printf "%2d squared is %3d\n" "$i" "$(expr $i \* $i)"
done
echo
#
#
for i in $(seq 1 10); do
    printf "The square root of %2d is %0.4f\n" "$i" "$(echo "scale=10;sqrt($i)" | bc)"
done
