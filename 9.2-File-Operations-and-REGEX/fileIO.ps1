param($path) #C:\Windows\System32\drivers\etc\hosts

#To delete a user at anytime use:
#NET USER 'fileio' /DEL

if (-not $path){
    Write-Error "Usage: fileIO.ps1 <path>"
    exit
}

function readFile($path){
    $contents = Get-Content $path
    return $contents
}

function copyFile($path, $contents){
    $newFile = New-Item -force $path
    Set-Content -Path $newFile -Value $contents -Force
    return $newFile
}

function newUser($username){
    $computerName = $env:COMPUTERNAME
    $ADSIComp = [adsi]"WinNT://$ComputerName"
    $newUser = $ADSIComp.Create('User', $username)
    $newUser.SetPassword("IlovePOSH!!1337")
    $newUser.SetInfo()
}

function filePerms($file, $username, $perms){
    $ar = New-Object System.Security.AccessControl.FileSystemAccessRule($username, "FullControl", "Allow")
    $fileAcl = $file.GetAccessControl()
    $fileAcl.AddAccessRule($ar)
    $file.SetAccessControl($fileAcl)
}

$fileContents = readFile $path

#C:\hosts-copy
$copyPath = read-host "Enter path to copy file to"

$newFile = copyFile $copyPath $fileContents

#fileio
$username = read-host "Enter a user name"

newUser $username

filePerms $newFile $username "Full Control"

$newContents = readFile $newFile

Write-Host "Permissions:"
($newFile.GetAccessControl()).Access

Write-Host "New file contents:"
Write-Host $newContents