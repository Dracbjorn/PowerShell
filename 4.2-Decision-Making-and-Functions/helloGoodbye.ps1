param($arg)

function hello(){
    $var = "Well hello there!"
    return $var
}

function goodbye(){
    $var = "Goodbye my friend!"
    return $var
}

function say($string){
    Write-Host $string
}

function main($mainArg){
    Write-Host $mainArg
    if ($mainArg -eq "hi"){
        say (hello)
    } elseif ($mainArg -eq "bye"){
        say (goodbye)
    } else{
        say "Usage: function.ps1 <hi|bye>"
    }
}

main $arg