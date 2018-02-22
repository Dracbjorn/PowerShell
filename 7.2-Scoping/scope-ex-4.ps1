$exercise = "global"
Write-Host $exercise

function local{
    $exercise = "local"
    Write-Host $exercise
}

function local2{
    $exercise = "local2"
    Write-Host $exercise
}
local
local2
Write-Host $exercise
