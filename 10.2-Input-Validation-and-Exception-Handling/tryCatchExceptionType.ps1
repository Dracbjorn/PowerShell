#Get fullname of exception type
#$error[0].Exception.GetType().fullname

try{
    1 / 0
} catch [System.Management.Automation.RuntimeException] {
    Write-Host "RuntimeException catch:"
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName
    Write-Host -f red "ERROR: $ErrorMessage"
} catch {
    Write-Host "Generic catch:"
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName
    Write-Host -f red "ERROR: $ErrorMessage"
}

