#!/bin/bash
#
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
# Pause function
clear
echo -e "$Bold[+] The syntax of pv command$colorOff

    $Green$ pv file$colorOff
    $Green$ pv options file$colorOff
    $Green$ pv file > filename.out$colorOff
    $Green$ pv options | command > filename.out$colorOff
    $Green$ comand1 | pv | command2$colorOff

# The options used with pv are divided into three categories, display switches, output modifiers and general options.

# Some options under display modifiers.

    1. To turn on the display bar, use the $Green-p$colorOff option.
    2. To view the elapsed time, use the $Green--timer$colorOff option.
    3. To turn on ETA timer which tries to guess how long it will take before completion of an operation, use the $Green--eta$colorOff option. The guess
       is based on previous transfer rates and the total data size.
    4. To turn on a rate counter use the $Green--rate$colorOff option.
    5. To display the total amount of data transferred so far, use the $Green--bytes$colorOff option.
    6. To display progress inform of integer percentage instead of visual indication, use the $Green-n$colorOff option. This can be good when using pv with
       the dialog command to show progress in a dialog box.

# Some options under output modifiers.

    1. To wait until the first byte is transferred before displaying progress information, use the –wait option.
    2. To assume the total amount of data to be transferred is SIZE bytes when computing percentage and ETA, use –size SIZE option.
    3. To specify seconds between updates, use the –interval SECONDS option.
    4. Use –force option to force an operation. This option forces pv to display visuals when standard error is not a terminal.
    5. The general options are –help to display usage information and –version to display version information."

#
pause

echo -e "

# When no option is included, pv commands run with default -p, -t, -e, -r and -b options.

$Bold[+] Example:$colorOff
# To copy the opensuse.vdi file to /tmp/opensuse.vdi, run this command and watch the progress bar in screencast.
	$Green$ pv opensuse.vdi > /tmp/opensuse.vdi$colorOff

# To make a zip file from your /var/log/syslog file.
	$Green$ pv /var/log/syslog | zip > syslog.zip$colorOff

# To count the number of lines, word and bytes in the /etc/hosts file while showing progress bar only.
	$Green$ pv -p /etc/hosts | wc$colorOff

# Monitor the progress of creating a backup file using tar utility.
	$Green$ tar -czf - ./Downloads/ | (pv -p --timer --rate --bytes > backup.tgz)$colorOff

# Using pv and dialog terminal-based tool together to create a dialog progress bar as follows.
	$Green$ tar -czf - ./Documents/ | (pv -n > backup.tgz) 2>&1 | dialog --gauge \"Progress \" 10 70$colorOff"

