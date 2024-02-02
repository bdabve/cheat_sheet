<head><title>Presenting Data</title></head>

# <center>Presenting Data</center>

## Introduction

* 0 == `STDIN`  :	When you use `<`, Linux replaces the `STDIN` with the file referenced by the redirection.(many bash cmd accept input from STDIN)
* 1 == `STDOUT` : The `STDOUT` on terminal is the monitor. `>` write to a file, `>>` append to a file. 
* 2 == `STDERR` : `2>` redirect error to a file, `2>>` append,

  ```bash
  ls -al test badtest 2>errfile 1>normalfile  # Redirect stderr to errfile, and stdout to normalfile.
  ls -al test badtest &>file  		            # Redirect both STDERR and STDOUT to file.
  ```

## Redirection Output in Scripts:

* There are two methods for redirecting output in the script:
	* Temporarily redirecting each line
	* Permanently redirecting all commands in the script

### Temporarily redirecting each line:

* When you redirect to a file descriptor, you must precede the file descriptor number with an ampersand `&`: `echo "This is an error message" >&2`

  ```bash
  #!/bin/bash
  # testing STDERR messages
  echo "This is an error" >&2
  echo "This is normal output"  # to use this featur run the script as follow: nameOFfile.sh 2>errorfile
  ```

### Permanent redirections:

* If you have lots of data that you're redirecting in your script,Instead, you can tell the shell to redirect a specific file descriptor for the duration of the script by using the `exec` command:

  ```bash
  #!/bin/bash
  # redirecting all output to a file
  exec 1>testout
  echo "This is a test of redirecting all output"
  echo "from a script to another file."
  echo "without having to redirect every individual line"
  ```

* The `exec` command starts a new shell and redirects the STDOUT file descriptor to a file.
* This feature can come in handy when you want to redirect the output of just parts of a script to an alternative location, such as an error log. There's just one problem you run into when using this.
* After you redirect `STDOUT` or `STDERR`, you can't easily redirect them back to their original location. If you need to switch back and forth with your redirection, you need to learn a trick. "Creating Your Own Redirection"

## Redirecting Input in Scripts:

* You can use the same technique used to redirect `STDOUT` and `STDERR` in your scripts to redirect STDIN from the keyboard. 
* The `exec` command allows you to redirect `STDIN` from a file on the Linux system: `exec 0 < testfile`

  ```bash
  #!/bin/bash
  # redirecting file input
  exec 0 < testfile
  count=1
  while read line; do
    echo "Line #$count: $line"
    count=$[ \$count + 1 ]
  done
  ```

## Creating Your Own Redirection:

* You assign a file descriptor for output by using the `exec` command. That redirection stays permanent until you reassign it.

  ```bash
  #!/bin/bash
  # using an alternative file descriptor
  exec 3>test13out
  echo "This should display on the monitor"
  echo "and this should be stored in the file" >&3
  echo "Then this should be back on the monitor"
  ```
* This allows you to keep normal output for the monitor and redirect special information to files, such as log files.
* You can also use the exec command to append data to an existing file instead of creating a new file: `exec 3>>test13out`

## Redirecting file descriptors:

* Here's the trick to help you bring back a redirected file descriptor.
* you can redirect the original location of STDOUT to an alternative file descriptor and then redirect that file descriptor back to STDOUT.

  ```bash
  #!/bin/bash
  # storing STDOUT, then coming back to it
  exec 3>&1
  exec 1>test14out
  echo "This should store in the output file"
  echo "along with this line."
  exec 1>&3
  echo "Now things should be back to normal"
  ```
* This method can get confusing, but it's a common way to temporarily redirect output in script files and then set the output back to the normal settings.

## Creating input file descriptors:

* You can redirect input file descriptors exactly the same way as output file descriptors. Save the `STDIN` file descriptor location to another file descriptor before redirecting it to a file; when you're finished reading the file, you can restore `STDIN` to its original location:

  ```bash
  #!/bin/bash
  # redirecting input file descriptors
  exec 6<&0
  exec 0<testfile
  count=1
  while read line; do
    echo "Line #$count: $line"
    count=$[ \$count + 1 ]
  done

  exec 0<&6
  read -p "Are you done now? " answer
  case $answer in
    Y|y) echo "Goodbye";;
    N|n) echo "Sorry, this is the end.";;
  esac
  ```
* In this example, file descriptor 6 is used to hold the location for `STDIN`. 
* The script then redirects `STDIN` to a file. All the input for the read command comes from the redirected `STDIN`, which is now the input file.
* When all the lines have been read, the script returns `STDIN` to its original location by redirecting it to file descriptor 6. 
* The script tests to make sure that `STDIN` is back to normal by using another read command, which this time waits for input from the keyboard.

