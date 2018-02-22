$port=1337
$server="localhost"
$client = New-Object System.Net.Sockets.TcpClient ($server, $port)
$stream = $client.GetStream()

#Method 1
#$cmd_bytes = ([text.encoding]::ASCII).GetBytes("Write-Host `"Connection Established!`"")
#$stream.Write($cmd_bytes,0,$cmd_bytes.Length)

#Method 2
$writer = New-Object System.IO.StreamWriter $stream
$writer.Write("Write-Host `"Connection Established!`"")
$writer.Dispose()

$stream.Dispose()
$client.Dispose()