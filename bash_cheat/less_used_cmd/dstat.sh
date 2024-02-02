#!/bin/bash -
#=============================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 03/03/2019 11:00:56 AM
#      REVISION:  ---
#=============================================

set -o nounset     # unset variables as an error
#
if [ -s "/home/dabve/bin/lib/cliColor" ]; then
    source "/home/dabve/bin/lib/cliColor"
fi
#
clear
echo -e "$Bold[+] dstat usage$colorOff

# dstat: a resourceful tool to monitor Linux Server Performance in Real-Time

$Green$ dstat$colorOff                                          # similar to using -cdngy
$Green$ dstat --list$colorOff                                   # list all available plugins.
$Green$ dstat --vmstat$colorOff                                 # display more informations
$Green$ dstat -taf$colorOff                                     # simple system check

$Green$ dstat --top-cpu-adv --top-latency --top-mem$colorOff    # top cpu, top latency and top memory
$Green$ dstat -c --top-cpu -dn --top-mem$colorOff               # monitor a single program that is using the most CPU and most amount of memory

# displaying the time, cpu, mem, system load stats with a one second delay between 5 updates count
$Green$ dstat --time --cpu --mem --load --output report.csv 1 5$colorOff

# how is my laptop/battery/wifi doing
$Green$ dstat -t -M cpufreq,power,thermal,battery,wifi$colorOff "
