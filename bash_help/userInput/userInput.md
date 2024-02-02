# <center>User Input</center>

## Internal Field Separator (IFS):

* By default, the bash shell considers the following character as field separator:
	* A space.
	* A tab.
	* A newline
* A safe practice to use `IFS` in a long script is coded like this:

```bash
IFS.OLD=$IFS
IFS='\n'       # The new IFS = to a newline
IFS=$IFS.OLD   # Now return to the old IFS
```

## Grabbing all the data:

* using the `$#` variable to determine how many parameters are on the command line
* The `$*` and `$@` variables provide easy access to all your parameters. 
* Both of these variables include all the command line parameters within a single variable.
* The `$*` variable takes all the parameters supplied on the command line as a single word. 
* The `$@` variable, on the other hand, takes all the parameters supplied on the command line as separate words in the same string. 
* It allows you to iterate through the values, separating out each parameter supplied.
* For more information execute this file `/home/dabve/programming/bash/remindMe/userInput/suit_importantNote.sh`.

  ```bash
  #!/bin/bash
  # File Name: suit_importantNote.sh
  # testing $* and $@

  if [ $# -lt "2" ];then
    echo -e "\n\tusage: $( basename $0 | sed s,\.sh$,,) param1 param2\n"
    exit
  fi
  echo
  count=1

  for param in "$*"
  do
    echo "\$* Parameter #$count = $param"
    count=$[ $count + 1 ]
  done

  echo
  count=1

  for param in "$@"
  do
    echo "\$@ Parameter #$count = $param"
    count=$[ $count + 1 ]
  done
  ```

## Passing Parameters

```bash
factorial=1
for (( number = 1; number <= $1 ; number++ )); do
    factorial=$[ $factorial * $number ]
done
echo The factorial of $1 is $factorial

## Passing two parameter
total=$[ $1 * $2 ]
echo The first parameter is $1.
echo The second parameter is $2.
echo The total value is $total.

# Using basename with the $0 parameter
name=$(basename $0)
echo The script name is: $name

# Testing parameters before use
if [ -n "$1" ]; then
    echo Hello $1, glad to meet you.
else
    echo "Sorry, you did not identify yourself. "
fi
```
## Being Shifty:

* The bash shell provides the `shift` command to help you manipulate command line parameters.
* When you use the `shift` command, it moves each parameter variable one position to the left by default. 
* Thus, the value for variable `$3` is moved to `$2`, the value for variable `$2` is moved to `$1`, and the value for variable `$1` is discarded
	
* For more information execute the file `shiftparam.sh` like this: `./shiftparam.sh dabve band firoud amine `

  ```bash
  #!/bin/bash
  # demonstrating the shift command
  echo
  count=1
  while [ -n "$1" ]
  do
    echo "Parameter #$count = $1"
    count=$[ $count + 1 ]
    shift
  done
  ```

## Working with options:

* You saw how to use the shift command to work your way down the command line parameters provided with the script program. 
* You can use this same technique to process command line options.
* As you extract each individual parameter.
* For more information execute the file `shiftopt.sh` like this: `./shiftopt.sh -a -b -c -d`

## Separating option from parameters:

* Often you'll run into situations where you'll want to use both options and parameters for a shell script.
* The standard way to do this in Linux is to separate the two with a special character code that tells the script when the options are finished and when the normal parameters start. 
* For Linux, this special character is the double dash `--`. 
* The shell uses the double dash to indicate the end of the option list.
* For more information execute the file `optionWparam.sh` like this: `./optionWparam.sh -c -a -b -- test1 test2 test3`

  ```bash
  #!/bin/bash
  # extracting options and parameters
  echo
  while [ -n "$1" ]
  do
    case "$1" in
      -a) echo "Found the -a option" ;;
      -b) echo "Found the -b option";;
      -c) echo "Found the -c option" ;;
      --) shift
        break ;;
      *) echo "$1 is not an option";;
    esac
    shift
  done

  for param in $@
  do
    echo "Parameter #$count: $param"
    count=$[ $count + 1 ]
  done
  ```

## rocessing options with values:

* Some options require an additional parameter value. In these situations, the command line looks something like this:
* For more information execute the file `optionWparam01.sh` like this: `./optionWparam01.sh -a -b test1 -d`

  ```bash
  #!/bin/bash
  # extracting command line options and values
  echo
  while [ -n "$1" ]
  do
    case "$1" in
      -a) echo "Found the -a option";;
      -b) param="$2"
        echo "Found the -b option, with parameter value $param"
        shift;;
      -c) echo "Found the -c option";;
      --) shift
        break ;;
      *) echo "$1 is not an option";;
    esac
    shift
  done

  count=1
  for param in "$@"
  do
    echo "Parameter #$count: $param"
    count=$[ $count + 1 ]
  done
  ```

## Using the getopt command:

