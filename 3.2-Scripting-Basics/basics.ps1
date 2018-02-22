param($arg)

$firstname = read-host "Enter your first name"
$lastname = read-host "Enter your last name"
[int]$age = read-host "Enter your age"
$sex = read-host "Enter your sex"
$fullname = "$firstname $lastname"

Write-Host -f yellow "$fullname is a $age year old $sex and likes to argue with the command line about $arg"