New-Object Toaster1
Add-Member -MemberType NoteProperty -Name toasterColor -Value "black"
$numberOfToastingSlots = $numberOfToastingSlots
$toastingLevel = 0
$pluggedIn = $false
$currentlyToasting = $false

toast($action){
        
    if ($action -match "[Ss]tart"){
        $this.currentlyToasting = $true
    } elseif ($action -match "[Ss]top"){
        $this.currentlyToasting = $false
    }
}

listProperties($color){
    Write-Host -f $color "Color = "$this.toasterColor
    Write-Host -f $color "Number of Slots = "$this.numberOfToastingSlots
    Write-Host -f $color "Level = "$this.toastingLevel
    Write-Host -f $color "Power = "$this.pluggedIn
    Write-Host -f $color "Toasting = "$this.currentlyToasting
}

test{
    Write-Host "TEST"
}

$Toaster1 = [Toaster]::new()
$Toaster1.toasterColor = "black"
$Toaster1.numberOfToastingSlots = 4
$Toaster1.toastingLevel = 3
$Toaster1.pluggedIn = $true
$Toaster1.listProperties("cyan")

$Toaster2 = New-Object Toaster -Property @{toasterColor="silver";numberOfToastingSlots=2}
$Toaster2.toastingLevel = 5
$Toaster2.pluggedIn = $true
$Toaster2.listProperties("green")

$Toaster1.toast("start")
$Toaster2.toast("start")
$Toaster1.listProperties("cyan")
$Toaster2.listProperties("green")

$Toaster1.toast("stop")
$Toaster2.toast("stop")
$Toaster1.listProperties("cyan")
$Toaster2.listProperties("green")

$Toaster1.test()