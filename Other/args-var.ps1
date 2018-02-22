param($string1, $string2, $string3, $string4)

$strings = $string1, $string2, $string3, $string4

$count = 0
foreach ($arg in $strings){
    $count++
    Write-Host "${count}. $arg"
}

