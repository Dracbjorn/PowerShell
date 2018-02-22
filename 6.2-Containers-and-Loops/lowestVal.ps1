
$numbers = 0, 2, 11, -23, -8, 44, 7, 12, -1, -23

$lowest = $numbers[0]
foreach ($i in $numbers){
    Write-Host "Current number = $i"
    Write-host "lowest = $lowest"
    if ($i -lt $lowest){
        $lowest = $i
    }
}

Write-Host "The number $lowest is the lowest value."

#OR

#Write-Host " $(($numbers | Sort-Object)[0]) is the lowest value"
