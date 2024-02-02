#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# Sourcing cliColor from the lib directory
if [ -f "/home/dabve/bin/lib/cliColor" ]; then
    source "/home/dabve/bin/lib/cliColor"
fi
#
# Pause function
if [ -s "/home/dabve/bin/lib/functions_lib" ];then
    source "/home/dabve/bin/lib/functions_lib"
fi
#
clear
echo -e "$Bold[+] ss options$colorOff

    -n --numeric            | don't resolve service names
    -r --resolve            | resolve  host names
    -a, --all               | display all sockets
    -l, --listening         | display listening sockets
    -o, --options           | show timer information
    -e, --extended          | show detailed socket information
    -m, --memory            | show socket memory usage
    -p, --processes         | show process using socket
    -i, --info              | show internal TCP information
    -s, --summary           | show socket usage summary
    -4, --ipv4              | display only IP version 4 sockets
    -6, --ipv6              | display only IP version 6 sockets
    -0, --packet            | display PACKET sockets
    -t, --tcp               | display only TCP sockets
    -u, --udp               | display only UDP sockets
    -d, --dccp              | display only DCCP sockets
    -w, --raw               | display only RAW sockets
    -x, --Unix              | display only Unix domain sockets
    -f, --family=FAMILY     | display sockets of type FAMILY
    -D, --diag=FILE         | Dump raw information about TCP sockets to FILE
    -F, --filter=FILE       | read filter information from FILE
        FILTER := [ state TCP-STATE ] [ EXPRESSION ]

    -A, --query=QUERY, --socket=QUERY
        QUERY := {all|inet|tcp|udp|raw|unix|packet|netlink}[,QUERY]"
#
pause
#
echo -e "$Bold[+] ss command line$colorOff

$Green$ ss -s$colorOff                                                      # currently established, closed, orphaned an waiting TCP sockets
$Green$ ss -l$colorOff                                                      # display all open network ports
$Green$ ss -lp$colorOff                                                     # show process using socket
$Green$ ss -lp | grep users$colorOff
$Green$ ss -t -a$colorOff                                                   # all TCP Socktes
$Green$ ss -u -a$colorOff                                                   # all UDP Sockets
$Green$ ss -w -a$colorOff                                                   # all Raw Socketes
$Green$ ss -x -a$colorOff                                                   # all UNIX Socketes
$Green$ ss -o state estalished$colorOff                                     # all established connections
$Green$ ss -o state estalished '(dport = :smtp or sport = :smtp)'$colorOff  # all established SMTP connections
$Green$ ss -o state estalished '(dport = :smtp or sport = :smtp)'$colorOff  # all established SMTP connections
"
#
pause
#
echo -e "$Bold[+] ss Advanced$colorOff
$Green$ ss -o state estalished '( dport = :smtp or sport = :smtp )'$colorOff  # all established SMTP connections
$Green$ ss -o state estalished '( dport = :http or sport = :http )'$colorOff  # all established SMTP connections

# List all TCP sockets in state FIN-WAIT-1 for our httpd to network 202.54.1/24 and look at thier timers
    $Green$ ss -o state fin-wait-1 '( sport = :http or sport = :https )' dst 202.54.1/24$colorOff

# Filter socktes using TCP States
$Green$ ss -4 state FILTER-NAME-HERE$colorOff       # You can use -6 for IPV6

# FILTER-NAME-HERE can be any one of the following
    established     syn-sent        syn-recv
    fin-wait-1      fin-wait-2      time-wait
    closed          close-wait      last-ack
    listen          closing         all:All of the above states
    connected       synchronized
    bucket  : Show states, which are maintained as minisockets, i.e. time-wait and syn-recv
    big     : Opposite to bucket state.
$Green$ ss -4 state closing$colorOff        # Closing sockets

$Green$ ss dst 192.168.1.5$colorOff         # Show all ports connected from remote 192.168.1.5
$Green$ ss dst 192.168.1.5:http$colorOff    # With port
$Green$ ss -tlp$colorOff                    # all listing tcp sockets including the corresponding process

$Green$ ss -t dst 192.168.2.1:80$colorOff   # show all sockets connecting to 192.168.2.1 on port 80

$Green$ ss -t state established '( dport = :ssh or sport = :ssh )'$colorOff # show all ssh related connection
"
