#!/bin/bash
#: Name	 	:
#: Date		: 23-Jan-2016
#: Author	: Dabve
#: Descreption	:
#:


# ------------------------- Decalaring Variable----------------------------------------------------
DISTROS=$( mktemp -t DISTROS.XXXXXX )
FILE1=$( mktemp -t file1.XXXXXX )
FILE2=$( mktemp -t file2.XXXXXX )

echo 'SUSE 	10.2 	12/07/2006
Fedora 	10 	11/25/2008
SUSE 	11.0 	06/19/2008
Ubuntu 	8.04 	11/08/2007
SUSE 	10.3 	04/24/2008
Ubuntu 	6.10 	10/26/2006
Fedora 	7 	05/31/2007
Ubuntu 	7.10 	10/18/2007
SUSE 	10.1 	05/11/2006
Fedora 	5 	03/20/2006' > "$DISTROS"

echo -e "1 dabve 1986\n2 firoud 1991\n 3 kandja 1989" > "$FILE1"
echo -e "1 bouismail\n2 kolea\n 3 ziralda" > "$FILE2"

# ====================================
#      => FUNCTION
# ====================================
function pause
{
	echo -en "\nPress ENTER to continue"; read -rn 1; clear
}

#------------------------------------------------ wc command ---------------------------------------------------
wcCommand()
{
	varwc=$( wc $0 )
	echo -e "\e[1;4m\t2) The WC command:\e[0m\n
wc - print newline, word, and byte counts for each file\n"
	echo -e "\e[0;32m\twc $0\e[0m"
	echo $varwc
	echo $varwc | gawk '{print "number of line: " $1}'
	echo $varwc | gawk '{print "number of words: " $2}'
	echo $varwc | gawk '{print "number of octet: " $3}'
	echo -e "\e[0;32m\twc -l == compter le nombre de lignes.
		wc -c == compter le nombre d'octets
		wc -m == compter le nombre de caracteres\e[0m"
}
##
#-------------------------------------------- uniq command ------------------------------------------------------
uniqCommand()
{
	echo -e "\t\e[1;4m3) The UNIQ command:\e[0m\n
uniq - report or omit repeated lines			\e[0;32muniq File\e[0m"
	echo -e "compter le nombre d'occurance				\e[0;32muniq -c file \e[0m"
	echo -e "afficher uniquement les lignes presentes en double	\e[0;32muniq -d file \e[0m"
}
##

# ------------------------------------------- cut command -------------------------------------------------------
cutCommand()
{
	tmpFileC=$( mktemp -t cutOut.XXXXXX )

	echo 'Orange
Apple
Banana
Lemon
marshmellow
kitkat ' > $tmpFileC
##
	echo -e "\t\e[1;4m4) CUT Command:\e[0m\n"
	echo -e "\e[0;32mOur example:\e[0m "
	cat "$tmpFileC"
	printf "\ncouper selon le nombre de caracteres: \n"
	echo -e "\e[0;32m\tcut -c 2-5 $tmpFileC\e[0m"
	cut -c 2-5 "$tmpFileC"
	printf "\n"
##
	pause
	printf "du le premier caracter au 3eme: \n"
	echo -e "\e[0;32m\tcut -c -3 $tmpFileC\e[0m"
	cut -c -3 "$tmpFileC"
##
	printf "\ndu 3eme au dernier: \n"
	echo -e "\e[0;32m\tcut -c 3- $tmpFileC\e[0m"
	cut -c 3- "$tmpFileC"
##couper selon un delimiteur
	pause
	echo -e "\e[0;32m\tOur example:\e[0m "
	cat "$DISTROS"
	printf "\nLes noms du fichier cut-not.csv: \n"
	echo -e "\e[0;32m\tcut -f 1 $DISTROS\e[0m"
	cut -f 1 "$DISTROS"
	pause
##
	echo -e "# Option -d : indique le delimiteur
# Option -f : indiqua le champ a conserver"
	printf "Date of distros: \n"
	echo -e "\e[0;32m\tcut -f 3 $DISTROS\e[0m"
	cut -f 3 "$DISTROS"
##
	printf "\nAvoire le champ 1 et 3: \n"
	echo -e "\e[0;32m\tcut -f 1,3 $DISTROS\e[0m"
	cut -f 1,3 "$DISTROS"
	pause

	printf "
# On peut conserver une serie de champ
# Exemple: cut -d , -f 1-3 cut-not.csv  	# A pour effer de conserver les champs n°: 1 et 2 et 3 \n
\e[0;32mcut -d ':' -f 1 /etc/passwd | head \e[0m\n"
	cut -d ':' -f 1 /etc/passwd | head
}

# -------------------------------------------------- paste command -------------------------------------------------
pasteCommand()
{
	echo -e "\t\e[1;4m5) PASTE Command:\e[0m\n
# The past command does the opposite of CUT command. Rather than extracting a column of text from a file, it adds onr or more columns
Synops:
	\e[0;32mpaste file file1\e[0m
Example:
	\e[0;32mcut -f 1,2 $DISTROS > /tmp/distros-version.txt
	cut -f 3 $DISTROS > /tmp/distros-dates.txt
	paste distros-dates.txt distros-version.txt\e[0m"
	cut -f 1,2 "$DISTROS" > /tmp/distros-version.txt && cut -f 3 "$DISTROS" > /tmp/distros-dates.txt && paste /tmp/distros-dates.txt /tmp/distros-version.txt
}
##

#-------------------------------------------------- join command -----------------------------------------------------
joinCommand()
{
echo -e "\t\e[1;4m6) The JOIN Command:\e[0m
# In some ways, JOIN is like PASTE in that it adds columns to a file. It joins data from multiple files based on a shared key field.
Synops:
	\e[0;32mjoin file1 file2\e[0m

Example:
	\e[0;32mcat $FILE2
	cat $FILE1
	join $FILE1 $FILE2"
cat "$FILE1"
cat "$FILE2"
join "$FILE1" "$FILE2"
}
# ------------------------------------------------ comm command ------------------------------------------------------
commCommand()
{
echo -e "\t\e[1;4m7) The COMM Command:\e[0m

# The comm program compares two text files and displays the lines that are uniques to each one and the lines they have in common.
Synops:
	\e[0;32mcomm file1 file2\e[0m

Example:
	\e[0;32mecho -e \"a\\\nb\\\nc\" > $FILE1
	echo -e \"b\\\nc\\\nd\" > $FILE2
	comm $FILE1 $FILE2\e[0m"
echo -e "a\nb\nc" > "$FILE1"
echo -e "b\nc\nd" > "$FILE2"
comm "$FILE1" "$FILE2"
echo -e "\n# COMM produces three columns of output.
The first contains lines unique to the first file argument.
The second contains lines unique to the second file argument.
The third contains the lines sharedd by both files

# COMM supports options to specify which column(s) to suppress in the form of: comm -12 (suppress 1 and 2 from output)
	\e[0;32mcomm -12 $FILE1 $FILE2\e[0m"
comm -12 "$FILE1" "$FILE2"
}
#----------------------------------------------- diff command -----------------------------------------------------
diffCommand()
{
echo -e "\t\e[1;4m8) The DIFF Command:\e[0m

# Like the COMM program, DIFF is used to detect the defferences between files.
Example:
	\e[0;32mdiff $FILE1 $FILE2\e[0m"
diff "$FILE1" "$FILE2"
echo -e "\e[4mdiff change commands:\e[0m
r1ar2	Append the lines at the position r2 in the second file to the position r1 in the first file.
r1cr2	change (replace) the lines at position r1 with the lines at the position r2 in the second file.
r1dr2	Delete the lines in the the first file at position r1, which would have appeard at range r2 in the second file."

pause

echo -e "\t\e[0;32mdiff -c $FILE1 $FILE2\e[0m"
diff -c "$FILE1" "$FILE2"
echo -e "# The -c option: context format
-------------------------------------------------------------------------------------------------------------------------------------
blank	| A line shown for context. it does not indicate a difference between the two file.
-	| A line deleted. This line will appear in the first file but not in the second file.
+	| A line added. This line will appear in the second file but not in the first file.
!	| A line changed. the two version of the line will be displayed, each in its respective section if the change groupe.
--------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\t\e[0;32mdiff -u $FILE1 $FILE2\e[0m"
diff -u "$FILE1" "$FILE2"
echo -e "# The -u option: Unified format"
}

#----------------------------------------------- PATCH command -----------------------------------------------------
patchCommand()
{
echo -e "\t\e[1;4m9) The PATCH Command:\e[0m

# The patch program is used to apply changes to text files. It accepts output from diff and is generally used to convert older version of files into newer versions.
# To prepare a diff file for use with patch, the GNU documentation suggests using diff as follows:
	\e[0;32mdiff -Naur old_file new_file > diff_file\e[0m
# Where old_file and new_file are either single files or directories containing files. The -r option supports recursion of a directory tree.
Once the diff file has been created, we can apply it to patch the old file into the new file:
	\e[0;32mpatch < diff_file\e[0m
# We’ll demonstrate with our test file:

	\e[0;32mdiff -Naur $FILE1 $FILE2 > /tmp/patchfile.txt
	patch < /tmp/patchfile.txt\e[0m"
echo -e "a\nb\nc" > "$FILE1"
echo -e "b\nc\nd" > "$FILE2"
diff -Naur "$FILE1" "$FILE2" > /tmp/patchfile.txt
cd "/tmp"
echo -e "\e[0;32mcat $FILE1\e[0m";cat "$FILE1;echo" -e "\e[0;32mcat $FILE2\e[0m";cat "$FILE2"
patch < patchfile.txt
echo
echo -e "\t\e[0;32mcat file1.txt\e[0m"
cat "$FILE1"

}

#----------------------------------------------- TR command -----------------------------------------------------
trCommand()
{
echo -e "\t\e[1;4m10) The TR Command:\e[0m

# The tr program is used to transliterate character.Transliteration is the process of changing characters from one alphabet to another.

Example:
	\e[0;32mecho \"lowercase letters\" | tr a-z A-Z\e[0m"
echo "lowercase letters" | tr a-z A-Z
echo -e "\n\t\e[0;32mtr -d '\\\r' < dos_file > unix_file\e[0m
# Converting MS-DOS text file to UNIX-STYLE text file."
echo -e "\n\t\e[0;32mecho \"secret text\" | tr a-zA-Z n-za-mN-ZA-M\e[0m"
echo "secret text" | tr a-zA-Z n-za-mN-ZA-M
echo -e "\n\t\e[0;32mecho \"frperg grkg\" | tr a-zA-Z n-za-mN-ZA-M\e[0m"
echo "frperg grkg" | tr a-zA-Z n-za-mN-ZA-M
echo -e "\n\t\e[0;32mecho \"aaabbbccc\" | tr -s ab\e[0m"
echo "aaabbbccc" | tr -s ab

}

#----------------------------------------------- ASPELL command -----------------------------------------------------
aspellCommand()
{
echo -e "\t\e[1;4m11) The ASPELL Command:\e[0m

# The aspell program can be used to intelligently check various type of text file: HTML; C/C++ and others."
echo "The quick brown fox jimped over the laxy dog." > /tmp/Easpell.txt
echo -e "\t\e[0;32maspell check /tmp/Easpell.txt\e[0m"
aspell check /tmp/Easpell.txt
echo -e "\n# To use it with HTML:
	\e[0;32maspell -H check file.html\e[0m"
}
#------------------------------------------------ Menu ----------------------------------------------------------------
menu()
{
	clear
	echo -e "\e[1;4mText Proccessing Menu:\e[0m\n\n
	1.  SORT Command.
	2.  WC Command.
	3.  UNIQ Command.
	4.  CUT Command.
	5.  PASTE Command.
	6.  JOIN Command.
	7.  COMM Command.
	8.  DIFF Command.
	9.  PATCH Command.
	10. TR Command.
	11. ASPELL Command.
	0.  Exit."
	printf "\n\nChoose From The Menu: "; read -rn 2 choice
}
#------------------------------------------- Main Script -----------------------------------------
while true;do
	menu
	case $choice in
		1) clear; sortCommand;;
		2) clear; wcCommand;;
		3) clear; uniqCommand;;
		4) clear; cutCommand;;
		5) clear; pasteCommand;;
		6) clear; joinCommand;;
		7) clear; commCommand;;
		8) clear; diffCommand;;
		9) clear; patchCommand;;
		10) clear; trCommand;;
		11) clear; aspellCommand;;
		0) break;;
		*) clear; printf "\n\n\nSorry Wrong Choice. ";;
	esac
	pause
done
clear
rm "$tmpFileC" ${DISTROS}* /tmp/file* /tmp/cutNote.* /tmp/Easpell.txt 2>/dev/null

exit 0
