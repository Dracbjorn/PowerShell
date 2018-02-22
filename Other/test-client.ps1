$port=8989
$server="localhost"
$client = New-Object System.Net.Sockets.TcpClient ($server, $port)
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter $stream
$message = Read-Host ">"
$writer.Write($message)
$writer.Dispose()
$stream.Dispose()
$client.Dispose()