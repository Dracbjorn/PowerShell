$sleeper = {
    param($count)
    Start-Sleep $count
}

foreach ($count in 1..10){
    Start-Job $sleeper -ArgumentList $count
}

while (Get-Job -State "Running"){
    Start-Sleep 10
}

