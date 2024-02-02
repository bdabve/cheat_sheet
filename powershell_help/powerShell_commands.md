

## Find a Command

```powershell
Get-Command CommandName                 # To get the summary information about a specific command
Get-Command CommandName | Format-List   # To get the detailed information about a specific command
Get-Command *text*                      # To search for all commands with a name that contains text
Get-Command -Verb Get                   # To search for all commands that use the Get verb
Get-Command -Noun Service               # To search for all commands that act on a service
Get-Command -syntax Get-Command         # Get only the syntax

# Get-Alias
PS C:\> Get-Alias g*                            # Get all alias starting with g*

PS C:\> gcm Get-Command | Format-List *   # Listing of all the properties of the Get-Command cmdlet.
PS C:\> gcm Get-Command | Format-List -property definition
PS C:\> (gcm Get-Command).definition                        # The same
```

## Store the Output of a Command into a File

* Out-File: Envoie la sortie à un fichier.

  ```powershell
  Get-ChildItem | Out-File unicodeFile.txt
  Get-Content filename.cs | Out-File -Encoding ASCII file.txt
  Get-ChildItem | Out-File -Width 120 unicodeFile.cs
  Get-ChildItem | Out-File -Append files.txt
  ```
  
* Get-Conten: Obtient le contenu de l'élément à l'emplacement spécifié.
  
  ```powershell
  C:\PS> get-content -Path C:\Chapters\chapter1.txt
  
  C:\PS>get-content c:\Logs\Log060912.txt -totalcount 50 | set-content sample.txt
  # Cette commande obtient les 50 premières lignes du fichier Log060912.txt et les stocke dans le fichier sample.txt.
  
  C:\PS>(get-content cmdlets.txt -totalcount 5)[-1]
  # Cette commande obtient la cinquième ligne du fichier texte Cmdlets.txt.
  
  PS M:\ > $filecontent =get - content m:\ example . txt    # Set result to a variable
  ```
  
* Like in bash
  
  ```powershell
  Get-ChildItem > files.txt
  Get-ChildItem 2> errors.txt
  Get-ChildItem n> otherStreams.txt
  Get-ChildItem >> files.txt
  ```

## Obtient les propriétés et mithodes des objets

* **_Get-Member_**: Obtient les propriétés et méthodes des objets. 

  ```powershell
  PS C:\> Get-Process | gm            # All methods and property of get-process cmdlet
  
  # To display only the properties that are available for the Get-ChildItem cmdlet, using the -Force switch 
  PS C:\> Get-ChildItem -Force | Get-Member -MemberType property
  PS C:\> Get-ChildItem -Force | Get-Member -MemberType method    # View the methods available
  PS C:\> Get-Member -inputobject Get-ChildItem                   # 
  
  PS C:\> $pops = @{"Glasgow" = 976970; "Edinburgh" = 488610; "Aberdeen" = 209460; "Dundee" = 157690}
  PS C:\> $pops | gm                 # Alias for get-member

  C:\PS>  Get-Service | Get-Member
  # Cette commande affiche les propriétés et méthodes des objets processus (System.ServiceProcess.ServiceController) générés par l'applet de commande Get-Service.

  PS C:\> $myname = "Dabve"
  PS C:\> $myname | gm         # Searching for upper case methode
  PS C:\> $myname.ToUpper()
  ```
  
## Formating Output


* **_Format-List_**: Takes input and displays information about that input as a list.

  ```powershell
  PS C:\> Get-Process powershell | Format-List
  PS C:\> Get-Process powershell | Format-List
  PS C:\> Get-ChildItem C:\ | Format-List -property name         # With property
  PS C:\> Get-ChildItem C:\ | Format-List -property name,length
  PS C:\> Get-Process powershell | Format-List *                 # Display all items
  ```
  
* **_Format-Wide_**

  ```powershell
  PS C:\> Get-ChildItem C:\ | Format-Wide
  PS C:\> Get-ChildItem c:\ | Format-Wide -Column 3 -Property name # Change to a three-column display.  
  PS C:\> Get-ChildItem c:\ | Format-Wide -Property name -AutoSize # Maximize the amount of space between columns
  PS C:\Users\UP4> Get-ChildItem C:\Windows -Recurse -Include *.txt -ErrorAction 0 | Format-Wide -Column 3
  PS C:\> Get-ChildItem C:\Windows -recurse -include *.txt | Format-Wide -property name -groupby length -column 3
  ```

* **_Format-Custom_**
  
* **_Format-Table_**

  ```powershell
  PS C:\> Get-ChildItem C:\Windows -ErrorAction 0 | Format-Table -Property name,length,lastwritetime
  PS C:\> Get-Process | Format-Table                   # Display as table use full like ps output
  PS C:\> Get-Process | Format-Table Name,id,handles   # To display specific properties 
  ```

* **_Out-GridView_**:  Send content back to the console to use in other forms of output (Graphical).

  ```powershell
  PS:25 > Get-Process | Out-GridView
  PS:25 > gps | ogv                       # gps: Get-Process alias, ogv: Out-GridViaw alias
  PS:25 > gsv | ogv                       # gsv: Get-Service alias
  ```

### Creating a sorted process list

```powershell
PS:25 > Get-Process | Get-Member
PS:25 > Get-Process | Sort-Object cpu -Descending
PS:25 > Get-Process | Sort-Object cpu -Descending | Out-GridView  # Send the hole to graphical interface
```

## Using the New-Object cmdlet

```powershell
PS:25 > $wshShell = New-Object -comobject "wscript.shell"
PS:25 > $wshShell.run("calc.exe")                           # Execute Calculator
PS:26 > $wshShell.ExpandEnvironmentStrings("%windir%")    # Print out the path
```

## Using the Show-Command cmdlet

* The Show-Command cmdlet displays a graphical command picker that you can use to select cmdlets
from a list.

  ```powershell
  PS:26 > Show-Command -Height 500 -Width 350       # Show all command
  PS:26 > Show-Command -Height 500 –Width 350 -Name Get-Process   # Show for get-process cmdlet
  ```

## wshNetwork

```powershell
PS:26 > $wshnetwork = New-Object -comobject "wscript.network"   # Create an instance of the wshNetwork object
PS:26 > $wshnetwork.EnumPrinterConnections()  # Print a list of printer connections that are defined on your local computer

PS:26 > $wshnetwork.EnumNetworkDrives()     #  print a list of network connections that are defined on your local computer.
PS:66 > $wshnetwork.UserName                # You can also get the user domain

PS:71 > $colPrinters = $wshnetwork.EnumPrinterConnections()
PS:72 > $colDrives = $wshnetwork.EnumNetworkDrives()
PS:73 > $userName = $wshnetwork.UserName
PS:74 > $userDomain = $wshnetwork.UserDomain
PS:75 > $computerName = $wshnetwork.ComputerName
PS:76 > $wshShell = New-Object -comobject "wscript.shell"
PS:77 > $wshShell.Popup($userDomain+"\$userName on $computerName")    # Like prompt in JS
```