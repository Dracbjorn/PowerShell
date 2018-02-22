#$var = $null

$var, $var2, $var3 = 1, 2, 3

if (1 -eq 1){
    $var = "He"
}
<#
function block($var){
    if ($var){
        if (2 -eq 2){
            $var2 = "World"
            return $var, $var2
        }
    }
}
#>
$var3, $var4 = block $var

Write-Host -f green "${var3}llo $var4"