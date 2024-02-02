$aryComputer = "loopback", "localhost"
Set-Variable -name intDriveType -value 3 -option constant

foreach ($strComputer in $aryComputer) {
    "Hard drives on: " + $strComputer
    Get-WmiObject -Class win32_logicaldisk -ComputerName $strComputer | Where {$_.drivetype -eq $intDriveType}
}
