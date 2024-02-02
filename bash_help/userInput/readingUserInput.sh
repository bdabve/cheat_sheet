#!/bin/bash
#: Title 	: 
#: Date		: 24-Feb-2016
#: Author	: Dabve
#: Descreption	:
#: Option	:

clear
echo -e "\e[1;4mReading basics:\e[0m

	\e[0;32mread -p \"Please enter your age:\" age 			# -p == prompt.
	read -p \"Enter your name: \" first last 			# entering multiple variable.
	read -p \"Enter your name: \" 				# read places any data in the special environment variable \$REPLY.
	read -t 5 -p \"Please enter your name: \" name 		# -t == timing in second.
	read -n1 -p \"Do you want to continue [Y/N]?\" answer 	# -n1 == getting one character of input.
	read -s -p \"Enter your passwd\" passwd 			# -s == hiding input data from monitor.\e[0m
	
	
\e[1;4mReading from a file:\e[0m

• The tricky part is getting the data from the file to the read command. The most common method is to pipe the result of the cat command of the file directly to a while command that contains the read command. 
	# Here's an example:	
	\e[0;32mcount=1
	cat test | while read line;do
		echo \"Line $count: $line\"
		count=$[ $count + 1]
	done
	echo \"Finished processing the file\"\e[0m"
