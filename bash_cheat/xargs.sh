#!/bin/bash
#
if [ -f "/home/dabve/bin/lib/cliColor" ];then
    . "/home/dabve/bin/lib/cliColor"
fi
if [ -f "/home/dabve/bin/lib/functions_lib" ];then
    . "/home/dabve/bin/lib/functions_lib"
fi
#
clear

echo -e "\t$Bold[+] xargs Options:$colorOff

| Option    | Meaning
|-----------|-------------
| -p        | Print the command to be executed and prompt the user to run it.
| -t        | Prints each command that will be executed to the terminal
| -I        | Run multiple commands with xargs


# Change all occurrence for multiple files
$Green$ grep -rl 'lib/pause' *.sh | xargs -t -n 1 sed -i -e 's/lib\/pause/lib\/functions_lib/g'$colorOff
"
#
pause
#
echo -e "\t$Bold[+] xargs Command:$colorOff

* delete too many file using rm, use xargs to avoid any problem.
    $Green$ find ~ -name '*.log' -print0 | xargs -0 rm -f $colorOff
    $Green$ find -name *.pdf | xargs rm -rf $colorOff

* if file name contains spaces you should use this instead
    $Green$ find -name *.pdf | xargs -I{} rm -rf '{}' $colorOff
    $Green$ find -name *.pdf -print0 | xargs -O rm -f $colorOff

    $Green$ find -name "*.pdf" | xargs --no-run-if-empty rm $colorOff     # If find returns no result, do not run rm

* Will show every .pdf like: &toto.pdf=
# -n1 => One file by one file. ( -n2 => 2 files by 2 files )
    $Green$ find -name *.pdf | xargs -I{} -n1 echo '&{}=' $colorOff
    $Green$ find -name "*.sh" | xargs -I{} -n1 echo '[+] {}' $colorOff

* list all the '*.conf' file under '/etc/'.The output of 'find' is passed to ls –l one by one using xargs.
    $Green$ find /etc -name '*.conf' | xargs ls -l $colorOff

    $Green$ cat url-list.txt | xargs wget -c $colorOff # download from file with list of URLs.
    $Green$ pgrep -f example | xargs kill$colorOff     # Kill all PIDs matching the pattern"
#
pause
#
echo -e "
* Find out all jpg images and archive it.
    $Green $ find / -name *.jpg -type f -print | xargs tar -cvzf images.tar.gz $colorOff

* Copy all the image to external hard-drive.
    $Green $ ls *.jpg | xargs -n1 -i cp {} /external-hard-drive/directory $colorOff

* Update all python library.pip
    $Green $ pip list --outdated --format=columns | sed '1,2d' | cut -d \" \" -f 1 | sudo xargs -n 1 pip install -U $colorOff

* Remove space from file names:
    $Green $ find /home/dabve/ -type f -print0 | xargs -0 -n 1 | tr -d ' ' $colorOff

* Know the number of lines/words/characters in each file in the list
    $Green $ ls *.txt | xargs wc

* Remove a directory
    $Green $ find downloads -name \"domterm\" -type d -print0 | xargs -O /bin/rm -v -rf \"{}\"$colorOff

* Copy a file to multiple directories at once
    $Green $ echo ./tpl ./doc ./bin | xargs -n 1 cp -v ./download/main.js
    $Green $ echo ./tpl ./doc ./bin | xargs -p -n 1 cp -v ./download/main.js    # Prompt the user for each command
"
