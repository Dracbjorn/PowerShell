<#
$num = 100
$num = 100 / 10
$num.getType()
Write-Host "100 / 10 = $num"
#>

#[int]$num = read-host "Enter a number"
$num = read-host "Enter a number"

$num.GetType()
Write-Host ($num -as [int]).ToString()

if ($num -as [int] -gt 10){
    "Your number is greater than 10"
} elseif ($num -as [int] -lt 1){
    "Your number is less than 1"
} else {
    "You selected $num"
}
($num -as [int]).GetType()

Remove-Variable num

"======================================"