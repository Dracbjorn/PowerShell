
#[console]::TreatControlCAsInput=$true
function looping{
    while ($true){
            Write-Host -f cyan "Looping"
            sleep 1
    }
}

function main{
    foreach ($i in 1..3){
        try {
            looping
        } finally {
            Write-Host -f Magenta "FINALLY!"
            main
        }
    }
}

main