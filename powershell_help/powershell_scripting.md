## Enable scripting on powershell

```powershell
PS C:\> Set-ExecutionPolicy RemoteSigned     # Enable Scripting for local machine
PS C:\> Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force    # Enable scripting for local user

PS C:\> Get-ExecutionPolicy                   # Retrieve the current effective script execution policy
PS C:\> Get-ExecutionPolicy -List             # View the execution policy for all scopes

PS C:\> .\script_name.ps1                     # Run script from powershell

powershell -noexit -file path\to\file_name.ps1    # Run script from outside (windows + R for example)
```

***

## <center>Variables</center>

### Special variables and their associated meanings

|Name | Use
|-----|-------------------------------------------
| $^ | This contains the first token of the last line input into the shell.
| $$ | This contains the last token of the last line input into the shell.
| $_ | Current pipeline object; it is used in script blocks, filters, Where-Object, ForEach-Object, and Switch.
| $? | This contains the success/fail status of the last statement.
| $Args | This is used with functions or scripts requiring parameters that do not have a param block.
| $Error | This saves the error object in the $error variable if an error occurs.
| $ExecutionContext | This contains the execution objects available to cmdlets.
| $foreach | This refers to the enumerator in a foreach loop.
| $HOME | This is the user‘s home directory (set to %HOMEDRIVE%\%HOMEPATH%).
| $Input | This is input that is pipelined to a function or code block.
| $Match | This is a hash table consisting of items found by the -match operator.
| $MyInvocation | This contains information about the currently executing script or command line.
| $PSHome | This is the directory where Windows PowerShell is installed.
| $Host | This contains information about the currently executing host.
| $LastExitCode | This contains the exit code of the last native application to run.
| $True | This is used for Boolean TRUE.
| $False | This is used for Boolean FALSE.
| $Null | This represents a null object.
| $This | In the Types.ps1xml file and some script block instances, this represents the current object.
| $OFS | This is the output field separator used when converting an array to a string.
| $ShellID | Identifier for the shell; this value is used by the shell to determine the execution policy and what profiles are run at startup.
| $StackTrace | This contains detailed stack trace information about the last error.

* Declaring Variables
  
```
PS C:\> $myvar = 4
PS C:\> $myvar             # Output: 4
PS C:\> Write-Host $myvar  # Output: 4
PS C:\> $myvar.GetType()   # Get type of variables  
# Output 
IsPublic IsSerial Name          BaseType
-------- -------- ----          --------
True      True    Int32         System.ValueType

PS C:\> $myvar="7" + $myvar
PS C:\> $myvar.GetType()
# Output
IsPublic IsSerial Name          BaseType
-------- -------- ----          --------
True      True    String        System.Object


PS M:\ > $workaddress =" Main Library,
>>George Square,
>>Edinburgh"                # Multiline string

PS C:\> $variable1, $variable2 = "Value1", "Value2"    # Multiple variable assignment.
PS C:\> ${c:\filename.ext}                             # Get and Set Content of filename.ext
PS C:\> [datatype] $var = value                        # Variable data type
PS C:\> $SCOPE:variable = value                        # Scopes are: global, local, script
PS C:\> Get-Help About-Scope.                          # More information about scopes

PS C:\> $now = (Get-Date -UFormat '%Y')                # Like $() in bash

PS C:\> Set-Variable -Name intDriveType -Value 3 -Option constant   # Constant Variable
```
  
* Data type aliases

|Alias          | Type
|---------------|---------------------------------
| [int]         | A 32-bit signed integer
| [long]        | A 64-bit signed integer
| [string]      | A fixed-length string of Unicode characters
| [char]        | A Unicode 16-bit character, UTF-16
| [bool]        | A true/false value
| [byte]        | An 8-bit unsigned integer
| [double]      | A double-precision 64-bit floating-point number
| [decimal]     | A 128-bit decimal value
| [single]      | A single-precision 32-bit floating-point number
| [array]       | An array of values
| [xml]         | An XML document
| [hashtable]   | A hashtable object (similar to a dictionary object)

* The PowerShell environment: is the term to describe the current settings. These settings are exposed in **_environment variables_**.
  
  ```powershell
  PS C:\> Get-Item env:\
  
  PS C:\> Get-Item env:\username
  // Output
  Name                           Value
  ----                           -----
  USERNAME                       UP4
  
  PS C:\> $me = (Get-Item env:\username).value
  PS C:\> Write-Host $me
  UP4
  
  PS C:\> $env:username
  UP4
  
  PS C:\> $path = ($env:path)
  PS C:\> $path
  %SystemRoot%\system32\WindowsPowerShell;C:\python27;
  ```
  
