$num = read-host "Enter a number"
if ($num -gt 10){
    "Your number is greater than 10"
} elseif ($num -lt 1){
    "Your number is less than 1"
} else {
    "You selected $num"
}

