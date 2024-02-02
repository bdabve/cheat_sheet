#!/bin/bash
#: Title 	: isphone
#: Date		: 16-Feb-2016
#: Author	: Dabve
#: Descreption	: script to filter out bad phone number for algeria
#: Option	: none

gawk --re-interval '/^[0-9]{4}( |-|\/)[0-9]{3}( |-|\/)[0-9]{3}$/{print $0}'
