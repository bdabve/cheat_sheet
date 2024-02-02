# <center>Script Control</center>

## Handling Signal

* Linux uses signals to communicate with processes running on the system.
* Linux system uses these signals to stop, start, and kill processes. 
* You can control the operation of your shell script by programming the script to perform certain commands when it receives specific signals.
* The trap command allows you to specify which Linux signals your shell script can watch for and intercept from the shell. 
* If the script receives a signal listed in the trap command, it prevents it from being processed by the shell and instead handles it locally: 
 `trap commands signals`

* Example for trapping `CTRL+C (SIGINT)`:

  ```bash
  #!/bin/bash
  # Testing signal trapping
  #
  trap "echo ' Sorry! I have trapped Ctrl-C'" SIGINT
  #
  echo This is a test script
  #
  count=1
  while [ $count -le 10 ]
  do
    echo "Loop #$count"
    sleep 1
    count=$[ $count + 1 ]
  done
  #
  echo "This is the end of the test script"
  ```

* Example for trapping a script exit:

  ```bash
  #!/bin/bash
  # Trapping the script exit
  #
  trap "echo Goodbye..." EXIT
  #
  count=1
  while [ $count -le 5 ]
  do
    echo "Loop #$count"
    sleep 1
    count=$[ $count + 1 ]
  done
  ```

* To handle traps differently in various sections of your shell script, you simply reissue the `trap` command with new options:
* Example for modifying a set `trap`:

  ```bash
  #!/bin/bash
  # Modifying a set trap
  #
  trap "echo ' Sorry... Ctrl-C is trapped.'" SIGINT
  #
  count=1
  while [ $count -le 5 ]
  do
    echo "Loop #$count"
    sleep 1
    count=$[ $count + 1 ]
  done
  #
  trap "echo ' I modified the trap!'" SIGINT
  #
  count=1
  while [ $count -le 5 ]
  do
    echo "Second Loop #$count"
    sleep 1
    count=$[ $count + 1 ]
  done
  ```

* You can also remove a set `trap`. Simply add two dashes after the trap command and a list of the signals you want to return to default behavior 
* Example for removing `trap`:

  ```bash
  #!/bin/bash
  # Removing a set trap
  #
  trap "echo ' Sorry... Ctrl-C is trapped.'" SIGINT
  #
  count=1
  while [ $count -le 5 ]
  do
    echo "Loop #$count"
    sleep 1
    count=$[ $count + 1 ]
  done
  #
  # Remove the trap
  trap -- SIGINT
  echo "I just removed the trap"
  #
  count=1
  while [ $count -le 5 ]
  do
    echo "Second Loop #$count"
    sleep 1
    count=$[ $count + 1 ]
  done
  ```

## Running Scripts in Background Mode

* Running a shell script in background mode is a fairly easy thing to do. just place an ampersand symbol (&) after the command.
* Be aware that while the background process is running, it still uses your terminal monitor for `STDOUT` and `STDERR` messages.
* It is a good idea to redirect `STDOUT` and `STDERR` for scripts you will be running in the background to avoid this messy output.

* The `nohup` command runs another command blocking any `SIGHUP` signals that are sent to the process. 
* This prevents the process from exiting when you exit your terminal session. 
* The format used for the `nohup` command is as follows: `nohup ./test.sh &`
* The `nohup` command automatically redirects `STDOUT` and `STDERR` messages to a file, called `nohup.out`.
* If you run another command using nohup, the output is appended to the existing `nohup.out` file. 
* Be careful when running multiple commands from the same directory, because all the output is sent to the same `nohup.out`

## Controlling Jobs: 

* The key command for job control is the `jobs` command. 
* The `jobs` command allows you to view the current jobs being handled by the shell
* The jobs command parameters

| Parameter	|	Description
|-----------|-----------------------------------------------------
| -l		    | Lists the PID of the process along with the job number
| -n		    | Lists only jobs that have changed their status since the last notification from the shell
| -p 		    | Lists only the PIDs of the jobs
| -r		    | Lists only the running jobs
| -s		    | Lists only the stopped jobs

* The job with the plus sign is considered the default job. 
* It would be the job referenced by any job control commands if a job number wasn't specified in the command line.
* The job with the minus sign is the job that would become the default job when the current default job finishes processing. 
* There will be only one job with the plus `+` sign and one job with the minus `-` sign at any time, no matter how many jobs are running in the shell.

