$port=1234
$server="127.0.0.1"
Try{
    $client = New-Object System.Net.Sockets.TcpClient ($server, $port)
} Catch {
    Write-Warning "Server refused connection"
    return
}
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter $stream
$cmd_bytes = ([text.encoding]::ASCII).GetBytes("exit")                     #Convert string cmd to bytes
$stream.Write($cmd_bytes,0,$cmd_bytes.Length)                            #Send the cmd to the server
$stream.Flush()
$cmd_bytes = ([text.encoding]::ASCII).GetBytes("kill")                     #Convert string cmd to bytes
$stream.Write($cmd_bytes,0,$cmd_bytes.Length)                            #Send the cmd to the server
$stream.Flush()
$writer.Write(([char]4))
$writer.Dispose()
$stream.Dispose()
$client.Close()
$client.Dispose()
