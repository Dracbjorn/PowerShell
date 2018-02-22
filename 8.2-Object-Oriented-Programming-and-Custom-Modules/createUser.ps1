Import-Module "C:\Users\LocalAdmin\Documents\Scripting\PowerShell\8.2-Object-Oriented-Programming-and-Custom-Modules\userManagement.psm1"
. "C:\Users\LocalAdmin\Documents\Scripting\PowerShell\8.2-Object-Oriented-Programming-and-Custom-Modules\userManagement.ps1"
$first = Read-Host "Enter first name"
$middle = Read-Host "Enter middle name"
$last = Read-Host "Enter last name"

$username = getUserName $first $middle $last

Write-Host "Username: $username"

$result = createUser $username
if ($result){
    Write-Host -f green "$username was successfully added!"
} else {
    Write-Error "$username was NOT successfully added!"
}

$um = [UserManagement]::new()
Write-Host -f green $um.gettype()