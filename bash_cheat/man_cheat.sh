#!/bin/bash
#
if [ -s "/home/dabve/bin/lib/cliColor" ];then
    source "/home/dabve/bin/lib/cliColor"
fi
#
if [ -s "/home/dabve/bin/lib/functions_lib" ];then
    source "/home/dabve/bin/lib/functions_lib"
fi
#
clear
echo -e "\t$Bold[+] The Linux man Page Section Areas:$colorOff

Section Number  | 		Area Contents
----------------------------------------------------------------------
1               | Executable programs or shell commands
2               | System calls
3               | Library calls
4               | Special files
5               | File formats and conventions
6               | Games
7               | Overviews, conventions, and miscellaneous
8               | Super user and system administration	commands
9               | Kernel routines
-----------------------------------------------------------------------

    $Green$ man -a intro$colorOff               # All of the available intro manual pages contained within the manual.
    $Green$ MANSECTS=8,1,2,3,4,5,6,7$colorOff   # Specify a list of sections in the order in which you want
    $Green$ cat /etc/manpath.config$colorOff    # Configure the man and cat paths.
    $Green$ man -k KEYWORD$colorOff              # Search for Man Pages.
    $Green$ man -f printf$colorOff              # Short descriptions of any found.  Equivalent to whatis printf.
    $Green$ man 7 ls$colorOff                   # Display man of section 7"
#
pause
#
echo -e "
* NOTE: Type$Bold h$colorOff for additional information while indide man and type$Bold q$colorOff to quit

    #$Bold /pattern$colorOff      : Searching forward for matching pattern.
    #$Bold ?pattern$colorOff      : Searching backward for matching pattern.
    #$Bold n$colorOff             : Repeat previous search.
    #$Bold N$colorOff             : Repeat previous search in reverse direction.
    #$Bold Esc-u$colorOff         : Undo (toggle) search highligting

    #$Bold Bold Text$colorOff     : Type exactly as shown.
    #$Bold Italic text$colorOff   : Replace with appropriate argument.
    #$Bold [-abc]$colorOff        : Argument within [] are optional.
    #$Bold -a | -b$colorOff       : option cannot be used together.
    #$Bold argument...$colorOff   : Argument is repeatable.


$Bold[+] Getting Help with Shell Builtins$colorOff
    $Green$ help read$colorOff
    $Green$ help cd$colorOff
    $Green$ help while$colorOff

$Bold[+] Determining type of command$colorOff

# Work also with function declared in .bashrc or profile
    $Green$ type alias$colorOff
    $Green$ type man$colorOff
    $Green$ type ls$colorOff

$Green$ man -t bash | ps2pdf - bash.pdf$colorOff    # Convert a man page to pdf
$Green$ man 7 ascii$colorOff                        # View the ascii chart
"
