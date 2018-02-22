."S:\Student Stuff\Scripting\PowerShell\8.2-Object-Oriented-Programming-and-Custom-Modules\Toaster.ps1"
#Import-Module "S:\Student Stuff\Scripting\PowerShell\8.2-Object-Oriented-Programming-and-Custom-Modules\Toaster.psm1"

$numberOfToasters = [Toaster]::numberOfToasters
Write-Host -f Magenta "`nTotal number of toasters: $numberOfToasters"
$Toaster1 = [Toaster]::new("black",4)
$Toaster1.toastingLevel = 3
$Toaster1.pluggedIn = $true
Write-Host -f cyan "`nToaster1`n"
Write-Host -f cyan "`tColor:"$Toaster1.toasterColor
Write-Host -f cyan "`tNumber of Slots:"$Toaster1.numberOfToastingSlots
Write-Host -f cyan "`tToasting Level:"$Toaster1.toastingLevel
Write-Host -f cyan "`tPlugged In?:"$Toaster1.pluggedIn
Write-Host -f cyan "`tToasting?:"$Toaster1.currentlyToasting


$Toaster2 = New-Object Toaster -ArgumentList @("silver",2)
$Toaster2.toastingLevel = 5
$Toaster2.pluggedIn = $true
Write-Host -f green "`nToaster2`n"
Write-Host -f green "`tColor:"$Toaster2.toasterColor
Write-Host -f green "`tNumber of Slots:"$Toaster2.numberOfToastingSlots
Write-Host -f green "`tToasting Level:"$Toaster2.toastingLevel
Write-Host -f green "`tPlugged In?:"$Toaster2.pluggedIn
Write-Host -f green "`tToasting?:"$Toaster2.currentlyToasting

Write-Host -f yellow "`nStarting Toaster1..."
$Toaster1.toast($true)
Write-Host -f cyan "Toaster1 toasting? "$Toaster1.currentlyToasting
Write-Host -f green "Toaster2 toasting? "$Toaster2.currentlyToasting

Write-Host -f red "`nStopping Toaster1..."
Write-Host -f yellow "Starting Toaster2..."
$Toaster2.toast($true)
$Toaster1.toast($false)
Write-Host -f cyan "Toaster1 toasting? "$Toaster1.currentlyToasting
Write-Host -f green "Toaster2 toasting? "$Toaster2.currentlyToasting

Write-Host -f red "`nStopping Toaster2..."
$Toaster2.toast($false)
Write-Host -f cyan "Toaster1 toasting? "$Toaster1.currentlyToasting
Write-Host -f green "Toaster2 toasting? "$Toaster2.currentlyToasting

$numberOfToasters = [Toaster]::numberOfToasters
Write-Host -f Magenta "`nTotal number of toasters: $numberOfToasters"

#Remove-Item Toaster