* The `getopt` command is a great tool to have handy when processing command line options and parameters. 
* It reorganizes the command line parametersto make parsing them in your script easier.
* The `getopt` command can take a list of command line options and parameters, in any form, and automatically turn them into the proper format. 
* It uses the following command format: `getopt optstring parameters`	

  ```bash
  getopt ab:cd -a -b test1 -cd test2 test3
  getopt ab:cd -a -b test1 -cde test2 test3
  getopt ab:cd -a -b test1 -cd test2 test3
  getopt ab:cd -a -b test1 -cde test2 test3

  # If you prefer to just ignore the error messages, use getopt with the -q option:
  getopt -q ab:cd -a -b test1 -cde test2 test3
  getopt -q ab:cd -a -b test1 -cde test2 test3
  ```

### sing the getopt on your script:

* The trick is to replace the existing command line options and parameters with the formatted version produced by the `getopt` command. 
* The way to do that is to use the `set` command.
* This looks something like this:  `set -- $(getopt -q ab:cd "$@")\e[0m`	
* Execute the file `getopt.sh` like this: `./getopt.sh -a -b test1 -cd test2 test3 test4`

  ```bash
  #!/usr/bin/python
  # Extract command line options &values with getopt

  set -- $((getopt -q ab:cd "$@"))

  echo
  while [ -n "$1" ];do
    case "$1" in
      -a) echo "Found the -a option" ;;
      -b) param="$2"
        echo "Found the -b option, with parameter value $param"
        shift ;;
      -c) echo "Found the -c option" ;;
      --) shift
        break ;;
      *) echo "$1 is not an option";;
    esac
    shift
  done

  count=1
  for paramin "$@";do
    echo "Parameter #$count: $param"
    count=$[ $count + 1 ]
  done
  ```

## Advancing to getopts:

* Unlike `getopt`, which produces one output for all the processed options and parameters found in the command line. 
* The `getopts` command works on the existing shell parameter variables sequentially.
* It processes the parameters it detects in the command line one at a time each time it's called. 
* When it runs out of parameters, it exits with an exit status greater than zero. 
* This makes it great for using in loops to parse all the parameters on the command line.
* Here's the format of the getopts command: `getopts optstring variable`

* The `getopts` command places the current parameter in the variable defined in the command line.

* The `getopts` command uses two environment variables. 
  * The `OPTARG` environment variable contains the value to be used if an option requires a parameter value. 
  * The `OPTIND` environment variable contains the value of the current location within the parameter list where getopts left off. 
* This allows you to continue processing other command line parameters after finishing the options.

* Execute the file `getopts.sh` like this: 

  ```bash
  ./getopts.sh ./getopts.sh -ab test1 -c
  ./getopts.sh -b \"test1 test2\" -a
  ./getopts.sh -abtest1
  ./getopts.sh -d
  ./getopts.sh -acde\e[0m
  ```
  ```bash
  #!/bin/bash
  # simple demonstration of the getopts command

  echo
  while getopts :ab:c opt; do
    case "$opt" in
      a) echo "Found the -a option" ;;
      b) echo "Found the -b option, with value $OPTARG";;
      c) echo "Found the -c option" ;;
      *) echo "Unknown option: $opt";;
    esac
  done
  ```

* The `getopts` command knows when to stop processing options and leave the parameters for you to process. 
* As `getopts` processes each option, it increments the `OPTIND` environment variable by one. 
* When you've reached the end of the `getopts` processing, you can use the `OPTIND` value with the shift command to move to the parameters:
* Execute the file `getoptsWparam.sh` for demonstration: `./getoptsWparam.sh -a -b test1 -d test2 test3 test4`

  ```bash
  #!/bin/bash
  # Processing options &parameters with getopts

  echo
  while getopts :ab:cd opt; do
    case "$opt" in
      a) echo "Found the -a option" ;;
      b) echo "Found the -b option, with value $OPTARG" ;;
      c) echo "Found the -c option" ;;
      d) echo "Found the -d option" ;;
      *) echo "Unknown option: $opt" ;;
    esac
  done
#
  shift $[ $OPTIND - 1 ]
#
  echo
  count=1
  for param in "$@"
  do
    echo "Parameter $count: $param"
    count=$[ $count + 1 ]
  done
  ```

## Standardizing Options:
* However, a few letter options have achieved a somewhat standard meaning in the Linux world. 
* If you leverage these options in your shell script, your scripts will be more user-friendly.
* Common Linux Command Line Option:

| Option	| Description
|:-------:|-------------------------------
| -a | Shows all objects
| -c | Produces a count
| -d | Specifies a derectory
| -e | Expands an object
| -f | Specifies a file to read data from
| -h | Displays a help message for the command
| -i | Ignores text case
| -l | Produces a long format version of the output
| -n | Uses a non-interactive (batch) mode
| -o | Specifies an output file to redirect output to
| -q | Runs in quiet mode
| -r | Processes directories and file recursively
| -s | Runs in silent mode
| -v | Produces verbose output
| -x | Excludes an object
| -y | Answer yes to all questions
 
* Using the same meaning for your options helps users interact with your script easly.
