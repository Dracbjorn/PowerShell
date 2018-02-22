$GOLD = '\\gold.azuretitan.com\DevShare\GOLD Repository\CQC001'
$date = Get-Date -Format FileDate
$filelist = "search-file-list-$date.txt"

function getSubDirs($dir){

    return (Get-ChildItem -Directory -Recurse -Path $dir.FullName | ? { $_.Name -match "^CQC.*E0[5,6,7]0$" })

}

function getFiles($dir){

    return (Get-ChildItem -File -Recurse -Path $dir.FullName | ? { $_.Extension -notmatch ".pdf|.exe|.pcap|.ex_|.jpg|.png|.db|.zip|.dll" })

}

if ( -Not (Test-Path $filelist) ){
    
    Set-Content -Value "GOLD Unix File List $date :" $filelist

    write-host "Building file list..."

    foreach( $dir in Get-Childitem -Directory $GOLD ){

        $files = getFiles $dir.FullName

        $files += getSubDirs $dir.FullName | % { getFiles $_.FullName }     

        $files | % { Add-Content -Value $_.FullName $filelist }
    
    }

} else {

    $files = Get-Content $filelist

    $pattern = Read-Host "Search term"

    Write-Host "Searching file list..."

    $files | ? { (Select-String "$pattern" $_.FullName) -eq $true } 

    exit

}