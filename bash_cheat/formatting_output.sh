#!/bin/bash -
#=========================================================================
#
#          FILE: formattingOutput.sh
#         USAGE: ./formattingOutput.sh
#   DESCRIPTION: This script look at some of the simple formatting tools.
#        AUTHOR: daBve (), dabve@outlook.fr
#       CREATED: 05/05/2016
#==========================================================================

# ---------------------------------------------- Variable and Function ----------------------------------------------

PATH_CONF="/home/dabve/bin/configFile"
# Declaring Pause Function
pause()
{
	printf "\nHit Any <KEY> to continue "; read -n 1; clear
	}
#

DISTROS=$( mktemp -t distros.XXXXXX )
echo "SUSE	 10.2 	12/07/2006
Fedora 	 10 	11/25/2008
SUSE	 11.0 	06/19/2008
Ubuntu	 8.04 	04/24/2008
Fedora 	 8 	11/08/2007
SUSE 	 10.3 	10/04/2007
Ubuntu	 6.10 	10/26/2006" > "$DISTROS"

# ----------------------------------- NL Command --------------------------------------------

nlCommand()
{
	echo -e "\t\e[1;4m1) The NL Command:\e[0m\n
# The NL program is a rather arcane tool used to perform a simple task. It numbers lines. it resembles cat -n:

	Our Example:"
cat "$DISTROS"
echo -e "\n\t\e[0;32mnl $DISTROS\e[0m"
nl "$DISTROS"
#
pause
#
echo -e "\t\e[1;4mnl Markup\e[0m
Markup		| 	Meaning
================================================
\:\:\:		| Start of logical page body
\:\:		| Start of logical page footer
\: 		| Start of logical page header

\t\e[1;4mCommon nl Options\e[0m
Option		|	Meaning
================================================================================================
-b style 	| Set body numbering to style, where style is one of the following:
		| a = number all lines
		| t = number only non-blank lines. This is the default.
		| n = none
		| pregexp = number only lines matching basic regular expression regexp.
-f style 	| Set footer numbering to style. Default is n (none).
-h style 	| Set header numbering to style. Default is n (none).
-i		| number Set page numbering increment to number. Default is one.
-n 		| format Sets numbering format to format, where format is:
		| ln = left justified, without leading zeros.
		| rn = right justified, without leading zeros. This is the default.
		| rz = right justified, with leading zeros.
-p 		| Do not reset page numbering at the beginning of each logical page.
-s 		| string Add string to the end of each line number to create a separator.
		| Default is a single tab character.
-v		| number Set first line number of each logical page to number. Default is one.
-w		| width Set width of the line number field to width. Default is 6."

pause

echo -e "# Our Sed Script with Nl\n"
cat /home/dabve/bin/configFile/distrosNl.sed
echo -e "\e[0;32msort -k 1,1 -k 2n $DISTROS | sed -f $PATH_CONF/distrosNl.sed | nl\e[0m"
sort -k 1,1 -k 2n $DISTROS | sed -f $PATH_CONF/distrosNl.sed | nl
}

# ----------------------------------- FOLD Command --------------------------------------------

foldCommand()
{
	echo -e "\t\e[1;4m2) The FOLD Command:\e[0m\n
# Folding id the process of breaking lines of text at a specified width, fold accepts either one or more text files or standard input.

# Example:
	\e[0;32mecho \"The quick brown fox jumped over the lazy dog\" | fold -w 13\e[0m"
echo "The quick brown fox jumped over the lazy dog" | fold -w 13
echo -e "\t\e[0;32mecho \"The quick brown fox jumped over the lazy dog\" | fold -w 13 -s\e[0m"
echo "The quick brown fox jumped over the lazy dog" | fold -w 13 -s
echo -e "# The -s option will cause fold to break the line at the last available space before the line width is reached."
}

# ----------------------------------- FMT Command --------------------------------------------

fmtCommand()
{
	FMT_FILE=$( mktemp -t fmt_file.XXXXXX )
	echo "'fmt' reads from the specified FILE arguments (or standard input
if none are given), and writes to standard output.
	By default, blank lines, spaces between words, and indentation are
preserved in the output; successive input lines with different
indentation are not joined; tabs are expanded on input and introduced
on output." > $FMT_FILE
echo -e "\t\e[1;4m3) The FMT Command:\e[0m\n

# The fmt program also folds text, plus a lot more. It accepts either files or standard input and performs paragraph formating on stream.

\t\e[1;4mCommon fmt Options\e[0m
   Option	|	Meaning
======================================================================================================================
  -c	 	| Operate in crown margin mode. This preserves the indentation of the first two lines of a paragraph.
		| Subsequent lines are aligned with the indentation of the second line.
  -p string 	| Only format those lines beginning with the prefix string.
		| After formatting, the contents of string are prefixed to each reformatted line.
		| This option can be used to format text in source code comments.
  -s 		| Split-only mode. In this mode, lines will only be split to fit the specified column width.
		| Short lines will not be joined to fill lines.
		| This mode is useful when formatting text such as code where joining is not desired.
  -u		| Perform uniform spacing. This will apply traditional “typewriter-style” formatting to the text.
		| This means a single space between words and two spaces between sentences. This mode is useful for removing “justification,”
		| that is, text that has been padded with spaces to force alignment on both the left and right margins.
  -w width	| Format text to fit within a column width characters wide. The default is 75 characters.
		| Note: fmt actually formats lines slightly shorter than the specified width to allow for line balancing."

pause

echo -e "
	\e[1;4mOur Example:\e[0m"
cat $FMT_FILE
echo -e "\t\e[0;32mfmt -w 50 $FMT_FILE\e[0m"
fmt -w 50 $FMT_FILE
echo -e "\t\e[0;32mfmt -cw 50 $FMT_FILE\e[0m"
fmt -cw 50 $FMT_FILE
pause
echo "# This file contains code with comments.

# This line is a comment.
# Followed by another comment line.
# And another.

This, on the other hand, is a line of code.
And another line of code.
And another." > $FMT_FILE
echo -e "\t\e[1;4mOur Example:\e[0m"
cat $FMT_FILE
echo -e "\t\e[0;32mfmt -w 50 -p '# ' $FMT_FILE\e[0m"
fmt -w 50 -p '# ' $FMT_FILE
}

# ----------------------------------- PR Command --------------------------------------------

prCommand()
{
	echo -e "\t\e[1;4m4) The PR Command:\e[0m\n

# The pr program is used to paginate text. When printing text, it is often desirable to sparate pages of output with several lines of whitspace.
	\e[1;4mOur Example:\e[0m"
cat $DISTROS
echo -e "\t\e[0;32mpr -l 15 -w 65 $DISTROS\e[0m"
pr -l 15 -w 65 $DISTROS
echo -e "# -l option: for page length
# -w option: for page width."
}

# ----------------------------------- GROFF Command --------------------------------------------

groffCommand()
{
	echo -e "\t\e[1;4m6) The GROFF Command:\e[0m\n
# groff is a suite of programs containing the GNU implementation of troff.
# It also in cludes a script that is used to emulate nroff and the rest of the roff family as well.

# Example:
	\e[0;32mzcat /usr/share/man/man1/ls.1.gz | groff -mandoc -T ascii | head\e[0m"
zcat /usr/share/man/man1/ls.1.gz | groff -mandoc -T ascii | head
echo -e "\e[0;32mzcat /usr/share/man/man1/ls.1.gz | groff -mandoc > ~/desktop/man-ls.ps\e[0m"
zcat /usr/share/man/man1/ls.1.gz | groff -mandoc > ~/desktop/man-ls.ps
echo -e "# NOTE: Linux systems often include many comman line program for file format conversion. They are named: \e[0;32mformat2format\e[0m"

pause

echo -e "\t\e[1;4mOur sed example for Linux distros:\e[0m"
cat /home/dabve/bin/configFile/distros-groff.sed
echo -e "\t\e[0;32msort -k 1,1 -k 2n $DISTROS | sed -f /home/dabve/bin/configFile/distros-groff.sed | groff -t -T ascii 2>/dev/null\e[0m"
sort -k 1,1 -k 2n $DISTROS | sed -f /home/dabve/bin/configFile/distros-groff.sed | groff -t -T ascii 2>/dev/null
echo -e "\t\e[0;32msort -k 1,1 -k 2n $DISTROS | sed -f /home/dabve/bin/configFile/distros-groff.sed | groff -t > ~/desktop/man-ls1.ps\e[0m"
sort -k 1,1 -k 2n $DISTROS | sed -f /home/dabve/bin/configFile/distros-groff.sed | groff -t > ~/desktop/man-ls1.ps
}

#------------------------------------------------ Menu ----------------------------------------------------------------
menu()
{
	clear
	echo -e "\e[1;4mFormatting Output MENU:\e[0m\n\n
	1.  NL Command.
	2.  FOLD Command.
	3.  FMT Command.
	4.  PR Command.
	6.  GROFF Command.
	0.  Exit."
	printf "\n\nChoose From The Menu: "; read -n 1 choice
}
#------------------------------------------- Main Script -----------------------------------------
while true;do
	menu
	case $choice in
		1) clear; nlCommand;;
		2) clear; foldCommand;;
		3) clear; fmtCommand;;
		4) clear; prCommand;;
		6) clear; groffCommand;;
		0) break;;
		*) clear; printf "\n\n\nSorry Wrong Choice. ";;
	esac
	pause
done
clear
rm $DISTROS $FMT_FILE ~/desktop/man-ls* 2>/dev/null