* Removing a variable
  
  ```powershell
  PS C:\> $var = "Something"
  PS C:\> $var                  #  Something
  PS C:\> $var = $null          # Removed
  ```

* **_Write-Host_**: Like echo in linux
  
  ```powershell
  PS C:\> Write-Host Meziane Halala       # Out: Meziane Halala  
  PS C:\> Get-Help Write-Host      # Get help like Man in linux
  ```

* **_Read-Host_**: command echoes back what was typed however if we assign that value to a variable, say $name then we can capture the user
  
  ```powershell
  PS M:\ > $name = Read-Host "What is your name :"
  What is your name :: Jane
  PS M:\ > write-host $name           # Out: Jane
  ```

***

## <center>Looping in powershell</center>

* Using the **_While_** statement
  ```
  $i = 0
  While ($i -lt 5) {
    "`$i equals $i. This is less than 5"
    $i++
   } #end while $i lt 5
  ```

* Reading file content
  ```
  $i = 0
  $fileContents = Get-Content -path C:\fso\testfile.txt
  While ( $i -le $fileContents.length ) {
      $fileContents[$i]
      $i++
  }
  ```

* Using the **_Do...While_** statement

  ```
  $i = 0
  $ary = 1..5     # Declaring an array containing from 1 to 5
  do { 
      $ary[$i]
      $i++
  } while ($i -lt 5)
  ```

* Display Capital Letters

```
$i = 0
$caps = 65..91
do {
  [char]$caps[$i]
  $i++
} while ($i -lt 26)
```

* Using the **_Do...Until_** statement

  ```
  $i = 0
  $ary = 1..5
  Do
  {
      $ary[$i]
      $i ++
  } Until ($i -eq 5)
  ```

* The **_For_** statement
  ```
  For($i = 0; $i -le 5; $i++)
  {
    '$i equals ' + $i
  }
  ##
  $i = 0
  For(;$i -le 5; )
  {
    "`$i is equal to $i"
    $i++
  }
  ```
  
* Using the **_Foreach_** statement
  
  ```
  $ary = 1..5
  Foreach ($i in $ary)
  {
      $i
  }
  
  PS C:\> foreach($i in $ary) { $i }
  ```

* The **_$__** automatic variable (which represents the current item on the pipeline)
  ```
  PS C:\> 1..5 | ForEach-Object { $_ }
  ```

* Exiting the **_Foreach_** statement early
  ```
  $ary = 1..5
  ForEach($i in $ary)
  {
    if($i -eq 3) { break }
    $i
  }
  "Statement following foreach loop"
  ##
  # Using Exit
  $ary = 1..5
  ForEach($i in $ary)
  {
    if($i -eq 3) { exit }
    $i
  }
  "Statement following foreach loop"
  ```

***

## <center>Condition in powershell</center>

* Using the **_If..elseif..else_** statement

| Operator  | Description                   | Example                                   | Result
|-----------|-------------------------------|-------------------------------------------|------------
| -eq       | Equals                        | $a = 5; $a -eq 4                          | False
| -ne       | Does not equal                | $a = 5; $a -ne 4                          | True
| -gt       | Greater than                  | $a = 5; $a -gt 4                          | True
| -ge       | Greater than or equal to      | $a = 5; $a -ge 5                          | True
| -lt       | Less than                     | $a = 5; $a -lt 5                          | False
| -le       | Less than or equal to         | $a = 5; $a -le 5                          | True
| -like     | Wildcard comparison           | $a = 'This is Text'; $a -like 'Text'      | False
| -notlike  | Wildcard comparison           | $a = 'This is Text'; $a -notlike 'Text'   | True
| -match    | Regular expression comparison | $a = 'This is Text'; $a -match 'Text'     | True
| -notmatch | Regular expression comparison | $a = 'This is Text'; $a -notmatch 'Text$' | False

  ```
  $a = 4
  If ($a -eq 5)
  {
    '$a equals 5'
  }
  ElseIf ($a -eq 3)
  {
    '$a is equal to 3'
  }
  Else
  {
    '$a does not equal 3 or 5'
  }
  ```

* The **_Switch_** statement

  ```
  $a = 2
  Switch ($a)
  {
    1 { '$a = 1' }
    2 { '$a = 2' }
    3 { '$a = 3' }
    Default { 'unable to determine value of $a' }
  }
  "Statement after switch"

  # break statement
  $a = 2,3,5,1,77
  Switch ($a)
  {
    1 { '$a = 1' ; break }
    2 { '$a = 2' ; break }
    3 { '$a = 3' ; break }
    Default { 'unable to determine value of $a' }
  }
  "Statement after switch"
  ```
***

## <center>Functions in powershell</center>