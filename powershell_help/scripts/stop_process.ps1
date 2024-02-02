$process = "notepad", "calc"
Get-Process -Name $process -ErrorAction SilentlyContinue | Stop-Process -PassThru | ForEach-Object { $_.name + ' with process ID: ' + $_.ID + ' was stopped.'}