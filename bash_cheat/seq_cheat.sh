#!/bin/bash

echo '
$ seq 4             # from 1 to 4

$ seq 1 4           # start and end value

$ seq 1 2 10        # from 1 to 10 increment by 2
$ seq 10 -2 1       # from 10 to 1 decrement by 2

$ seq -w 01 10      # adding leading 0
$ seq -w 001 10     # adding leading 0

$ seq -s - 8        # adding separator

$ for i in $(seq 10);do
> echo $i
> done

$
'
