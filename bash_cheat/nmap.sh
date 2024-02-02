#!/bin/bash -
#=================================================
#
#          FILE: nmapExample.sh
#   DESCRIPTION: Nmap Example from zenmap
#        AUTHOR: Dabve (Admin), dabve@outlook.fr
#       CREATED: 01/11/17 19:12:54
#=================================================

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

echo -e "$Bold[+] Nmap Examples

$Green$ nmap -sn -PS 192.168.1.0/24 $colorOff           # TCP SYN Ping

$Green$ nmap -sn -PA 192.168.1.0/24$colorOff            # TCP ACK Ping

$Green$ nmap -sn -PU 192.168.1.0/24$colorOff            # UDP Ping

$Green$ nmap -sn -PO 192.168.1.0/24$colorOff            # IP Protocol Ping

$Green$ nmap -sn -PR 192.168.1.0/24$colorOff            # ARP Ping

$Green$ nmap T4 -A -v 192.168.1.0/24$colorOff           # intence scan with nmap

$Green$ nmap [target]$colorOff                          # Single target scan

$Green$ nmap -iL [list.txt]$colorOff                    # Scan from a list of targets

$Green$ nmap -6 [target]$colorOff                       # iPv6

$Green$ nmap -O --osscan_guess [target]$colorOff        # OS detection

$Green$ nmap -oN [output.txt] [target]$colorOff         # Save output to text file

$Green$ nmap -oX [output.xml] [target]$colorOff         # Save output to xml file

$Green$ nmap -source-port [port] [target]$colorOff      # Scan a specific port

$Green$ nmap -A [target]$colorOff                       # Do an aggressive scan
"
#
pause
#
echo -e "
# Speedup your scan:
# -n            => disable ReverseDNS
# --min-rate=X  => min X packets / sec
    $Green$ nmap -T5 --min-parallelism=50 -n --min-rate=300 [target]$colorOff

    $Green$ nmap -traceroute [target]$colorOff             # Traceroute

# Ping scan only    : -sP
# Don't ping        : -PN <- Use full if a host don't reply to a ping.
# TCP SYN ping      : -PS
# TCP ACK ping      : -PA
# UDP ping          : -PU
# ARP ping          : -PR

    $Green$ nmap -sP 192.168.0.0/24$colorOff # Ping scan all machines on a class C network

# Force TCP scan: -sT
# Force UDP scan: -sU
"
#
pause
#
echo -e "
$Green$ nmap --script default,safe$colorOff         # Use some script

# Loads the script in the default category, the banner script, and all .nse files in the directory /home/user/customscripts.
    $Green$ nmap --script default,banner,/home/user/customscripts$colorOff

# Loads all scripts whose name starts with http-, such as http-auth and http-open-proxy.
    $Green$ nmap --script 'http-*'$colorOff

# Loads every script except for those in the intrusive category.
    $Green$ nmap --script \"not intrusive\"$colorOff

# Loads those scripts that are in both the default and safe categories.
    $Green$ nmap --script \"default and safe\"$colorOff

# Loads scripts in the default, safe, or intrusive categories, except for those whose names start with http-.
    $Green$ nmap --script \"(default or safe or intrusive) and not http-*\"$colorOff

# Scan for the heartbleed
# -pT:443 => Scan only port 443 with TCP (T:)
    $Green$ nmap -T5 --min-parallelism=50 -n --script \"ssl-heartbleed\" -pT:443 127.0.0.1$colorOff

# Show all informations (debug mode)
    $Green$ nmap -d ...$colorOff
"
