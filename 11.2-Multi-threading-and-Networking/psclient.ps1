$port = 1234                                                                      #Server port
$ip="127.0.0.1"                                                                   #Server IP

Try{
    $client = New-Object System.Net.Sockets.TcpClient ($ip, $port)                #Create TCP connection to $ip:$port
    Write-Host "[*] Connection established: ${ip}:${port}"
} Catch {
    Write-Warning "Could not connect to ${ip}:${port}"
    return
}

$stream = $client.GetStream()                                                     #Get TCP stream from connection to server

#Byte Array with 65536 elements filled with 0 values
[byte[]]$bytes = 0..65535|%{0}                                                    #Create a byte array to use as buffer to store data

while (($numberOfBytes = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){                   #while bytes read from stream is not 0

    $EncodedText = New-Object -TypeName System.Text.ASCIIEncoding                 #Create an ASCII Encoding Object

    $output = $EncodedText.GetString($bytes,0, $numberOfBytes)                             #Covert data from bytes to string with ASCII encoding

    Write-Host $output -NoNewline                                               #Print output from server to screen

    while ( ($cmd = Read-Host) -eq "" ){                                        #Get user input command to execute on server
        Write-Host "> " -NoNewline
        continue
    }

    $cmd_bytes = ([text.encoding]::ASCII).GetBytes($cmd)                          #Convert string cmd to bytes

    $stream.Write($cmd_bytes,0,$cmd_bytes.Length)                                 #Send the cmd to the server
    $stream.Flush()                                                               #Flush stream

    Start-Sleep -Milliseconds 500
}
$client.Dispose()                                                                 #Disconnect from server
$stream.Dispose()                                                                 #Destroy stream

