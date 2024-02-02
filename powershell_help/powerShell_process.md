
## Process

* **_Get-Process_**  : Obtient les processus qui s'exécutent sur l'ordinateur local ou un ordinateur distant.
    
* EXEMPLES
  ```powershell
  C:\PS> Get-Process
  C:\PS> Get-Process - id 664, 2060

  C:\PS> Get-Process winword, explorer | format-list *
  # Cette commande obtient toutes les données disponibles sur les processus liés à Winword et à Explorer, 
  # Format-List, qui affiche toutes les propriétés disponibles des objets processus Winword et Explorer.

  C:\PS>get-process powershell -fileversioninfo
  # Obtenir des informations sur la version du fichier PowerShell.exe qui est le module principal du processus PowerShell.

  C:\PS>get-process sql* -module
  # Obtenir les modules qui ont été chargés par le processus.

  C:\PS>$p = get-wmiobject win32_process -filter "name='powershell.exe'"
  C:\PS> $p.getowner()
  # Cette commande montre comment rechercher le propriétaire d'un processus.
  # Get-Process n'a pas de propriété ou de méthode qui retourne le propriétaire du processus, la commande utilise l'applet de commande Get-WmiObject pour obtenir un objet Win32_Process qui représente le même processus.

  C:\PS>get-process powershell    
  C:\PS> get-process -id $pid
  # Ces commandes montrent comment utiliser la variable automatique $pid pour identifier le processus qui héberge la session active Windows PowerShell.

  C:\PS>$a = get-process
  C:\PS> get-process -inputobject $a | format-table -view priority
  # Ces commandes répertorient les processus présents sur l'ordinateur dans des groupes, en fonction de leur classe de  priorité.
  ```    

***

## Jobs

* **_Start-Job_**: Launch a background job on the local computer
  
  ```powershell
  PS > Start-Job { while($true) { Get-Random; Start-Sleep 5 } } -Name Sleeper
  ```
  
* **_Get-Job_**: Gets all jobs associated with the current session. In addition this parameters let you filter jobs based on their state or completion time.  
  
  * **_-Before_**
  * **_-After_**
  * **_-Newest_**
  * **_-State_** 

* **_Wait-Job_**    : Waits for a job until it has output ready to be retrieved.
* **_Receive-Job_** : Retrieves any output the job has generated since the last call to Receive-Job.
* **_Stop-Job_**    : Stops a job.
* **_Remove-Job_**  : Removes a job from the list of active jobs.