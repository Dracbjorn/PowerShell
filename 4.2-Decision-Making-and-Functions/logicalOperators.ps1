[int]$num = 1

if (-not $num -lt 1){
    Write-Host "$num is not less than 1"
}

if (!($num -gt 1)){
    Write-Host "$num is not greater than 1"
}

if ($num -ne 1){
    Write-Host "$num does not equal 1"
} else {
    Write-Host "$num is equal to 1"
}

"===================================="