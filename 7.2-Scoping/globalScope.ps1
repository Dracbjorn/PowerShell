$var = "Global 1"

function globalTest1{
    $Global:var = "Global 2"
    Write-Host "GlobalTest1 = $var"
}

function globalTest2{
    write-host "GlobalTest2 = $var"
}

function localTest{
    #$var = "Local"
    Write-Host "Local = $var"

}

Write-Host "Global Scope = $var"
globalTest1
LocalTest
write-host "Global Scope = $var"
globalTest2
write-host "Global Scope = $var"