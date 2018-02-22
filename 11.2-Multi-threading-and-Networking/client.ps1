$port = 1234
$ip="127.0.0.1"

$client = New-Object System.Net.Sockets.TcpClient ($ip, $port)                    #Create TCP connection to $ip:$port
Write-Host "[*] Connected to server"

$stream = $client.GetStream()                                                     #Get TCP stream from connection
Write-Host "[*] Got Stream"

[byte[]]$bytes = 0..65535|%{0}                                                    #Create a byte array with 65536 elements filled with 0 values

#Write-Host "[*] Creating stream reader..."
#$reader = New-Object System.IO.StreamReader($stream)                             #Create a stream reader

#Write-Host "[*] Creating stream writer..."
#$writer = New-Object System.IO.StreamWriter($stream)                             #Create a stream writer

while (($numberOfBytes = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){                   #while bytes read from stream is not 0
    Write-Host "[*] Read data stream from server"
    
    Write-Host "[*] Converting data to string..."
    $EncodedText = New-Object -TypeName System.Text.ASCIIEncoding            #Get data from client in bytes and convert to ascii text
    $output = $EncodedText.GetString($bytes,0, $numberOfBytes)

    Write-Host "$output" -NoNewline                                          #Print output from server to screen
    $cmd = Read-Host                                                         #Get user input to send to server

    Write-Host "[*] Sending command: $cmd"
    $cmd_bytes = ([text.encoding]::ASCII).GetBytes($cmd)                     #Convert string cmd to bytes
    #Write-Host "$writer.Write("$cmd")"
    $stream.Write($cmd_bytes,0,$cmd_bytes.Length)                            #Send the cmd to the server
    $stream.Flush()                                                          #Flush stream

    Start-Sleep -Milliseconds 500
}
$client.Dispose()
$stream.Dispose()
#$writer.Dispose()
#$reader.Dispose()