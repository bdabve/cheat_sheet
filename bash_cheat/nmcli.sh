#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# Sourcing cliColor from the lib directory
if [ -f /home/dabve/bin/lib/cliColor ]; then
    source /home/dabve/bin/lib/cliColor
fi
#
# Pause function
if [ -s /home/dabve/bin/lib/functions_lib ];then
    source /home/dabve/bin/lib/functions_lib
fi
#
clear
echo -e "$Bold[+] The NetworkManager command line:$colorOff

# Connect to a wireless access point - Parameters:
    # <wiface>    : wireless interface name
    # <ssid>      : SSID of the access point
    # <pass>      : WiFi password
$Green$ nmcli dev wifi connect <ssid> password <pass> iface <wiface>$colorOff
$Green$ nmcli dev wifi disconnect iface <wiface>$colorOff     # Disconnect from WiFi.
$Green$ nmcli d disconnect wlp2s0$colorOff

$Green$ nmcli -p$colorOff                         # Readable outputs for humans
$Green$ nmcli radio wifi$colorOff                 # WiFi status (enabled / disabled)
$Green$ nmcli radio wifi <on|off>$colorOff        # Enable / Disable WiFi
$Green$ nmcli dev wifi list$colorOff              # All available WiFi access points
$Green$ nmcli dev wifi rescan$colorOff            # Refresh WiFi connection list
$Green$ nmcli dev status$colorOff                 # Review available devices
$Green$ nmcli con$colorOff                        # Show all available connections
$Green$ nmcli con show --active$colorOff          # Show only active connections
$Green$ nmcli con up <name>$colorOff              # Bring up the ethernet connection

# Add a dynamic ethernet connection - parameters:
#	<name>          : name of connection
#	<iface_name>    : name of interface
$Green$ nmcli con add type ethernet con-name <name> ifname <iface_name>$colorOff

$Green$ nmcli con import type openvpn file <path_to_ovpn_file>$colorOff        # Import OpenVPN connection settings from file
"
