$a=7
Write-Host ($a-2)

function function1($a){
    $a--
    Write-Host $a
}

function function2($a){
    Write-Host $a
    $a += 2
    return $a
}

function function3($a){
    $a--
    Write-Host $a
    function function4(){
        $a = $global:a
        Write-Host $a
    }
    function4
}

function1 $a
$a = function2 $a
function3 $a
$a++
Write-Host $a