## Creating a read/write file descriptor:

* You need to be especially careful with this method, however. 
* As you read and write data to and from a file, the shell maintains an internal pointer, indicating where it is in the file. 
* Any reading or writing occurs where the file pointer last left off. 
* This can produce some interesting results if you're not careful.

  ```bash
  #!/bin/bash
  # testing input/output file descriptor
  exec 3<>testfile
  read line <&3
  echo "Read: $line"
  echo "This is a test line" >&3
  ```
* This example uses the `exec` command to assign file descriptor 3 for both input and output sent to and from the file testfile.
* When the script writes data to the file, it starts where the file pointer is located. 
* The read command reads the first line of data, so it left the file pointer pointing to the first character in the second line of data. 
* When the echo statement outputs data to the file, it places the data at the current location of the file pointer, overwriting whatever data was there.

## Closing file descriptors:
* If you create new input or output file descriptors, the shell automatically closes them when the script exits. 
* There are situations, however, when you need to manually close a file descriptor before the end of the script.
* To close a file descriptor, redirect it to the special symbol &-. This is how this looks in the script: `exec 3>&-`

```bash
#!/bin/bash
# testing closing file descriptors
exec 3>test17file
echo "This is a test line of data" >&3
exec 3>&-
echo "This won't work" >&3
```
* There's yet another thing to be careful of when closing file descriptors. 
* If you open the same output file later on in your script, the shell replaces the existing file with a new file. 
* This means that if you output any data, it overwrites the existing file. 
* Consider the following example of this problem:

  ```bash
  #!/bin/bash
  # testing closing file descriptors
  exec 3>test17file
  echo "This is a test line of data" >&3
  exec 3>&-
  cat test17file
  exec 3>test17file
  echo "This'll be bad" >&3
  ```
* After sending a data string to the `test17file` file and closing the file descriptor, The shell overwrote the original output file.

## Listing Open File Descriptors:

* The `lsof` command lists all the open file descriptors on the entire Linux system.
* usage: `lsof -a -p $$ -d 0,1,2`
  * `-p`   : To specify a process ID (PID)
  * `-d`   : To specify the file descriptor numbers to display.
  * `$$`   : To easily determine the current PID of the process.
  * `-a`   : Used to perform a Boolean AND of the results of the other two options.
  * Example: `lsof -a -p $$ -d 0,1,2`
  
* This shows the default file descriptors (0, 1, and 2) for the current process (the bash shell).
* Default lsof Output:

| COLUMN	|				DESCRIPTION						 
|---------|-------------------------------
| COMMAND	| The first nine characters of the name of the command in the process
| PID		| The process ID of the process
| USER		| The login name of the user who owns the process
| FD		| The file descriptor number and access type [r—(read), w—(write), u—(read/write)]
| TYPE		| The type of file [CHR—(character), BLK— (block), DIR— (directory), REG—(regular file)]
| DEVICE	| The device numbers (major and minor) of the device
| SIZE		| If available, the size of the file
| NODE		| The node number of the local file
| NAME		| The name of the file

* The file type associated with `STDIN`, `STDOUT`, and `STDERR` is character mode.
* Now see the file lsof.sh for more information of how to use it in script.

## Logging Messages:

* Sometimes, it's beneficial to send output both to the monitor and to a file for logging. 
* Instead of having to redirect output twice, you can use the special `tee` command.
* The `tee` command is like a T-connector for pipes. It sends data from `STDIN` to two destinations at the same time. 
* One destination is `STDOUT`. The other destination is a filename specified on the tee command line: `tee filename `

  ```bash
  who | tee testfile
  date | tee testfile
  ```
* If you want to append data to the file, you must use the `-a` option
* Here a pracrical Example for using input and output data

  ```bash
  #!/bin/bash 
  #: Descreption  : write into database from file.csv
  #: Option       : take the file.csv as argument
  # This example script does both of those things I/O  
  # It read a .csv-formatted data file and output SQL INSERT statements to insert data onto a database 
   
  # read file and create INSERT statements for MySQL 
  outfile='members.sql' 
  IFS=',' 
  while read lname fname address city state zip 
  do      
          cat >>$outfile <<EOF 
          INSERT INTO members (lname,fname,address,city,state,zip) VALUES 
          ('$lname', '$fname', '$address', '$city', '$state', '$zip'); 
          EOF 
  done <${1}
  ```
