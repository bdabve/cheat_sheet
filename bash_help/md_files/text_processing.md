## Table of content
* [SORT command](#sort)
* [WC command](#wc)
* [UNIQ command](#uniq)
* [CUT Command](#cut)
* [PAST command](#past)
* [JOIN](#join)
* [COMM](#comm)
* [DIFF](#diff)
* [PATCH command](#patch)
* [TR Command](#tr)
* [ASPELL Command](#aspell)

<a name="sort">

## <center>Sort Command</center>
* Trier on ordre inverse: **_sort -r file_**
* Trie aleatoirement: **_sort -R file_**	
* Ecrire le resultat dans un fichier: **_sort -o file file-out_**
* Trier des nombre: **_sort -n file_**
* Examples: 

  ```bash
  # Use SORT to sort ls -l by file size with the -k option:
  $ ls -l /home/dabve | sort -nr -k 5
    
  $ sort -k 1,1 -k 2n "$DISTROS"                    # 2n: field 2 and n for numerical
	$ sort -k 3.7nbr -k 3.1nbr -k 3.4nbr $DISTROS     # sort the 3rd fields wich means the date field
  # b: -ignore-leading-blanks 
  # r: reverse the result of comparisons 
  # for more options see the man page 
  ```

<a name="wc"/>

## <center>The wc Command </center>

* wc : print newline, word, and byte counts for each file
```bash
$ wc file_name
$ wc file_name | gawk '{print "number of line: " $1}'
$ wc file_name | gawk '{print "number of words: " $2}'
$ wc file_name | gawk '{print "number of octet: " $3}'
$ wc -l == compter le nombre de lignes.
$ wc -c == compter le nombre d'octets
$ wc -m == compter le nombre de caracteres
```

<a name="uniq"/>

## <center>The UNIQ command:</center>

* uniq - report or omit repeated lines: **_uniq file_**
* Compter le nombre d'occurance	: **_uniq -c file_**
* Afficher uniquement les lignes presentes en double:	**_uniq -d file_**

<a name="uniq"/>

## <center>The CUT Command:</center>

```bash
$ cut -c 2-5 File           # Couper selon le nombre de caracteres:
$ cut -c -3 File            # Du le premier caracter au 3eme
$ cut -c 3- File            # Du 3eme au dernier
```

* Couper selon un delimiteur

  ```bash
  $ cut -f 1 file                 # First field
  $ cut -f 3 file                 # 3rd field
  $ cut -f 1,3 file               # Avoire le champ 1 et 3
  $ cut -d , -f 1-3 cut-not.csv  	# A pour effer de conserver les champs n°: 1 et 2 et 3 
  $ cut -d ':' -f 1 /etc/passwd | head 

  # Option -f : indiqua le champ a conserver
  # Option -d : indique le delimiteur
  ```

<a name="past"/>

## <center>PASTE Command: </center>

* The past command does the opposite of **_CUT_** command. 
* Rather than extracting a column of text from a file, it adds onr or more columns

  ```bash
  $ cut -f 1,2 $DISTROS > /tmp/distros-version.txt
  $ cut -f 3 $DISTROS > /tmp/distros-dates.txt
  $ paste distros-dates.txt distros-version.txt
  ```

<a name="join"/>

## <center>The JOIN Command:</center>

* In some ways, JOIN is like PASTE in that it adds columns to a file. It joins data from multiple files based on a shared key field.

  ```bash
  $ join $FILE1 $FILE2
  ```

<a name="comm"/>

## <center>The COMM Command:</center>

* The comm program compares two text files and displays the lines that are uniques to each one and the lines they have in common.

```bash
$ comm FILE1 FILE2
# COMM produces three columns of output.
# The first contains lines unique to the first file argument.
# The second contains lines unique to the second file argument.
# The third contains the lines sharedd by both files

# COMM supports options to specify which column(s) to suppress in the form of: comm -12 (suppress 1 and 2 from output)
comm -12 FILE1 FILE2
```

<a name="diff"/>

## <center>The DIFF Command:</center>

* Like the COMM program, DIFF is used to detect the defferences between files.
  ```bash
  $ diff FILE1 FILE2
  # r1ar2	Append the lines at the position r2 in the second file to the position r1 in the first file.
  # r1cr2	change (replace) the lines at position r1 with the lines at the position r2 in the second file.
  # r1dr2	Delete the lines in the the first file at position r1, which would have appeard at range r2 in the second file."

  $ diff -c $FILE1 $FILE2
  # The -c option: context format
  -------------------------------------------------------------------------------------------------------------------------------------
  blank	| A line shown for context. it does not indicate a difference between the two file.
  -	    | A line deleted. This line will appear in the first file but not in the second file.
  +	    | A line added. This line will appear in the second file but not in the first file.
  !	    | A line changed. the two version of the line will be displayed, each in its respective section if the change groupe.
  --------------------------------------------------------------------------------------------------------------------------------------

  $ diff -u $FILE1 $FILE2
  # The -u option: Unified format
  ```

<a name="patch"/>

## <center>The PATCH Command: </center>

* The patch program is used to apply changes to text files. It accepts output from diff and is generally used to convert older version of files into newer versions.
* To prepare a diff file for use with patch, the GNU documentation suggests using diff as follows:

  ```bash
  $ diff -Naur old_file new_file > diff_file
  ```

* Where old_file and new_file are either single files or directories containing files. 
* The -r option supports recursion of a directory tree.
* Once the diff file has been created, we can apply it to patch the old file into the new file:

  ```bash
	$ patch < diff_file
  ```
<a name="tr"/>

## <center>The TR Command:</center>

* The tr program is used to transliterate character.Transliteration is the process of changing characters from one alphabet to another.

  ```bash
  $ echo "lowercase letters" | tr a-z A-Z
  $ tr -d '\r' < dos_file > unix_file  # Converting MS-DOS text file to UNIX-STYLE text file.
  $ echo "secret text" | tr a-zA-Z n-za-mN-ZA-M
  $ echo "secret text" | tr a-zA-Z n-za-mN-ZA-M
  $ echo "frperg grkg" | tr a-zA-Z n-za-mN-ZA-M
  $ echo "aaabbbccc" | tr -s ab
  ```

<a name="aspell"/>

## <center>The ASPELL Command </center>

* The aspell program can be used to intelligently check various type of text file: HTML; C/C++ and others.
```bash
$ aspell check file
$ aspell -H check file.html  # To use it with HTML
```
