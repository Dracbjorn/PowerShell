$global:var = "Global Variable"
function localScope{
    $var = "Local Variable"
    Write-Host $var
}
function globalScope{
    Write-Host $var
}
localScope
globalScope