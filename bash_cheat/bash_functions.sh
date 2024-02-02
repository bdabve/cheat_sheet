#!/bin/bash
#: Title 	: function
#: Date		: 28-Feb-2016
#: Author	: Dabve
#: Descreption	: This script show how to use function
#: Option	: none
#
# Sourcing files for pause function and cliColor
if [ -s /home/dabve/bin/lib/cliColor ];then
    source /home/dabve/bin/lib/cliColor
fi
#
if [ -s /home/dabve/bin/lib/functions_lib ];then
    source /home/dabve/bin/lib/functions_lib
fi
#
path="/home/dabve/programming/bash/cheat_sheet/function/"
# Section 1
creatingFunction(){
	clear
	echo -e "$Bold[*] Creating Function:$colorOff

# There are two format to create function in bash:
$Green$ function functin_name {
    commands
}

$ function_name(){
    commands
}

$ function_name$colorOff             # Call the function

# If you attempt to use a function before it's defined, you'll get an error message.
# Each function name must be unique.
# If you redefine a function, the new definition overrides the original function definition, without producing any error messages."
}
#
# Section 2
returningValue(){
	clear
	echo -e "$Bold[+] Returning a Value:$colorOff\n
# The bash shell treats functions like mini-scripts, complete with an exit status,
# There are three different ways you can generate an exit status for your functions:
# By default, the exit status of a function is the exit status returned by the last command in the function.
# The best way for returning a function is to capture the output of a function to a shell variable.

$Bold[+] Example:$colorOff"

echo -e "$Green"
cat "$path/usingfunctionoutput.sh"
echo -e "$colorOff"
echo -e "
# Using this technique, you can also return floating point and string values, making this an extremely versatile method for returning values."
}
#
# Section 3
usingVariableinfunction(){
	clear
	echo -e "$Bold[+] Using Variable in Function:$colorOff\n
# The bash shell treats functions just like mini-scripts. you can pass parameters to a function just like a regular script
# Functions can use the standard parameter environment variables to represent any parameters passed to the function on the cli.

$Bold[+] Example:$colorOff\n"
echo -e "$Green"
cat "$path/passingParametersfunction.sh"
echo -e "$colorOff"
#
pause
#
echo -e "# If you want to use script parameters in your function, you have to manually pass them when you call the function:\n"
echo -e "$Green"
cat "$path/accesscriptparamfunction.sh"
echo -e "$colorOff"
#
pause
#
echo -e "$Bold[+] Handling Variable in a Function:$colorOff\n
${Bold}[+] Global Variable:$colorOff Global variables are variables that are valid anywhere within the shell script.\n"
echo -e "$Green"
cat "$path/globalVariabl.sh"
echo -e "$colorOff"
#
pause
#
echo -e "${Bold}[+] Local Variable:$colorOff any variables that the function uses internally can be declared as local variables."
echo -e "$Green"
cat "$path/localVariabl.sh"
echo -e "$colorOff"
}
#
# Section 4
arrayVariablesandfunctions(){
	clear
	echo -e "$Bold[+] Array Variables and Functions: $colorOff\n
# Using array variable values with functions is a little tricky, and there are some special considerations.
# You must disassemble the array variable into its individual values and use the values as function parameters. Inside the function, you can reassemble all the parameters into a new array variable.

$Bold[+] Exapmle: $colorOff"
echo -e "$Green"
cat "$path/arrayFunction.sh"
echo -e "$colorOff"
#
pause
#
echo -e "$Bold[+] Another Example:$colorOff"
echo -e "$Green"
cat "$path/addArray.sh"
echo -e "$colorOff"
echo -e "
# The addarray function iterates through the array values, adding them together.
# You can put any number of values in the myarray array variable, and the addarray function adds them."
#
pause
#
echo -e "$Bold[+] Returning arrays from functions: $colorOff
# Passing an array variable from a function back to the shell script uses a similar technique.
# The function uses an echo -e statement to output the individual array values in the proper order, and the script must reassemble them into a new array variable:
$Bold[+] Example:$colorOff"
echo -e "$Green"
cat "$path/returnArrayfromfunction.sh"
echo -e "$colorOff"
}
#
# Section 5
functionRecursion(){
	clear
	echo -e "$Bold[*] Function Recursion: $colorOff\n
# One feature that local function variables provide is self-containment. A self-contained function doesn't use any resources outside of the function, other than whatever variables the script passes to it in the command line.
# This feature enables the function to be called recursively, which means that the function calls itself to reach an answer.
# The classic example of a recursive algorithm is calculating factorials.

$Bold[+] Example:$colorOff\n"
echo -e "$Green"
cat "$path/functionRecurtion.sh"
echo -e "$colorOff"
}
#
# Section 6
creatingLibrary(){
	clear
	echo -e "$Bold[+] Creating Library: $colorOff\n
# The first step in the process is to create a common library file that contains the functions you need in your scripts.

# The next step is to include the myfuncs library file in your script files that want to use any of the functions.

# If you run the myfuncs shell script from your shell command line interface prompt, the shell creates a new shell and runs the script in that new shell. but when you try to run another script that uses those functions, they aren't available.
# The key to using function libraries is the source command. The source command executes commands within the current shell context instead of creating a new shell to execute them.

# To source the myfuncs library file in a shell script, you just need to add the following line: '. ./myfuncs'
"
}
#
# Section 7
creatingFunctionsOnCli(){
	clear
	echo -e "$Bold[*] Creating Function on Cli: $colorOff

# The first method defines the function all on one line:
$Green$ function divem { echo \$[ \$1 / \$2 ]; }$colorOff

# The other method is to use multiple lines to define the function:
$Green$ function multem {
echo \$[ \$1 * \$2 ]
}$colorOff

# You can define the functions directly in the .bashrc file in your home directory.
# you can use the source command (or the dot operator) to add functions from an existing library file to your .bashrc script."
}
#############
menu(){
	clear
	echo -e "$Bold[*] Functions$colorOff


    1. Creating Funcion
    2. Returning Value
    3. Using Variable in Function
    4. Array Variables and Functions
    5. Function Recursion
    6. Creating a Library
    7. Creating Functions On Cli
    0. Exit"
	echo -en "\n$Bold[:] Choose From The Menu: "
	read -rn 1 selection
}
#
while true; do
	menu
	case $selection in
		1)  creatingFunction;;
		2)  returningValue;;
		3)  usingVariableinfunction;;
		4)  arrayVariablesandfunctions;;
		5)  functionRecursion;;
		6)  creatingLibrary;;
		7)  creatingFunctionsOnCli;;
		0)  break;;
		*)  clear
            echo -en "$Red[-] Sorry, Wrong Selection :($colorOff"
            ;;
	esac
    pause
done
clear
