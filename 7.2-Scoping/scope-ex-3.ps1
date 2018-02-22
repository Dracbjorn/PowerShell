$var = "global"
function outer{
    function length($var){
        $num = 0
        foreach($i in 1..($var.length)){
            $num++
        }
        return $num
    }
    $var = "local "
    function inner{
        $var = "variable"
        return $var
    }
    $i = inner
    $var += $i
    Write-Host "Var is a $var and has a length of $(length $var)"
}
outer

