param($arg)

function hello(){
    $var="Well hello there!"
    return $var
}

function goodbye(){
    $var="Goodbye my friend!"
    return $var
}

function say($string){
    Write-Host "$string"
}

function main($arg){
    if ($arg -eq "hi"){
        say (hello)
    } elseif ($arg -eq "bye") {
        say (goodbye)
    } else {
        say "Usage: function.ps1 hi|bye"
    }
}

main($arg)

