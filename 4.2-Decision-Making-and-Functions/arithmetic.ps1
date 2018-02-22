#1
$a = 668.5
$b = 334.25

$c = $a + $b
$d = $c - $a
$e = $b * $d
$f = $d / $b
$g = ($b * 2) + $a

Write-Host "a = $a"
Write-Host "b = $b"
Write-Host "c = $c"
Write-Host "d = $d"
Write-Host "e = $e"
Write-Host "f = $f"
Write-Host "g = $g"

if ($a -eq $b){ $true }
if ($a -ne $b){ $true }
if ($a -gt $b){ $true }
if ($a -lt $b){ $true }
if ($a -ge $b){ $true }
if ($a -le $b){ $true }

if ( ( ($g -gt $a) -and ($g -eq ($a * 2) ) ) -or ( ($d -lt $g) -and ($g -eq ($b*4) ) ) ){
    $true
} else {
    $false
}

#2

$var = 21
if ($var -gt 23){ Write-Host 4}
elseif ($var -le 23){Write-Host 3}
elseif ($var -eq 23){Write-Host 2}
else{ Write-Host 1}

#3

$var="blue"
if ($var -eq "red"){ $false }
elseif ($var -ne "blue"){ $true }

#4

$var=1024
if ((($var -ge 1500) -and ($var -le 2048)) -or ($var -eq 1023+1)){Write-Host 1}
elseif ((($var -le 2000) -and ($var -gt 998)) -and ($var -eq 1022-2)){Write-Host 2}
elseif ((($var -gt 1) -and ($var -lt 1000+25)) -or ($var -eq 1024)){Write-Host 3}
else {Write-Host 4}