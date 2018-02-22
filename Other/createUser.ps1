Import-Module "C:\Users\kgraves\Documents\Scripts\userManagement.psm1"

$first = Read-Host "Enter first name"
$middle = Read-Host "Enter middle name"
$last = Read-Host "Enter last name"

$username = getUserName $first $middle $last

Write-Host "Username: $username"

createUser $username
