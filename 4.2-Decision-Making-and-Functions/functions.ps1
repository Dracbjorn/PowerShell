$script = $myinvocation.mycommand.name
if ($args.Length -ne 2){
    Write-Warning "Usage: $script num1 num2"
    exit
} else {
    $x, $y = $args
}

function subtraction($num1, $num2){
    return ($num1 - $num2)
}

function divisible($num1){
    if ( ($num1 % 2) -eq 0){
        $num1 = (subtraction $num1 1000)
        return $num1
    } else {
        return $num1
    }
}

function multiply($num1, $num2){
    return ($num1 * $num2)
}

function addition($a){
    $b = (multiply 672.5 2)
    return ($a + $b)
}

$x = (divisible $x)
$y = (divisible $y)

$product = (multiply $x $y)
$sum = (addition $product)
Write-Host $sum
Write-Host ($sum.gettype())