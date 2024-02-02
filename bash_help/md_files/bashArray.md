# <center>Bash Array</center>

## Declaration:

* There is no maximum limit to the size, nor any requirement that member variables be indexed or assigned contiguously.
* Array is created automatically when a variable is used in the format like:

  ```bash
  $ name[index]=value
  $ declare -a Unix=('Debian' 'Red hat' 'Red hat' 'Suse' 'Fedora');$colorOff
  ```
* To access an element from an array use curly brackets:
  
  ```bash
  ${name[index]}.
  $ Unix[0]='Debian'
  $ Unix[1]='Red hat'
  $ Unix[2]='Ubuntu'
  $ echo ${Unix[1]}
  ```
* If the elements has the white space character, enclose it with in a quotes."

## Printing Bash Array

* If the index number is `@` or `*`, all members of an array are referenced.
* You can traverse through the array elements, using looping statements in bash.

  ```bash
  $ echo ${Unix[@]}
  $ echo ${#arrayName}    	# Print the first element of the array.
  ```

## Length of an array:

* We can get the length of an array using the special parameter called $#.

  ```bash
  $ echo ${#arrayname[@]} 	# Length of the array.
  $ echo ${#arrayName}    	# Number of characters in the first element of the array.
  $ echo ${#Unix[3]}        # length of the element located at index 3.
  ```

## Extraction by offset and length for an array

* Extract 2 elements starting from the position 3 from an array called Unix.
  ```bash
  $ Unix=('Debian' 'Red hat' 'Ubuntu' 'Suse' 'Fedora' 'UTS' 'OpenLinux')
  $ echo ${Unix[@]:3:2}
  # OUTPUT: Suse Fedora

  $ echo ${Unix[2]:0:4}
  OUTPUT: Ubun
  ```

## Search and Replace and Add:

* Searches for Ubuntu and replace the same with the word 'SCO Unix'.

  ```bash
  $ Unix=('Debian' 'Red hat' 'Ubuntu' 'Suse' 'Fedora' 'UTS' 'OpenLinux')
  $ echo ${Unix[@]/Ubuntu/SCO Unix}

  # OUTPUT: Debian Red Hat Sco Unix Suse Fedora Uts OpenLinux
  ```

* Add an element to an existing Bash Array

  ```bash
  $ Unix=('Debian' 'Red hat' 'Ubuntu' 'Suse' 'Fedora' 'UTS' 'OpenLinux');
  $ Unix=("${Unix[@]}" 'Aix' 'Hp-Ux')
  $ echo ${Unix[7]}$colorOff

  # OUTPUT: Debian Red Hat Ubuntu Suse Fedora Uts OpenLinux Aix Hp-Ux
  ```

* `Unset` is used to remove an element from an array.
* `Unset` will have the same effect as assigning null to an element.

  ```bash
  $ Unix=('Debian' 'Red hat' 'Ubuntu' 'Suse' 'Fedora' 'UTS' 'OpenLinux');
  $ unset Unix[3]
  $ echo ${Unix[3]}
  # OUPUT: NULL"
  ```
    
## Remove Bash Array Elements using Patterns

* In the search condition you can give the patterns, and stores the remaining element to an another array as shown below.

  ```bash
  $ declare -a Unix=('Debian' 'Red hat' 'Ubuntu' 'Suse' 'Fedora');
  $ declare -a patter=( ${Unix[@]/Red*/} )
  $ echo ${patter[@]}

  # OUTPUT: Debian Ubuntu Suse Fedora
  ```

## Deleting an Entire Array

* `Unset` is used to delete an entire array.

  ```bash
  $ Unix=('Debian' 'Red hat' 'Ubuntu' 'Suse' 'Fedora' 'UTS' 'OpenLinux');
  unset Unix
  echo ${#Unix[@]}
  # Output: NULL
  ```
    
## Copying an Array

* Expand the array elements and store that into a new array as shown below.

  ```bash
  $ Unix=('Debian' 'Red hat' 'Ubuntu' 'Suse' 'Fedora' 'UTS' 'OpenLinux');
  $ Linux=("${Unix[@]}")
  $ echo ${Linux[@]}

  # OUTPUT: Debian Red hat Ubuntu Fedora UTS OpenLinux
  ```

### Concatenation of two Bash Arrays

* Expand the elements of the two arrays and assign it to the new array.

  ```bash
  $ Unix=('Debian' 'Red hat' 'Ubuntu' 'Suse' 'Fedora' 'UTS' 'OpenLinux');
  $ Shell=('bash' 'csh' 'jsh' 'rsh' 'ksh' 'rc' 'tcsh')
  $ UnixShell=("${Unix[@]}" "${Shell[@]}")

  $ echo ${UnixShell[@]}
  ## Out: Debian Red hat Ubuntu Suse Fedora UTS OpenLinux bash csh jsh rsh ksh rc tcsh

  $ echo ${#UnixShell[@]}
  OUTPUT: 14
  ```

## Load Content of a File into an Array

* You can load the content of the file line by line into an array.

  ```bash
  filecontent=$( cat "logfile" )
  for t in "${filecontent[@]}";do
     echo $t
  done"
  ```
