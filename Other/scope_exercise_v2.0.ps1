$var = "global1"

function one{
    $var = "local1"
    Write-Host $var
    function two{
        $Global:var = "global2"
        $var = "local2"
        Write-Host $var
        function three {
            return $Global:var
        }
        $var = three
        return $var
    }
    $var = two
    Write-Host $var
}

function three($var){
    $Global:var = "global3"
    $var = "local3"
    Write-Host $Global:var
    Write-Host $var
    function four{
        $var = "global4"
        return $var
    }
    return four
}

Write-Host $var
one
$var = three $var
Write-Host $var

