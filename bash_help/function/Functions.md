# <center>Functions</center>

## Creating Function:

* There are two format to create function in bash:

  ```bash
  function name {
      commands
  }

  $ name(){
      commands
  }
  ```


* If you attempt to use a function before it's defined, you'll get an error message.
* Each function name must be unique.
* If you redefine a function, the new definition overrides the original function definition, without producing any error messages.
### Creating Function on Cli: 

* The first method defines the function all on one line: `$ function divem { echo $[ $1 / $2 ]; }`
* The other method is to use multiple lines to define the function:
  ```bash
  $ function multem {
  > echo \$[ \$1 * \$2 ]
  > }
  ```
* You can define the functions directly in the .bashrc file in your home directory.
* you can use the source command (or the dot operator) to add functions from an existing library file to your .bashrc script."


## Returning a Value:

  ```bash
  dbl(){
      read -p "Enter a value: " value
      echo $[ $value * 2 ]
  }
  result=$(dbl)
  echo "The new value is $result"
  ```

##  Using Variable in Function:
* The bash shell treats functions just like mini-scripts. you can pass parameters to a function just like a regular script 
* Functions can use the standard parameter environment variables to represent any parameters passed to the function on the cli.

```bash
addem(){
	if [ $# -eq 0 ] || [ $# -gt 2 ];then
		echo -1
	elif [ $# -eq 1 ];then
		echo $[ $1 + $1 ]
	else
		echo $[ $1 + $2 ]
	fi
}
echo -n "Adding 10 and 15: "; value=$( addem 10 15 ); echo $value
echo -n "Let's try adding just one number: "; value=$( addem 10 ); echo $value
echo -n "Now trying adding no numbers: "; value=$( addem ); echo $value
echo -n "Finally, try adding three numbers: "; value=$( addem 10 15 20 ); echo $value
```

* If you want to use script parameters in your function, you have to manually pass them when you call the function:

  ```bash
  # Trying to access script parameters inside a function

  bdl(){
      echo $[ $1 * $2 ]
  }
  if [ $# -eq 2 ]
  then
      value=$(bdl $1 $2)
      echo "The result is $value"
  else
      echo "Usage: $(basename $0) a b"
  fi
  ```

## Handling Variable in a Function:

* Function use two types of variables:
    * `Global` Variable: Are variables that are valid anywhere within the shell script.

      ```bash
      # using a global variable to pass a value
      function dbl {
      value=$[ $value * 2 ]
      }
      read -p "Enter a value: " value
      dbl
      echo "The new value is: $value"
      ```

  * `Local` Variable: any variables that the function uses internally can be declared as local variables. 
  * To do that, just use the local keyword in front of the variable declaration: `local variableName`

    ```bash
    # demonstrating the local keyword
    function func1 {
    local temp=$[ $value + 5 ]
    result=$[ $temp * 2 ]
    }
    temp=4
    value=6
    func1
    echo "The result is $result"
    if [ $temp -gt $value ]
    then
        echo "temp is larger"
    else
        echo "temp is smaller"
    fi
    ```


## Array Variables and Functions: 

* Using `array` variable values with functions is a little tricky, and there are some special considerations.
* You must disassemble the `array` variable into its individual values and use the values as function parameters.
* Inside the function, you can reassemble all the parameters into a new array variable.
	
  ```bash
  # Array variable to function

  arrayVariable(){
      local newArray
      newArray=$(echo "$@")
      echo "The new array value is: ${newArray[*]}"
  }
  mayArray=(1 2 3 4 5)
  echo "The original array is ${mayArray[*]}"
  arrayVariable ${mayArray[*]}
  ```

  ```bash
  # Adding value in an array
  addArray(){
      local sum=0
      local newArray
      newArray=($(echo "$@"))
      for value in ${newArray[*]};do
          sum=$[ $sum + $value ]
      done
      echo $sum
  }
  mayArray=(1 6 4 8 5)
  echo "The original array is: ${mayArray[*]}"
  result=$(addArray ${mayArray[*]})
  echo "The result is: $result"
  echo "......Done......"
  ```

* The addarray function iterates through the array values, adding them together. 
* You can put any number of values in the myarray array variable, and the addarray function adds them.

###  Returning arrays from functions: 

* Passing an array variable from a function back to the shell script uses a similar technique. 
* The function uses an `echo -e` statement to output the individual array values in the proper order, and the script must reassemble them into a new array variable:

  ```bash
  # returning an array value
  arraydblr() {
      local origarray
      local newarray
      local elements
      local i
      origarray=($(echo "$@"))
      newarray=($(echo "$@"))
      elements=$[ $# - 1 ]
      for (( i = 0; i <= $elements; i++ ))
      {
          newarray[$i]=$[ ${origarray[$i]} * 2 ]
      }
      echo ${newarray[*]}
  }
  myarray=(1 2 3 4 5)
  echo "The original array is: ${myarray[*]}"
  result=($(arraydblr ${myarray[*]}))
  echo "The new array is: ${result[*]}"
  ```


## Function Recursion: 

* One feature that local function variables provide is self-containment. 
* A self-contained function doesn't use any resources outside of the function, other than whatever variables the script passes to it in the command line.
* This feature enables the function to be called recursively, which means that the function calls itself to reach an answer.
* The classic example of a recursive algorithm is calculating factorials.

  ```bash
  # using recursion

  factorial(){
      if [ $1 -eq 1 ]
      then
          echo 1
      else
          local temp=$[ $1 - 1 ]
          local result=$(factorial $temp)
          echo $[ $result * $1 ]
      fi
  }
  read -p "Enter value: " value
  result=$(factorial $value)
  echo "The factorial of $value is: $result"
  ```
echo -e "$colorOff"
}

## Creating Library: 
* The first step in the process is to create a common library file that contains the functions you need in your scripts.	
* Here's a simple library file called myfuncs:

  ```bash
  #!/bin/bash
  # My script function

  addem(){
      echo $[ $1 + $2 ]
  }

  multem(){
      echo $[ $1 * $2 ]
  }

  divem (){
  if [ $2 -ne 0 ]; then
          echo $[ $1 / $2 ]
      else
          echo -1
      fi
  }
  ```
* The next step is to include the myfuncs library file in your script files that want to use any of the functions.
* If you run the myfuncs shell script from your shell command line interface prompt, the shell creates a new shell 
  and runs the script in that new shell. but when you try to run another script that uses those functions, they aren't available.
* The key to using function libraries is the source command. The source command executes commands within the current 
  shell context instead of creating a new shell to execute them.
* To source the myfuncs library file in a shell script, you just need to add the following line: `. ./myfuncs`

  ```bash
  # using functions defined in a library file

  . ./myFuncLibrary
  value1=10
  value2=5
  result1=$(addem $value1 $value2)
  result2=$(multem $value1 $value2)
  result3=$(divem $value1 $value2)
  echo "The result of adding them is: $result1"
  echo "The result of multiplying them is: $result2"
  echo "The result of dividing them is: $result3"
  ```

