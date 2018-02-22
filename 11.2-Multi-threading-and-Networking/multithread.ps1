#param($remoteHostsFile)
$remoteHostsFile = "C:\Users\user\remoteHosts.txt"

$ErrorActionPreference = "stop"

$remoteHosts=Get-Content $remoteHostsFile
$scan = {
    param($ip)
    $out = "C:\Users\user\Documents\$ip.txt"
    Write-Host "Scanning $ip...."
    $response=$false
    foreach ($port in 1..1024){
        Try{
            $socket = New-Object System.Net.SOckets.TcpClient
            $timeout = $socket.BeginConnect($ip, $port, $null, $null)
            $wait = $timeout.AsyncWaitHandle.WaitOne(1, $false)
            if ($wait){
                $response = $true
                $socket.close()
                $results="Port ${port}:`tOpen"
                Add-Content -path "$out" "$results"
                Write-Host $results
            }
        } Catch {
            $err=$_.Exception.Message
            Write-Error $err
            Continue
        }
    }
    if (-not $response){
        $results ="No response from host: $ip"
        Write-Host $results
        Add-Content -path "$out" "$results"
    }
}

foreach ($ip in $remoteHosts){
    $ip=$ip.Trim()
    $job=Start-Job $scan -ArgumentList $ip
}

while (Get-Job -State "Running"){
    continue
    Sleep 1
}

Get-Job | Receive-Job
Get-Job | Remove-Job

Write-Host "Scan Complete"