#!/bin/bash
#
#
#
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
#
movingCommend(){
    clear
    echo -e "$Bold[*] Moving Command:$colorOff

| B         | previous WORD
| b         | Move backward one word
| U         | undo all the changes on a line.
| H         | Move to the top of screen
| M         | Move to the middle of screen
| L         | Move to the middle of screen
| <CTRL>+g  | Location in file.
| <CTRL>+u  | Up 1/2 page
| <CTRL>+b  | Up 1 page
| <CTRL>+d  | Down 1/2 page
| <CTRL>+f  | Down 1 page
| gf        | Find file under cursor in path and jump to it.
| )         | Move the cursor forward to the next sentence.
| (         | Move the cursor backward by a sentence.
| {         | Move the cursor a paragraph backwards
| }         | Move the cursor a paragraph forwards
| ]]        | Move the cursor a section forwards or to the next {
| [[        | Move the cursor a section backwards or the previous {
"
}
#
#
editingCommand(){
    clear
    echo -e "$Bold[*] Editing Commands And Keybinding:$colorOff

| g~iw      | Switch case of current word
| gUiw      | Make current word uppercase
| guiw      | Make current word lowercase
| gU$       | Make uppercase until end of line
| gu$       | Make lowercase until end of line
| ==        | Auto-indent current line
| :%retab   | Fix spaces / tabs issues in whole file
| :r [name] | Insert the file [name] below the cursor.
| :r !{cmd} | Execute {cmd} and insert its standard output below the cursor.
| :w !bash  | Execute the content of file with bash

$Bold[+] Normal Mode Keystokes$colorOff

| <C-a>               | add [count] to number (ex: 10<C-a>)
| <C-x>               | substract [count] on number (ex: 10<C-a>)
                      | to work with decimal you must add (:set nrformats=)
| <C-h>               | Delete back one character (backspace)
| <C-w>               | Delete back one word.
| <C-u>               | Delete back to start of line.
| <C-r>{register}     | Yank in Insert mode (ex: <C-r>0).
| <C-o>               | Insert Normal Mode(we can fire a single command)
| <C-r>=6*35<cr>      | Calculator.
| 6 chairs, each costing \$35, totals $     # <C-r>=6*35<cr> make calculation "
}
#
#
replace(){
    clear
    echo -e "$Bold[*] Replace:$colorOff

| c$        | Replace to the end.
| C         | c$
| ci\"{'[    | Change inside \"{'[
| ct\"{'[    | Change until \"{'[
| ca\"{'[    | Change around \"{'[
| di\"{'[    | Delete inside \"{'[
| dt\"{'[    | Delete until \"{'[
| da\"{'[    | Delete around \"{'[
| dap       | Delete Paragraphe.
| aw        | a word
| aW        | a WORD
| iw        | inner word
| iW        | inner WORD
| as        | a sentence
| is        | inner sentence
| ap        | a paragraph
| yi\"{'[    | Yank inside \"{'[
| yt\"{'[    | Yank until \"{'[
| %         | Act with () {} [].
| &         | repeat
| ge        | jump backward to end of words
 "
}
#
#
findWord(){
    clear
    echo -e "$Bold[*] Find Word:$colorOff

| Previ   | Next  | Forward   | Backward  | Match
|---------|-------|-----------|-----------|-----------------------
|     N   |   n   | /foo OR * | ?foo OR # | Foo word under cursor.
|     ;   |   ,   | t foo     | T foo     | Up to foo
|         |       | f foo     | F foo     | Find foo
|----------------------------------------------------------------------------------------
| :#,#s/aa/bb/g           | To substitute phrases between two line #'s type
| :s/target/repla         | perform substitution
| :%s/aa/bb/g             | replace all 'aa' with 'bb'
| :%s/aa/bb/gc            | replace all 'aa' with 'bb' with confirmation
| :%s/s+$//               | Delete the Ctrl-M characters from the end of files"
}
#
#
yankText(){
    clear
    echo -e "$Bold[*] Yank Text:$colorOff

| :set paste          | Avoid unexpected effects in pasting
| :registers          | Display the contents of all registers
| \"ayy > \"aP          | Use a named register a
| :[range]y x         | Yank [range] lines into register x
| \"_d                 | Nothing returns. like /dev/null
| \"xgp                | Just like \"p\", but leave the cursor just after the new text
| \"xgP                | Just like \"P\", but leave the cursor just after the new text
| :[line]put x        | Put the text from register x after [line]
| \"0P                 | The yank register is set only when when we use the y{motion} command.
| \"%                  | Name of the current file
| \"#                  | Name of the alternate file.
| \".                  | Last inserted text.
| \":                  | Last Ex command.
| \"/                  | Last search pattern.
"
}
#
#
cmdLine(){
    clear
    echo -e "$Bold[*] Vim's Command Line:$colorOff

1       | First line of the file
$       | Last line of the file
0       | Virtual line above first line of the file
.       | Line where the cursor is placed
'm      | Line containing mark m
'<      | Start of visual selection
'>      | End of visual selection
%       | The entire file (shorthand for: 1,$)
---------------------------------------------------------------------------------------
:1                          | Go to first line
:3d                         | Jump to the 3rd line and deleted (3gg,dd)
:2,5p                       | Print range of line from 2 to 5
:.,5y                       | Yank from the current line to the line 5
:%p                         | Print all file
:/<html>/,/</html>/p        | Specify Range of Lines by Patterns
:w | !python %              | Save file and run it with python

:tabedit %:                 | Edit of files in current buffer
:set path+=./**             | specify a set of dirs which vim will search when :find is invoked
:find fileName              | find file and switch to edit.
:!mkdir %:h                 | create dirs containing the current files.
:tabedit %:h                | take header of the current file
:h ::h                      | for more information about modifiers very useful
:w !sudo tee % > /dev/null  | save as superuser
:set list|nolist     | enable or disable line ending character."
    #
    pause
    #
    echo -e "
$Bold[+] Duplicate or Move Lines$colorOff

:6copy.   | Make a copy of line 6 and put it below the current line
:6t.      | :t is a synonym for :copy (has the same effects as :6copy.)
:t6       | Copy current line to just below line 6.
:t.       | Duplicate the current line.
:t$       | Copy the current line to the end of file.
:'<,'>t0  | Copy The visual selected line to the start of file
---------------------------------------------------------------------------------------
:m        | move line work exactly like :t
:6m.      | move line 6 to just below current line.
:m6       | move current line to just bellow line 6.
:'<,'>m$  | Move the selected text to the end of file

# :t and :m Work great in visual mode"
#
    pause
#
    echo -e "
$Bold[+] Run Normal Mode Commands Across a Range$colorOff

:'<,'>normal .    | Execute last command with the dot for the selection
:6,10 normal A;   | Add ; from line 6 to line 10
:%normal A;       | Add ; to the entire file.
@:                | Repeat the last command
:colorscheme<C-d> | Reveal a list of possible completions
<C-r><C-w>        | At vim cli copies the word under cursor and insert it at the cli
---------------------------------------------------------------------------------------
:set ff=unix      | Convert fileformat to unix/dos
:set ft=html      | Changing File Type
:r file           | Print fileName under cursor
:r !ls            | Print ls output under cursor
:w !bash          | use content of file as standard input for specifc {cmd}
:vs || :sp        | Open file vertical/horizontal split
ZZ                | :wq
ZQ                | :q!
zz                | Center screen on cursor.
zt                | Align top of screen with cursor
zb                | Align bottom screen with cursor.
"
}
#
#
#
bookmark(){
    clear
    echo -e "$Bold[*] Bookmark:$colorOff

| :marks    | List all the current marks
| ma        | Make a bookmark named a at the current cursor position
| \`a        | Go to position of bookmark a
| \'a        | Go to the line with bookmark a
| \`.        | Go to the line that you last edited"
}
#
#
macro(){
    clear
    echo -e "$Bold[*] Macro:$colorOff

| qa    | Start recording macro 'a'.
| q     | End recording macro.
| qA    | Appending keystokes to the existing contents of register a.
| @a    | Replay macro 'a'.
| @@    | Repeat the macro that was invoked most recently.
| @:    | Replay last command."
}
#
#
#
visualMode(){
    clear
    echo -e "$Bold[+] Visual Mode:$colorOff

 o                 | move to other end of marked area
 CTRL-v            | start visual block mode
 O                 | move to other corner of block
 aw                | mark a word
 ab                | a () block (with braces)
 ab                | a {} block (with brackets)
 ib                | inner () block
 gv                | reselct the last visual selection
 ~, U, u           | switch case
 b                 | inner {} block
 v move :w file    | Save line to file
    "
}
#
#
#
buffersTab(){
    clear
    echo -e "$Bold[*] Work With Buffers and Tab:$colorOff

:ls                   | Listing of all buffers.
:args                 | The list of files passed as an argument to vim.
:bnext                | Next Buffer.
:bprev                | Previous Buffer.
:bfirst               | First Buffer.
:blast                | Last Buffer.
:bd[elete] 1          | Delete buffer number 1 (deleting a buffer has no effect on its associated file; it simply removes the in-memory)
:5,10bd               | delete buffers numbered 5 through 10 inclusive

:tabe[dit] filename   | Open filename in a new tab.
<C-w>T                | Move the current windows into its own tab.
:tabc[lose]           | Close the current tab and all of its windows.
:tabo[nly]            | Keep the active tab page, closing all others.
:tabn[ext] {n} {n}gt  | Switch to tab page number n.
:tabn[ext]  gt        | Switch to the next tab page.
:tabp[revious] gT     | Switch to the previous tab page.
:tabm[ove] [n]        | Switch to the previous tab page (ex, 0 first tab, +1, -1).
    "
}
#
#
splitWindows(){
    clear
    echo -e "$Bold[*] work with split windows:$colorOff

:cl[ose] <c-w>c         | Close the active window
:on[ly] <c-w>o          | Keep only the active window, closing all others

<c-w>=      | Equalize width and height of all windows
<c-w>_      | Maximize height of the active window
<c-w>|      | Maximize width of the active window
[N]<c-w>_   | Set active window height to [N] rows
[N]<c-w>|   | Set active window width to [N] columns
<c-w>r      | Rotate windows. the first window becomes the second one.

    "
}
#
#

mapping(){
 c  clear
    echo -e "$Bold[*] Mapping:$colorOff

:map                 | mapping key in normal mode
:map <space> delete  | use specieal keys
:map <c-d> dd        | ctrl + alt
:nmap \ dd           | Normal mode mapping
:vmap \ U            | Visual mode mapping
:imap <c-d> dd       | insert mode mapping
:nunmap              | remove mapping
:nmap x dd           | map x to dd
:nnoremap \ x        | nonrecursive mapping means map \ to x not to x mapping
                     | each of the *map commands has a *noremap counterpart(noremap, nnoremap, vnoremap, inoremap)

:nnoremap <buffer> <leader>x dd     # mapping when we're in the bufer where we defind it

    "
}
#
#
abbrev(){
    clear
    echo -e "$Bold[*] Abbreviations:$colorOff

# Vim has a feature called 'abbreviations' that feel similar to mappings but are meant for use in insert, replace, and command modes.

:iabbrev adn and                # As soon as you hit space after typing adn vim will replace it with and
:iabbrev @@ dabve@gmail.com
:iabbrev ccopy copyright 2019 dabve band, all right reserved
    "
}
#
#
autocommand(){
    clear
    echo -e "$Bold[*] Autocommand:$colorOff

# Autocommands are a way to tell Vim to run certain commands whenever certain events happen.
:autocmd BufNewFile * :write        # write file as soon as you edit them

bufnewfile  | The event to watch for.
*           | A pattern to filter the event.
:write      | The command to run.

:autocmd BufNewFile *.html :write        # only apply to files whose names end in .html

:autocmd BufWritePre *.html :normal gg=G
# :normal gg=G : tell vim to reindent the current file.
# :BufWritePre == the event will be checked just before you write any file.

:autocmd BufWritePre,BufRead *.html :normal gg=G       # bound to multiple events separated with comma

:autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>           # filetype events
:autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>      # filetype events

:help autocmd-events    # a list of all the events

# autocommand with abbreviations
:autocmd FileType python :iabbrev <buffer> iff if:<left>
:autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
    "
}
#
#
status_line(){
    clear
    echo -e "$Bold[*] Status line:$colorOff

:set statusline=%f\ -\ FileType:\\ %y
:set statusline=%f              | Path to the file
:set statusline+=\ -\           | Separator
:set statusline+=FileType       | Label
:set statusline+=%y             | Filetype of the file
:set statusline=%l              | Current line
:set statusline+=/              | Separator
:set statusline+=%L             | total line
:set statusline=Current:\%4l\ Total:\%4L        # Current:  12 Total: 223, %4 add spaces

# Splitting
:set statusline=%f              | Path to the file
:set statusline+=%=             | Switch to the right side
:set statusline=%l              | Current line
:set statusline+=/              | Separator
:set statusline+=%L             | total line
    "
}
#
#
menu(){
    clear
    echo -e "$Bold[*] Vim Cheat Sheet:$colorOff


    1.  Moving Command.
    2.  Editing Commands and Keybinding.
    3.  Replace.
    4.  Find Word.
    5.  Yank Text.
    6.  Command Line, Duplicate and Move Lines, Run Normal Mode Commands Across a Range.
    7.  Bookmark.
    8.  Macro.
    9.  Visual Mode.
    10. Work With Buffers and Tab.
    11. Work With Split windows.
    12. Mapping with vim.
    13. Abbreviations.
    14. Autocommand.
    15. Status Line.
    0. Exit"
    echo -en "\n$Bold$Yellow[:] Choose From the Menu: $colorOff"
    read -r choice
}
# ------------------------- Main Script
#
while true; do
    menu
    case $choice in
        1)  movingCommend; pause ;;
        2)  editingCommand; pause ;;
        3)  replace; pause ;;
        4)  findWord; pause ;;
        5)  yankText; pause ;;
	    6)  cmdLine; pause ;;
	    7)  bookmark; pause ;;
	    8)  macro; pause ;;
	    9)  visualMode; pause ;;
	    10) buffersTab; pause ;;
	    11) splitWindows; pause ;;
	    12) mapping; pause ;;
	    13) abbrev; pause ;;
	    14) autocommand; pause ;;
	    15) status_line; pause ;;
        0)  echo -e "\nbye"; exit 0 ;;
        *)  echo -en "$Red[-] Wrong choice $colorOff"; pause ;;
    esac
done
