## Prompt String Customizations

* Bash uses four prompt strings. They are stored in the variables 
    * PS1 : The first of these is called the primary prompt string
    * PS2 : It is used when you type an incomplete line and hit RETURN, as an indication that you must finish your command.
    * PS3 and PS4 relate to shell programming and debugging.
    
| Char      | Description
|-----------| -------------------------------------------------------
| \a        | The ASCII bell character (007)
| \A        | The current time in 24-hour HH:MM format
| \d        | The date in 'Weekday Month Day'format
| \D        | {format} The format is passed to strftime(3) and the result is inserted
| \e        | The ASCII escape character (033)
| \H        | The hostname
| \h        | The hostname up to the first '.'
| \j        | The number of jobs currently managed by the shell
| \l        | The basename of the shell's terminal device name
| \n        | A carriage return and line feed
| \r        | A carriage return
| \s        | The name of the shell
| \T        | The current time in 12-hour HH:MM:SS format
| \t        | The current time in HH:MM:SS format
| \@        | The current time in 12-hour a.m./p.m. format
| \u        | The username of the current user
| \v        | The version of bash (e.g., 2.00)
| \V        | The release of bash; the version and patchlevel (e.g., 2.00.0)
| \w        | The current working directory
| \W        | The basename of the current working directory
| \#        | The command number of the current command
| \!        | The history command
| \$        | If the effective UID is 0, print a #,otherwise print a $
| \nn      | Character code in octal
| \         | Print a backslash
| \[        | Begin a characters, sequences sequence such as of non-printing terminal control
| \]        | End a sequence of non-printing characters


