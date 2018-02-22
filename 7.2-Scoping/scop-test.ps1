$var = 1, 2, 3, 4

function myFunction($var){
    
    $var += 5

    Write-Host "Inside Function:"

    $var

}

myFunction $var

Write-Host "Outside FUnction:"
$var