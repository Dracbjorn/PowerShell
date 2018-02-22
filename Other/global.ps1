function globalTest{
    $global:var="Global Variable"
}
function globalTest2{
    Write-Host $var
}

globalTest
Write-Host $var
globalTest2