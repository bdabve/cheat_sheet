## <center>PowerShell Fondamental</center>


### Get PowerShell Version and helps

```powershell
PS C:\> $PSVersionTable
PS C:\> Get-Host | Select-Object Version
```

## Get Help

```powershell
Get-Help CommandName
CommandName -?

Get-Help CommandName -Detailed    # To get the detailed help information
Get-Help CommandName -Full        # To get the full help
Get-Help CommandName -Examples    # To get examples
Get-Help CommandName -Online      # To retrieve the most up-to-date online version of a command’s help topic
Get-Help CommandName -ShowWindow  # To view a searchable, graphical view of a help topic

# Generate a list of all cmdlets and aliases along with their brief synopses
PS:13 $ Get-Help * -Category Cmdlet | Select-Object Name, Synopsis | Format-Table -Auto

# To retrieve a listing of all the conceptual help articles
PS C:\Users\UP4> Get-Help about*     

PS C:\users\UP4> Get-Help get*      # To obtain the name of all cmdlet start with Get.
```

### <center>Variable</center>



####  Sample of special characters

| Special character | Meaning
|-------------------|------------------------------------
| "                 | The beginning (or end) of quoted text
| #                 | The beginning of a comment
| $                 | The beginning of a variable
| &                 | Reserved for future use
| ( )               | Parentheses used for subexpressions
| ;                 | Statement separator
| { }               | Script block
| |                 | Pipeline separator
| \`                | Escape character


***

### <center>Array</center>

```powershell
PS M:\ > $city = (" Edinburgh "," Glasgow "," Dundee "," Aberdeen ")
PS M:\ > $city[3]
Aberdeen
PS M:\ > ( $city ).Length
4

// A directory listing is an array of file system objects
PS M:\ > $myarray =Get-Childitem
PS M:\ > ( $myarray ).Count
475                           
```

* `get-childitem` command to get the file and folder contents of the current directory 

#### Hashes or dictionary objects

* Using a hash to store Scottish cities and their populations
  
  ```powershell
  PS C:\Users\UP4> $pops = @{"Glasgow" = 976970; "Edinburgh" = 488610; "Aberdeen" = 209460; "Dundee" = 157690}
  PS C:\Users\UP4> $pops

  Name                           Value
  ----                           -----
  Dundee                         157690
  Aberdeen                       209460
  Edinburgh                      488610
  Glasgow                        976970
  ```

* Adding to a dict table
  
  ```powershell
  PS C:\Users\UP4> $pops.Add('Falkirk', 100480)
  PS C:\Users\UP4> $pops

  Name                           Value
  ----                           -----
  Dundee                         157690
  Falkirk                        100480
  Aberdeen                       209460
  Edinburgh                      488610
  Glasgow                        976970
  ```
* Accessing a hash value using its key
  
  ```powershell
  PS C:\Users\UP4> $pops."Aberdeen"
  209460
  PS C:\Users\UP4> $city = "Aberdeen"
  PS C:\Users\UP4> $pops.$city
  209460

  // Getting city from user input
  PS C:\Users\UP4> $city = Read-Host "Enter a Scottish city: "
  Enter a Scottish city: : Edinburgh
  PS C:\Users\UP4> $pops.$city
  488610
  ```

***

### <center>Functions</center>

```powershell

```

***

### <center>Redirection and pipes</center>

* Work the same as linux
  
  ```powershell
  cmdlet1 <c:\ fileA.txt | cmdlet2 > c:\fileB.txt
  ```

*** 

## <center> Customize Your Shell, Profile, and Prompt</center>

* To create a new profile (and overwrite one if it already exists), like `bash.rc`:

  ```powershell
  PS C:\Users\UP4> New-Item -type file -force $profile
  ```
  
* To edit your profile (in the Integrated Scripting Environment):

  ```powershell
  PS C:\Users\UP4> ise $profile
  
  function prompt
  {
    "PS [$env:COMPUTERNAME] >"
  }
  Set-Alias new New-Object
  Set-Alias iexplore 'C:\Program Files\Internet Explorer\iexplore.exe'
  ```
  
* To see your profile file and source the file:

  ```powershell
  PS C:\Users\UP4> Get-ChildItem $profile
  PS C:\Users\UP4> . $profile
  
  
  ```