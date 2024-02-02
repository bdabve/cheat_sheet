## Wildcard And Pathname Expansion:

| Expression      | 		Matches
|-----------------|-----------------------------------------
| [abc]           | a, b, or c
| [.,;]           | Period, comma, or semicolon
| [-_]            | Dash or underscore
| [a-c]           | a, b, or c
| [a-z]           | All lowercase letters
| [!0-9]          | All non-digits
| [0-9!]          | All digits and exclamation point
| [a-zA-Z]        | All lower- and uppercase letters
| [a-zA-Z0-9-_]   | All letters, digits, underscore, dash

```bash
ls /usr*            # list all file in /usr and /usr2.
ls /usr*/[be]*      # list all file in /usr and /usr2 beginning with b and e.
ls *.[cho]          # list all file end in period(.) followed by a c, h, or o 
```

## Brace Expansion:

```bash
echo b{ed,olt,ar}s         # beds bolts bars 
mkdir -p usr/{bin,lib,work,}    # Create usr and bin,lib,work inside user

echo b{ar{d,n,k},ed}s
mkdir -p usr/{lib,bin/{usr,lib},work}      # Create user and lib,bin,work inside user and usr,lib inside bin

echo {2..5}         # 2 3 4 5
echo {2...5}        # {2...5}
echo {2..8}         # 2 3 4 5 6 7 8
echo {d..h}         # d e f g h
```

## Control Keys:

| CTRL keys       | stty name | 	Function description
| ----------------|-----------|-------------------------------------------
| CTRL-C          | intr      | Stop current command
| CTRL-D          | eof       | End of input
| CTRL-\\         | quit      | Stop current cmd if CTRL-c doesn't work
| CTRL-S          | stop      | Halt output to screen
| CTRL-Q          |   ?       | Restart output to screen
| DEL or CTRL-?   | erase     | Erase last character
| CTRL-U          | kill      | Erase entire cmd line
| CTRL-Z          | susp      | Suspend current cmd
