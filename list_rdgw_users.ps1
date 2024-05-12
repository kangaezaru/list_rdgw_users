$hostname = hostname
$timestamp = Get-Date -Format "yyyyMMdd"
$filename = $hostname + "_" + $timestamp +".csv"
Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-Gateway/Operational" | Where-Object{ $_.Id -eq 302 } | ForEach-Object{
    $ipAddress = $_.Properties[1].Value
    $date = $_.TimeCreated
    $user = $_.Properties[0].Value
    [PSCustomObject]@{
        date = $date
        ip = $ipAddress
        user = $user
    }
} | Export-Csv -Path .\$filename -NoTypeInformation -Encoding UTF8