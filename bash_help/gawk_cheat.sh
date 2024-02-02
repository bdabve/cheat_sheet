#!/bin/bash
# Advanced gawk
#
# Sourcing cliColor from the lib directory
if [ -f /home/dabve/bin/lib/cliColor ]; then
    source /home/dabve/bin/lib/cliColor
fi
#
# Pause function
if [ -s /home/dabve/bin/lib/functions_lib ];then
    source /home/dabve/bin/lib/functions_lib
fi
path="/home/dabve/programming/bash/cheat_sheet/gawk"
#
gawkOption()
{
    clear
	echo -e "$Bold[+] gawk options$colorOff

	-F fs       | specifies a file separator for delineating data field in a line
	-f file     | specifies a file name to read the program from
	-v var=value| Defines a variable and default value used in the gawk program
	-mf n       | Specifies the maximum number of fields to process in the data file
	-mr n       | Specifies the maximum record size in the data file
	-W keyword  | Specifies the compatibility mode or warning level for gawk

[+] Some Example:
	$Green$ echo \"My name is dabve\" | gawk '{\$4=\"Ibrahim\"; print \$0}$colorOff # Out: My name is Ibrahim"
echo -e "\t$Green$ gawk -F: '{text=\"Home Directory for: \"; print text \$1 \" --> \" \$6}' /etc/passwd | head -n 4$colorOff"
gawk -F: '{text="Home Directory for: "; print text $1 " --> " $6}' /etc/passwd | head -n 4
#
pause
#
echo -e "\t$Green$ cat script0.gawk$colorOff"
cat "$path/script0.gawk"
echo -e "\t$Green$ cat /etc/passwd | head -n 4 | gawk -f script0.gawk $colorOff"
cat /etc/passwd | head -n4 | gawk -f "$path/script0.gawk"

}
#
usingVariable(){
	clear
	echo -e "\t$Bold[+] Built-in Variables$colorOff

[+] DATA FIELD AND RECORD VARIABLE:

| Variable      |   Description
|---------------|--------------------------------------------------------------------
| FIELDWIDTHS   | A space-separated list of numbers defining the exact width (in spaces) of each data field
| FS            | Input field separator character
| RS            | Input record separator character (newline by default)
| OFS           | Output field separator character (space by default)
| ORS           | Output record sepatator character (newline by default)

[+] Example:

$Green$ echo \"data11,data12,data13,data14\" | gawk BEGIN{FS=\",\"} {print \$1,\$2,\$3}$colorOff"
echo "data11,data12,data13,data14" | gawk 'BEGIN{FS=","} {print $1,$2,$3}'

echo -e "$Green$ echo \"data11,data12,data13,data14\" | gawk 'BEGIN{FS=\",\"; OFS=\"-\"} {print \$1,\$2,\$3}'$colorOff"
echo "data11,data12,data13,data14" | gawk 'BEGIN{FS=","; OFS="-"} {print $1,$2,$3}'

echo -e "$Green$ echo \"1005.3247596.37\" | gawk 'BEGIN{FIELDWIDTHS=\"3 5 2 5\"}{print \$1,\$2,\$3,\$4}'$colorOff"
echo "1005.3247596.37" | gawk 'BEGIN{FIELDWIDTHS="3 5 2 5"}{print $1,$2,$3,$4}'

pause
cat "$path/data2.txt"
echo -e "\n$Green$ gawk 'BEGIN{FS=\"\\\n\"; RS=\"\"}{print \$1,\$4,\"\\\n\"\$5,\$8}' data2.txt$colorOff\n"
gawk 'BEGIN{FS="\n"; RS=""}{print $1,$4,"\n"$5,$8}' data2.txt
#
pause
#
	echo -e "[+] DATA VARIABLE:

| Variable      | Description
|---------------|-------------------------------------------------------------------⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼⁼|
| ARGC          | The number of command line parameters present
| ARGIND        | The index in ARGV of the current file being processed
| ARGV          | An array of command line parameters
| CONVFMT       | The conversion format for numbers (see the printf statement), with a default value of %.6 g
| ENVIRON       | An associative array of the current shell environment variables and their values
| ERRNO         | The system error if an error occurs when reading or closing input files
| FILENAME      | The filename of the data file used for input to the gawk program
| FNR           | The current record number in the data file
| IGNORECASE    | If set to a non-zero value, ignores the case of characters in strings used in the gawk
| NF            | The total number of data fields in the data file
| NR            | The number of input records processed
| OFMT          | The output format for displaying numbers, with a default of %.6 g
| RLENGTH       | The length of the substring matched in the match function
| RSTART        | The start index of the substring matched in the match function"
#
pause
#
echo -e "$Green$ gawk 'BEGIN{print ARGC,ARGV[1]}' data1.txt$colorOff"
gawk 'BEGIN{print ARGC,ARGV[1]}' "$path/data1.txt"
echo -e "# The ARGC variable indicates that two parameters are on the command line.
# The ARGV array starts with an index of 0, which represents the command. The first array value is the first command line parameter after the gawk.\n"
echo -e "# The ENVIRON: It uses an associative array to retrieve shell environment variables.
	$Green$ gawk 'BEGIN{print ENVIRON[\"HOME\"]\"\\\n\" ENVIRON[\"PATH\"]}'$colorOff"
gawk 'BEGIN{print ENVIRON["HOME"]"\n" ENVIRON["PATH"]}'

echo -e "\n# The NF : Allows you to specify the last data field in the record without having to know its position
	$Green$ gawk 'BEGIN{FS=\":\"; OFS=\":\"} {print \$1,\$NF}' /etc/passwd$colorOff"
gawk 'BEGIN{FS=":"; OFS=":"} {print $1,$NF}' /etc/passwd | head -4
#
pause
#
echo -e "
# The FNR : Contains the number of records processed in the current data file.
	$Green$ gawk 'BEGIN{FS=\",\"}{print \$1,\"FNR=\"FNR}' data1.txt data1.txt$colorOff"
gawk 'BEGIN{FS=","}{print $1,"FNR="FNR}' "$path/data1.txt" "$path/data1.txt"
echo -e "
# The NR : Contains the total number of records processed.
	$Green $ gawk 'BEGIN{FS=\",\"}{print \$1,\"FNR=\"FNR, \"NR=\"NR} END{print \"There were\",NR,\"records processed\"}' data1.txt data1.txt$colorOff"
gawk 'BEGIN{FS=","}{print $1,"FNR="FNR, "NR="NR} END{print "There were",NR,"records processed"}' "$path/data1.txt" "$path/data1.txt"
#
pause
#
	echo -e "\t$Bold[+] User-Defined Variables$colorOff\n"
echo -e "\t$Green$ gawk 'BEGIN{testing=\"This is a test\"; print testing}'$colorOff         # Out: This is a test"
echo -e "\t$Green$ gawk 'BEGIN{testing=\"This is a test\"; print testing; testing=45; print testing}'$colorOff  # Reassign a avalue"
echo
echo -e "\t$Green$ cat script1$colorOff"
cat "$path/script1.gawk"
echo -e "\t$Green$ gawk -f script1 n=2 data1.txt$colorOff"
gawk -f "$path/script1.gawk" n=2 "$path/data1.txt"
echo
echo -e "\t$Green$ cat script2$colorOff"
cat "$path/script2.gawk"
echo
echo -e "\t$Green$ gawk -v n=3 -f script2 data1.txt$colorOff"
gawk -v n=3 -f script2.gawk "$path/data1.txt"
echo "# -v: Allows you to specify variables that are set before the BEGIN section of code, must be placed before the script code in cmd."
}
#
examples() {
    clear
    echo -e "\t$Bold[+] Examples$colorOff
# Sum integers from a file or stdin, one integer per line:
    $Green$ printf '1\\\n2\\\n3\\\n' | awk '{ sum += \$1} END {print sum}'$colorOff

# using specific character as separator to sum integers from a file or stdin
    $Green$ printf '1:2:3' | awk -F \":\" '{print \$1+\$2+\$3}'$colorOff

# print a multiplication table
    $Green$ seq 9 | sed 'H;g' | awk -v RS='' '{for(i=1;i<=NF;i++)printf(\"%dx%d=%d%s\", i, NR, i*NR, i==NR?\"\\\n\":\"\\\t\")}'$colorOff

# Specify output separator character
    $Green$ printf '1 2 3' | awk 'BEGIN {OFS=\":\"}; {print \$1,\$2,\$3}'$colorOff
    "
}

#
#
#================================
#   Main script
#================================
#
menu(){
	clear
	echo -e "$Bold[+] The gawk command$colorOff

    1. GAWK Options.
    2. Using Variable.
    3. Use Full Examples.
    0. Exit."
    echo -en "\n$Bold$Green[:] Choose From the Menu:$colorOff "
    read -rn 1 choice
}
#
while true;do
	menu
	case $choice in
		1)  gawkOption ;;
		2)  usingVariable ;;
        3)  examples ;;
		0)  echo -e "\nBye"; break;;
        *)  echo -e "\n\n[-] $Red Wrong Choice$colorOff"; pause ;;
	esac
    pause
	clear
done
