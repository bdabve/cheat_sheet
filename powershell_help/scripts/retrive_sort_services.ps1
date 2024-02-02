$args = "localhost", "loopback"

foreach ($i in $args) {
    Get-WmiObject -computer "localhost" -class win32_service | Select-Object -Property name, state, startmode, startname | Sort-Object -Property name, state, startmode, startname | Sort-Object -Property startmode, state, name | Format-Table *
    }