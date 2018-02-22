Class Toaster{
    [String]$toasterColor = $toasterColor
    [int]$numberOfToastingSlots = $numberOfToastingSlots
    [int]$toastingLevel = 0
    [bool]$pluggedIn = $false
    [bool]$currentlyToasting = $false

    toast([String]$action){
        
        if ($action -match "[Ss]tart"){
            $this.currentlyToasting = $true
        } elseif ($action -match "[Ss]top"){
            $this.currentlyToasting = $false
        }
    }
}

$Toaster1 = [Toaster]::new()
$Toaster1.toasterColor = "black"
$Toaster1.numberOfToastingSlots = 4
$Toaster1.toastingLevel = 3
$Toaster1.pluggedIn = $true
Write-Host -f Cyan $Toaster1

$Toaster2 = New-Object Toaster -Property @{toasterColor="silver";numberOfToastingSlots=2}
$Toaster1.toastingLevel = 5
$Toaster1.pluggedIn = $true
Write-Host -f green "($Toaster2)"

$Toaster1.toast("start")
$Toaster2.toast("start")
Write-Host -f Cyan "($Toaster1.currentlyToasting)"
Write-Host -f green "$Toaster2.currentlyToasting"
$Toaster1.toast("stop")
$Toaster2.toast("stop")
Write-Host -f Cyan "$Toaster1.currentlyToasting"
Write-Host -f green "$Toaster2.currentlyToasting"




