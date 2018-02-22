$primeList = @(2)
foreach ( $num in (3..100) ){
    $IsPrime = $true
    foreach ($factor in (2..($num - 1))){
        if ( ($num % $factor) -eq 0){
            $IsPrime = $false
            break
        }
    }
   
    if ($IsPrime -eq $true){
        $primeList += $num
    }

}

foreach ( $num in $primeList){
    Write-Host "${num}: IS PRIME"
}

Write-Host "There are $($primeList.Length) prime numbers between 1-100."

$primeList.clear()