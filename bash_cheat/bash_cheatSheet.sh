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
basics(){
    clear
    echo -e "
    $Bold[+] BASH BASICS$colorOff

| Command             | Meaning                                    |
|---------------------|--------------------------------------------|
| env                 | displays all environment variables
| echo \$SHELL         | displays the shell you're using
| echo \$BASH_VERSION  | displays bash version
| bash                | if you want to use bash (type exit to go back to your previously opened shell)
| whereis bash        | finds out where bash is on your system
| which bash          | finds out which program is executed as 'bash' (default: /bin/bash, can change across environments)
| command             | removes alias and function lookup. Only built-ins and commands found in the search path are executed
| builtin             | looks up only built-in commands, ignoring functions and commands found in PATH
| enable              | enables and disables shell built-ins
| eval                | takes arguments and run them through the command-line processing steps all over again
| \$$                 | A special shell variable whose value is the process ID of the current shell.
| \$!                 | Contain the process ID of the most recently invoked background job.

# The default order for command lookup is functions, followed by built-ins, with scripts and executables last.
# There are three built-ins that you can use to override this order: 'command', 'builtin' and 'enable'.
"
#
}
shell_options(){
    clear
    echo -e "\t$Bold[+] Basic Shell Options:$colorOff

| Option    | Meaning
| ----------|-----------------------------------------------
| emacs     | Enters emacs editing mode (on by default)
| ignoreeof | Doesn't allow use of a single CTRL-D tolog off; use the exit command to log off emmediately
| noclobber | Doesn't allow output redirection (>) to overwrite an existing file
| noglob    | Doesn't expand filename wildcards like * and ? (wildcard expansion is sometimes called globbing)
| nounset   | Indicates an error when trying to use a variable that is undefined
| vi        | Enters vi editing mode

# There are several other options (21 in all).
    $Green$ set -o$colorOff                     # To check the status of an option, just type
    $Green$ set -o optionName$colorOff          # Turn optionName On
    $Green$ set +o optionName$colorOff          # Turn optionName Off

    $Green$ set -o pipefail$colorOff            # Detect error command in pip alternative variable PIPESTATUS
    $Green$ set -o nounset$colorOff             # Treat unset variable as an error

    # Retrieve N-th piped command exit status
    $Green$ printf 'foo' | fgrep 'foo' | sed 's/foo/bar/'; echo \${PIPESTATUS[0]}$colorOff          # replace 0 with N

    $Green$ ( set -o noclobber; echo > my.lock ) || echo 'Failed to create lock file'$colorOff      # Lock file"
    #
    pause
    #
    echo -e "

$Bold[+] shopt$colorOff: is a built-in cmd is meant as a replacement for option configuration originally done through environment variables and the set cmd.

| Option    | Meaning
|-----------|-----------------------------------------------------------
| -p        | Desplay settable option and their current value
| -s        | Sets each option name
| -u        | Unset each option name
| -q        | Suppesses normal output, the return status indicates if a variable is set or unset
| -o        | Allows the values of of the option names to be those defined for the -o option of the set

    $Green$ shopt$colorOff                  # Desplay all options
    $Green$ shopt -s option_name$colorOff   # Enable option
    $Green$ shopt -u option_name$colorOff   # disable option
"
}
debugging(){
    clear
    echo -e "
    $Bold[+] Debugging Shell Scripts$colorOff

| Command             | Meaning                                    |
|---------------------|--------------------------------------------|
| bash -n scriptname  | don't run commands; check for syntax errors only
| set -o noexec       | alternative (set option in script)
| bash -v scriptname  | echo commands before running them
| set -o verbose      | alternative (set option in script)
| bash -x scriptname  | echo commands after command-line processing
| set -o xtrace       | alternative (set option in script)
| trap 'echo \$varname' EXIT  | useful when you want to print out the values of variables at the point that your script exits

    $Green$ set -x$colorOff  # Turn on debugging:
    $Green$ set +x$colorOff  # Turn off debugging:
    "
}
#
#
exit_status(){
    clear
    echo -e "
    $Bold[+] The Linux Error Exit Status:$colorOff

| Error  | Meaning
|--------|---------------------------------------------
| 0      | Successfull completion of the command
| 1      | General unknown error
| 2      | Misuse of shell command
| 126    | The command can't execute
| 126    | The user didn't have permission
| 127    | Command not found
| 128    | Invalid exit argument
| 128+x  | Fatal error with linux signal x
| 130    | Command terminated with Ctrl+C
| 255    | Exit status out of range
"
}
#
#
signals(){
    clear
    echo -e "
    $Bold[+] Linux Signal:$colorOff

# There are more than 30 Linux signal can be generated by the system
# This table lists the most common Linux Systeme signal.

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

# By default, the bash shell ignores any (3) and (15) signal it receive(an interactive shell cannot be accidentally terminated).
# The bash shell does not ignore any (1) and (2) signals it receives
# A PID of -1 is special; it indicates all processes except the kill process itself and init.
    "
    #
    pause
    #
    echo -e "

# Two commands available in Linux allow you to send process signals to running processes.

# 'killall' command : is a powerful way to stop processes by using their names rather than the 'PID' numbers.
  $Green$ killall firefox$colorOff
  $Green$ killall -s QUIT firefox$colorOff
  $Green$ killall -l$colorOff                  # List all known signal

# 'kill' command  : allows you to send signals to processes based on their 'PID'.
# '-s' : allows you to specify other signals (either using their name or signal number):
    $Green$ kill -s HUP 1240$colorOff
    $Green$ kill 123 543 2341 3453$colorOff
    $Green$ kill -l 11$colorOff                    # Translate 11 into a signal nam
    $Green$ kill -9 -1$colorOff                    # Kill all process you can kill
    $Green$ kill -L, -l$colorOff                   # List signal names in a nice table.
  "
}
#
#
file_permissions(){
    clear
    echo -e "
    $Bold[+] File Permissions$colorOff

| Octal   | Binary    | FileMode
|---------|-----------|-------
| 0       |  000      |  ---
| 1       |  001      |  --x
| 2       |  010      |  -w-
| 3       |  011      |  -wx
| 4       |  100      |  r--
| 5       |  101      |  r-x
| 6       |  110      |  rw-
| 7       |  111      |  rwx

# The umask command controls the default permissions given to a file when it is created.
# The corresponding attribute is unset.

    $Green$ umask 0022$colorOff      # Will Remove The w to group and other.
    "
}
builtin_commands(){
    clear
    echo -e "
    $Bold[+] Built-in Commands

$Green$ buitin cd$colorOff      # The builtin tells the shell to use the built-in command and ignore any function of that name.
    "
}
#
#
menu(){
    clear
    echo -e "${Bold}[+] Bash Cheat Sheet:$colorOff

    1. Bash Basics
    2. Shell Options
    3. Debugging
    4. Exit Status
    5. Linux Signals
    6. File Permissions
    0. Exit"
    echo
    echo -en "$Bold[:]Choose From the Menu: $colorOff"; read -rn 1 Choice
}
#
while true; do
    clear
    menu
    case $Choice in
        1)  basics; pause ;;
        2)  shell_options; pause ;;
        3)  debugging; pause ;;
        4)  exit_status; pause ;;
        5)  signals; pause ;;
        6)  file_permissions; pause ;;
        0)  echo -e "\nBye"; exit 0 ;;
        *)  echo -e "\n$Red[-] Wrong Choice $colorOff"; pause ;;
    esac
done