### Restarting the job

* To restart a job in background mode, use the `bg` command.
* To restart a job in foreground mode, use the `fg` command.
* If you have additional `jobs`, you need to use the job number along with the `bg` or `fg` command: `bg 2 || fg 2`

## Being nice

* Sometimes, you want to change the priority of a shell script, either lowering its priority so it doesn't take as much processing power away from other processes or giving it a higher priority so it gets more processing time. 
* You can do this by using the `nice` command.

* The scheduling priority is an integer value, from -20 (the highest priority) to +19 (the lowest priority). 
* By default, the bash shell starts all processes with a scheduling priority of 0. 
* Just remember the phrase, 'Nice guys finish last.'

* The `nice` command allows you to set the scheduling priority of a command as you start it. 
* To make a command run with less priority, just use the `-n` command line option for nice to specify a new priority level: `nice -n 10 ./test.sh &`

* Sometimes, you'd like to change the priority of a command that's already running on the system. 
* That's what the renice command is for. It allows you to specify the `PID` of a running process to change its priority:

  ```bash
  $ ./test.sh &
  $ renice -n 10 -p 5055    # -p == PID
  ```

* The `renice` command automatically updates the scheduling priority of the running process. 
* As with the `nice` command, the renice command has some limitations:
	* You can only `renice` processes that you own.
	* You can only `renice` your processes to a lower priority.
	* The root user can `renice` any process to any priority.
* If you want to fully control running processes, you must be logged in as the root account or use the sudo command.

## Running Like Clockwork

### Scheduling a job using the at command:

* The `at` command allows you to specify a time when the Linux system will run a script. 
* The `at` command submits a job to a queue with directions on when the shell should run the job. 
* The `at` daemon, `atd`, runs in the background and checks the job queue for jobs to run. 
* Most Linux distributions start this daemon automatically at boot time.
* The `atd` daemon checks a special directory on the system (usually `/var/spool/at`) for jobs submitted using the `at` command. 
* By default, the `atd` daemon checks this directory every 60 seconds. 
* When a job is present, the `atd` daemon checks the time the job is set to be run. 
* If the time matches the current time, the `atd` daemon runs the job.

* The basic `at` command format is pretty simple: `at -f filename time`

* The `at` command recognizes lots of different time formats:
	* A standard hour and minute, such as 10:15
	* An AM/PM indicator, such as 10:15PM
	* A specific named time, such as now, noon, midnight, or teatime (4PM)
	* A standard date format, such as MMDDYY, MM/DD/YY, or DD.MM.YY
	* A text date, such as Jul 4 or Dec 25, with or without the year
	* A time increment:  
	* Now + 25 minutes
	* 10:15PM tomorrow
	* 10:15 + 7 days
  
## Retrieving job output

* When the job runs on the Linux system, there's no monitor associated with the job.
* The Linux system uses the e-mail address of the user who submitted the job as `STDOUT` and `STDERR`. 
* Any output destined to `STDOUT` or `STDERR` is mailed to the user via the mail system.

  ```bash
  $ cat tstatcmd.sh
  #!/bin/bash
  # Test using at command

  echo "This script ran at $(date +%B%d,%T)"
  echo
  sleep 5
  echo "This is the script's end..."

  $ at -f tstAtCmd.sh now
  ```

* The `at` command displays the job number assigned to the job along with the time the job is scheduled to run.
* The `at` command sends e-mail via the `sendmail` application. 
* If your system does not use `sendmail`, you won't get any output! Therefore, it's best to redirect `STDOUT` and `STDERR` in your scripts when using the `at` command

  ```bash
  $ cat tstAtCmd2.sh

  #!/bin/bash
  # Test using at command

  echo "This script ran at $(date +%B%d,%T)" >tstAtCmd2.out
  echo >>tstAtCmd2.out
  sleep 5
  echo "This is the script's end..." >>tstAtCmd2.out

  $ at -M -f tstAtCmd2.sh now
  ```

* The `-M` option to suppress any output generated by jobs using the `at` command.
* The `atq` command allows you to view what jobs are pending on the system: `atq`
* use the `atrm` command to remove a pending job:`atrm jobnumber`

* The Linux system uses the `cron` program to allow you to schedule jobs that need to run on a regular basis.
* If you need that script to run at the same time every day or once a week or once a month use the `cron`.
* The format for the `cron` table is: `min hour dayofmonth month dayofweek command`
