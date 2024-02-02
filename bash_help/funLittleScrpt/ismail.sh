#!/bin/bash
#: Title 	: ismail.sh
#: Date		: 16-Feb-2016
#: Author	: Dabve
#: Descreption	: this script filters out poorly formated e-mail
#: Option	: none

gawk --re-interval '/^([a-zA-Z0-9_\-\.\+]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/{print $0}'
