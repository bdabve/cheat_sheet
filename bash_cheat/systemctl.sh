#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 02/17/2019 02:37:31 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#
# Sourcing cliColor from the lib directory
if [ -f /home/dabve/bin/lib/cliColor ]; then
    source /home/dabve/bin/lib/cliColor
fi
#
clear
echo -e "
$Green$ systemctl list-units$colorOff                               # List all loaded/active units
$Green$ systemctl list-units -all --state=inactive$colorOff         # List all inactive units
$Green$ systemctl list-units -all --type=service$colorOff           # Display units of the type (service mean acitve units)

$Green$ systemctl status foo.service$colorOff       # Check the status of a service
$Green$ systemctl is-active foo.service$colorOff    # To Check a unit is currently active(running)

$Green$ systemctl start foo.service$colorOff        # Start a service
$Green$ systemctl restart foo.service$colorOff      # Restart a service
$Green$ systemctl stop foo.service$colorOff         # Stop a service

$Green$ systemctl reload foo.service$colorOff               # Reload a service's configuration
$Green$ systemctl reload-or-restart foo.service$colorOff    # Reload its configuration, otherwise restart the service

$Green$ systemctl enable foo.service$colorOff       # Enable a service to startup on boot
$Green$ systemctl disable foo.service$colorOff      # Disable a service to startup on boot
$Green$ systemctl is-enable foo.service$colorOff    # If the units is Enable
$Green$ systemctl is-failed foo.service$colorOff    # If the units is in a failed status

$Green$ systemctl list-units --type=target$colorOff # List currently loaded targets
$Green$ systemctl isolate foo.target$colorOff       # Change current target
$Green$ systemctl enable foo.target$colorOff        # Change default target

# List the dependencies of a service
# when no service name is specified, lists the dependencies of default.target
$Green$ systemctl list-dependencies foo.service
"
