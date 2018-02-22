foreach($i in 0..5){ Write-Host $i }

$value = read-host "Select a value"

switch($value){
    0 { "The value is 0" }
    1 { "The value is 1" }
    2 { "The value is 2" }
    3 { "The value is 3" }
    4 { "The value is 4" }
    5 { "The value is 5" }
    default { "Not a valid value" }
}

<#
if ($value -eq 1){
    "The value is 1"
} elseif ($value -eq 2){
    "The value is 2"
} elseif ($value -eq 3){
    "The value is 3"
} elseif ($value -eq 4){
    "The value is 4"
} elseif ($value -eq 5){
    "The value is 5"
} else {
    "Not a valid value"
}
#>