#Saving scripts to variables and executing with call operators
$cmd = { Get-ChildItem | ? Name -Match ".ps1" }
Write-Host $cmd
& $cmd