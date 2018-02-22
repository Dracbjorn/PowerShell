Write-Host "x10 = 100"
Write-Host "`nFind the value of x"

$selections = "110","100","50","10"

[int]$num=1
foreach ($i in $selections){
    Write-Host "${num}. $i"
    $num += 1
}

$ans = read-host "Make a selection"

if ($ans -eq "4"){
    Write-Host -f green "Correct!"
} else {
    Write-Host -f red "Incorrect"
}


