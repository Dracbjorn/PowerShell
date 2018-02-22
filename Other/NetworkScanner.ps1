param($remoteHostsFile)
$remoteHosts=Get-Content $remoteHostsFile
$scan = {
    param($ip)
    $out="C:\Users\kgraves\Documents\Scripts\$ip.txt"
    Write-Host "Scanning $ip..."
    $respond=$false
    foreach ($port in 1..1024){
        Try{
            $socket = New-Object System.Net.Sockets.TcpClient 
            #$timeout = $socket.BeginConnect($ip, $port,$null,$null)
            $timeout = $socket.Connect($ip, $port)
            $wait = $timeout.AsyncWaitHandle.WaitOne(1,$false)
            if ($wait){
                $respond=$true
                $socket.close()
                $results="Port ${port}:`tOpen"
                Add-Content -path "$out" "$results"
                Write-Host $results
            }
        } catch {
            $err=$_.Exception.Message
            Write-Host $err
            continue
        }
    }
    if (-not $respond){
        $results="No response from host"
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
}

Get-Job | Receive-Job
Get-Job | Remove-Job

Write-Host "Scan Complete"