$ErrorActionPreference = "stop"

try{
    [console]::TreatControlCAsInput=$true
    while ($true){
        Start-Sleep 1
        Get-Item asldkfjasldkfjasdlkfj
    }
} catch [System.Management.Automation.ItemNotFoundException] {
    #$error[0].Exception.GetType().fullname
    Write-Error "ITEM NOT FOUND EXCEPTION WAS CAUGHT"
} catch {
    Write-Error "CATCH ALL"
} finally {
    [console]::TreatControlCAsInput=$false
    Write-Host "CTRL + C was pressed. Exiting..."
}