#!/bin/bash
#: Title        : handlingSignal.sh
#: Date	        : 06-Mar-2016
#: Author       : Dabve
#: Descreption  : This script show how to handle signal in bash script
#: Option       : none
#
#
# Sourcing cliColor from the lib directory
if [ -f /home/dabve/bin/lib/cliColor ]; then
    source /home/dabve/bin/lib/cliColor
fi
#
# Pause function
if [ -s /home/dabve/bin/lib/pause ];then
    source /home/dabve/bin/lib/pause
fi
path="/home/dabve/programming/bash/cheat_sheet/sControl"
#
handlingSignal(){
	clear
echo -e "$Bold[+] Handling Signal$colorOff
# Linux uses signals to communicate with processes, he uses these signals to stop, start, and kill processes.
# You can control the operation of your shell script by programming the script to perform certain commands when it receives specific signals.
# The trap command allows you to specify which Linux signals your shell script can watch for and intercept from the shell.
# If the script receives a signal listed in the trap command, it prevents it from being processed by the shell and instead handles it locally:
    $Green$ trap commands signals$colorOff
$Bold[+] Example for trapping CTRL+C(SIGINT):$colorOff"
echo -e "$Green"
cat "$path/trappingCtrlc.sh"
echo -ne "$colorOff"
#
pause
#
echo -e "$Bold[+] Example for trapping a script exit:$colorOff"
echo -e "$Green"
cat "$path/trappingExit.sh"
echo -ne "$colorOff"
#
pause
#
echo -e "
$Bold[+] Modifying a set trap:$colorOff

# To handle traps differently in various sections of your shell script, you simply reissue the trap command with new options:"
echo -e "$Green"
cat "$path/modifyingTrap.sh"
echo -ne "$colorOff"
#
pause
#
echo -e "$Bold[+] Removing trap:$colorOff"
echo -e "# You can also remove a set trap. Simply add two dashes after the trap command and a list of the signals you want to return to default behavior"
echo -en "$Green"
cat "$path/removingTrap.sh"
echo -en "$colorOff"
}
#
#
niceCommand(){
	clear
echo -e "$Bold[+] Being nice$colorOff
# To change the priority of a shell script, either lowering its priority or giving it a higher priority.
# You can do this by using the nice command.

# The scheduling priority is an integer value, from -20 (the highest priority) to +19 (the lowest priority).
# By default, the bash shell starts all processes with a scheduling priority of 0. Just remember the phrase, 'Nice guys finish last.'

# The nice command allows you to set the scheduling priority of a command as you start it.
# To make a command run with less priority, just use the -n command line option for nice to specify a new priority level:
    $Green$ nice -n 10 ./test.sh &$colorOff

# Sometimes, you'd like to change the priority of a command that's already running on the system.
# That's what the renice command is for. It allows you to specify the PID of a running process to change its priority:

$Bold[+] Example:$colorOff

    $Green$ ./test.sh &
    renice -n 10 -p 5055$colorOff       # -p : PID

# renice: automatically updates the scheduling priority of the running process. As with the nice command, the renice command has some limitations:
	• You can only renice processes that you own.
	• You can only renice your processes to a lower priority.
	• The root user can renice any process to any priority."
}
#
#
runningLikeClockwork(){
	clear
echo -e "\t$Bold[+] Running Like Clockwork$colorOff
$Bold[+] Scheduling a job using the at command:$colorOff
# The at command allows you to specify a time when the Linux system will run a script.
# The at command submits a job to a queue with directions on when the shell should run the job. The at daemon, atd, runs in the background and checks the job queue for jobs to run.
# Most Linux distributions start this daemon automatically at boot time.
# The ${Bold}atd$colorOff daemon checks a special directory on the system (usually /var/spool/at) for jobs submitted using the at command.
# By default, the ${Bold}atd$colorOff daemon checks this directory every 60 seconds.
# When a job is present, the atd daemon checks the time the job is set to be run. If the time matches the current time, the atd daemon runs the job.

# The basic at command format is pretty simple:

    $Green$ at -f filename time$colorOff

# The at command recognizes lots of different time formats:
	• A standard hour and minute, such as 10:15
	• An AM/PM indicator, such as 10:15PM
	• A specific named time, such as now, noon, midnight, or teatime (4PM)
	• A standard date format, such as MMDDYY, MM/DD/YY, or DD.MM.YY
	• A text date, such as Jul 4 or Dec 25, with or without the year
	• A time increment:
	• Now + 25 minutes
	• 10:15PM tomorrow
	• 10:15 + 7 days"
#
pause
#
echo -e "$Bold[+] Retrieving job output$colorOff
# When the job runs on the Linux system, there's no monitor associated with the job.
# The Linux system uses the e-mail address of the user who submitted the job as STDOUT and STDERR. Any output destined to STDOUT or STDERR is mailed to the user via the mail system.
$Bold[+] Example:$colorOff"
echo
cat "$path/tstAtCmd.sh"
echo -e "$Green$ at -f tstAtCmd.sh now$colorOff"
echo
at -f "$path/tstAtCmd.sh" now
echo
echo -e "# The at command sends e-mail via the sendmail application.
# If your system does not use sendmail, you won't get any output! Therefore, it's best to redirect STDOUT and STDERR in your scripts when using at"
#
pause
#
echo -e "$Bold[+] Example:$colorOff
"
cat "$path/tstAtCmd2.sh"
echo -e "\t$Greenat -M -f tstAtCmd.sh now$colorOff  # -M : to suppress any output generated by jobs using the at command."
at -M -f "$path/tstAtCmd2.sh" now
echo -e "

# The atq command allows you to view what jobs are pending on the system:
    $Green$ atq$colorOff
# use the atrm command to remove a pending job:
    $Green$ atrm jobnumber$colorOff"
echo -e "$Bold[+] Scheduling a job using the crontab:$colorOff
# The Linux system uses the cron program to allow you to schedule jobs that need to run on a regular basis.
# If you need that script to run at the same time every day or once a week or once a month use the cron.
# The format for the cron table is: min hour dayofmonth month dayofweek command"
}
#
###############
menu(){
	clear
	echo -e "
$Bold[+] Welcome to Script Controle:$colorOff

	1. Handling Signal
	2. Nice Command
	3. Running Like Clockwork
	0. Exit"
	echo -en "\n\n$Bold[:] Choose frome the menu:$colorOff "
	read -rn 1 answer
}
#
while true;do
    clear
	menu
	case $answer in
		1)  handlingSignal;;
		2)  niceCommand;;
		3)  runningLikeClockwork;;
		0)  echo -e "\nBye"; break;;
		*)  echo -e "\n$Red[-] Sorry, wrong choice$colorOff";;
	esac
    pause
done
