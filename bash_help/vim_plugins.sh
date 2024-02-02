#!/bin/bash -
#===============================================================================
#
#          FILE: test.sh
#
#         USAGE: ./test.sh
#
#   DESCRIPTION: Plugins installed for vim
#
#        AUTHOR: Dabve (), bdabve@gmail.com
#  ORGANIZATION: localhost
#       CREATED: 04/26/2018 08:42:36 PM
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#
# source clicolor
if [ -f /home/dabve/bin/lib/cliColor ];then
    source /home/dabve/bin/lib/cliColor
fi
#
pause(){
    echo -en "\n$Yellow[:] Hit Any <KEY> To Continue: "
    read -rn 1
    clear
    }
#
#
inflector(){
    clear
    echo -e "$Bold[*] Inflector Vim:$colorOff
Inflection     Alias    Input               Command     Output
-------------------------------------------------------------------------
Dotify          .       someTextToWork      gIiw.       some.text.to.work
Dasherize       -       some_text_to_work   gIiw-       some-text-to-work
Underscore      _       some text to work   gI\$_       some_text_to_work
Camelize        c       Some Text To Work   gI\$c       someTextToWork
Constantize     C       some text to work   gI\$C       SOME_TEXT_TO_WORK
Pascalize       P       some.text.to.work   gIiWP       SomeTextToWork
Titleize        t       some text to work   gI\$t       Some Text To Work
Normalize       n       SOME_TEXT_TO_WORK   gI\$n       some text to work
Slashify        /       SOME_TEXT_TO_WORK   gIiw/       some/text/to/work
FreeBallIt      f       some text to work   gI\$f&      some&text&to&work
Privatize       p       some_var            gI\$p       _some_var"
}
#
#
bashSupport(){
    clear
    echo -e "$Bold[*] Bash Support:$colorOff

\\\nw         |
\\nr         | Read Code snipets
\hm <cmd>   | Command Help
\hh         | Built-in Command help
\\rr         | update file, RUN
\\rc         | update file, check syntax
\\rd         | Debugger
⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻⁻
\sc         | Case Statement
\sf         | for loop
\sfo        | for loop c++
\sw         | while loop
\si         | if statement
\sei        | elif Then
\sie        | if else statement
\ss         | select statement
\su         | until statement
\sfu        | function
\\cfu        | function comment
\se         | echo -e
\sp         | printf
\sa         | array element
\\cfr        | comment block"
}
#
#
nerdTree(){
    clear
    echo -e "$Bold[*] NERDTree:$colorOff
:NERDTreeToggle     show / hide file browser
:NERDTreeFind       show current file in file browser
:Bookmark name      bookmark the current node as 'name'

FILE
----

o                   open in prev window
go                  preview
t                   open in new tab
T                   open in new tab silently
i                   open split
gi                  preview split
s                   open vsplit
gs                  preview vsplit

DIRECTORY
---------

o                   open & close node
O                   recursively open node
x                   close parent of node
X                   close all child nodes of current node recursively
e                   explore selected dir

BOOKMARK
--------

o                   open bookmark
t                   open in new tab
T                   open in new tab silently
D                   delete bookmark

TREE NAVIGATION
---------------
P                   go to root
p                   go to parent
K                   go to first child
J                   go to last child
CTRL-j              go to next sibling
CTRL-k              go to prev sibling

FILESYSTEM
----------
C                   change tree root to the selected dir
u                   move tree root up a dir
U                   move tree root up a dir but leave old root open
r                   refresh cursor dir
R                   refresh current root
m                   show menu
cd                  change the CWD to the selected dir

TREE FILTERING
--------------
I                   hidden files
f                   file filters
F                   files
B                   bookmarks

OTHER
-----
q                   close the NERDTree window
A                   zoom (maximize-minimize) the NERDTree window
?                   toggle help"
}
#
#
surround(){
    clear
    echo -e "$Bold[*] Surround:$colorOff

cs'\"               change surrounding quotes to double-quotes
cs(}                change surrounding parens to braces
cs({                change surrounding parens to braces with space
ds'                 delete surrounding quotes
dst                 delete surrounding tags
ysiw[               surround inner word with brackets
vees'               surround 2 words (ee) with quotes '"
}
#
#
menu(){
    clear
    echo -e "\n$Bold[*] Vim Plugins:$colorOff

    1. Inflector Vim.
    2. Bash Support.
    3. NERDTree.
    4. Surround.
    0. Exit"
    echo -en "\n$Bold[:] Your Choice: $colorOff"
    read -rn 1 choice
}
# ------------------------- Main Script
#
while true; do
    menu
    case $choice in
        1)  inflector
            pause
            ;;
        2)  bashSupport
            pause
            ;;
        3)  nerdTree
            pause
            ;;
        4)  surround
            pause
            ;;
	    0)  exit 0
            ;;
        *)  clear
            echo -en "$Red[-] Wrong choice :($colorOff"
            pause
            ;;
    esac
done
