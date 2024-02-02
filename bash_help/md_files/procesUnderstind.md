#!/bin/bash -
#===============================================================================
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 03/02/2019 08:03:30 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#
#
ps_output(){
  clear
  echo -e "$Bold[+] PS Output:$colorOff

| Output  | Meaning
|---------|-----------------------------------------------------------
| UID	    | The user responsible for launching the process
| PID	    | The process ID of the process
| PPID    | The PID of the parent process (if a process is started by another process)
| C       | Processor utilization over the lifetime of the process
| STIME   | The system time when the process started
| TTY     | The terminal device from which the process was launched
| TIME    | The cumulative CPU time required to run the process
| CMD     | The name of the program that was started"
    "
}
#
#
ps_examples(){
    clear
    echo -e "$Bold[+] PS Examples$colorOff
    "
}

* When we use the `ps -f`:

* F       : System flags assigned to the process by the kernel
* S       : The state of the process 
    * O : running on processor; 
    * S : sleeping; 
    * R : runnable, waiting to run; 
    * Z : zombie, process terminated but parent not available; 
    * T : process stopped
* PRI     : The priority of the process (higher numbers mean lower priority)
* NI      : The nice value, which is used for determining priorities
* ADDR    : The memory address of the process
* SZ      : Approximate amount of swap space required if the process was swapped out
* WCHAN   : Address of the kernel function where the process is sleeping

## TOP Output:
    
* PID     : The process ID.
* USER    : The user name of the owner of the process
* PR      : The priority of the process
* NI      : The nice value of the process
* VIRT    : The total amount of virtual memory used by the process
* RES     : The amount of physical memory the process is using
* SHR     : The amount of memory the process is sharing with other processes
* S       : The process status 
    * D = interruptible sleep, 
    * R = running, 
    * S = sleeping, 
    * T = traced orstopped, or 
    * Z = zombie
* %CPU    : The share of CPU time that the process is using
* %MEM    : The share of available physical memory the process is using
* TIME+   : The total CPU time the process has used since starting
* COMMAND : The command line name of the process (program started"

## Linux Process Signal

* In Linux, processes communicate with each other using signals. 
* A process signal is a predefined message that processes recognize and may choose to ignore or act on. 
* The developers program how a process handles signals. 
* Most well-written applications have the ability to receive and act on the standard Unix process signals.

| Signal  | Name      | Description
|---------|-----------|--------------------------
| 1       | HUP       | Hangs up
| 2       | INT       | Interrupts
| 3       | QUIT      | Stops running
| 9       | KILL      | Unconditionally terminates
| 11      | SEGV      | Produces segment violation
| 15      | TERM      | Terminates if possible
| 17      | STOP      | Stops unconditionally, but doesn’t terminate
| 18      | TSTP      | Stops or pauses, but continues to run in background
| 19      | CONT      | Resumes execution after STOP or TSTP

* Two commands available in Linux allow you to send process signals to running processes.
  * `kill` command  : allows you to send signals to processes based on their `PID`.
  * `-s` : allows you to specify other signals (either using their name or signal number): `$ kill -s HUP 1240`
  * `killall` command : is a powerful way to stop processes by using their names rather than the `PID` numbers.
 
* Examples: 
*
  ```bash
  kill 123 543 2341 3453
  kill -l 11                    # Translate 11 into a signal nam
  kill -9 -1                    # Kill all process you can kill
  kill -L, -l                   # List signal names in a nice table.
  # A PID of -1 is special; it indicates all processes except the kill process itself and init.

  killall firefox
  killall -s QUIT firefox
  killall -l                  # List all known signal
  ```

