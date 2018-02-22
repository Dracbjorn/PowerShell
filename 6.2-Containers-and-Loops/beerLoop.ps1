foreach ($num in (99..1)){
    switch ($num){
        1 {
            Write-Host “$num bottle of beer on the wall, $num bottle of beer!”
            Write-Host “Take one down, pass it around.  No more bottles of beer on the wall!”
        }
        default {
            Write-Host “$num bottles of beer on the wall, $num bottles of beer!”
            Write-Host “Take one down, pass it around.  $num bottles of beer on the wall!”
        }
    }
    $num--
}
