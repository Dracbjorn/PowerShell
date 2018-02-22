$ErrorActionPreference = "stop"
$port=1338
$server="localhost"
$server = [System.Net.Sockets.TcpClient]::new($server, $port)
if (-not $server.Connected){ Write-Error "Could not connect to $($server):$($port)" }
$stream = $server.GetStream()
$reader = [System.IO.StreamReader]::new($stream)
$writer = [System.IO.StreamWriter]::new($stream)

while ($true){
    Write-Host "PS > " -NoNewline
    $cmd = Read-Host
    $writer.WriteLine($cmd)

    while (($out = $reader.ReadLine()).Length -ne 0){
        Write-Host $out -NoNewline
    }
}


$writer.Dispose()
$stream.Dispose()
$client.Dispose()