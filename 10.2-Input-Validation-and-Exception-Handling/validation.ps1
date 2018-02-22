while($true){
    try {
        [int]$num1 = read-host "Enter first value between 1 and 100"
        [int]$num2 = read-host "Enter second value between 1 and 100"
    } catch {
        Write-Host -f red "Error: Enter an integer value"
        Continue
    }
    $numbers = $num1, $num2
    $valid = $true
    foreach ($num in $numbers){
        if ( ($num -ge 1) -and ($num -le 100) ){
            continue
        } else {
            Write-Host -f red "Error: Invalid value"
            $valid = $false
            break
        }
    }

    if ($valid){
        Write-Host "$num1 * $num2 = $($num1*$num2)"

        try{
            Write-Host "$num1 / 0 = $($num1 / 0)"
            Write-Host "$num2 / 0 = $($num2 / 0)"
        } catch {
            Write-Host -f red "Error: You cannot divide by zero"
            break
        } finally {
            Write-Host "Complete."
        }
        break
    }
}
        