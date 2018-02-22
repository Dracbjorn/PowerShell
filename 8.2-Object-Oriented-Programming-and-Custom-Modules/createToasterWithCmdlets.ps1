$Toaster1 = New-Object PSObject
$Toaster1 | Add-Member NoteProperty -Name color -Value "black"
$Toaster1 | Add-Member NoteProperty -Name toastingLevels -Value 5
$Toaster1 | Add-Member NoteProperty -Name numberOfSlots -Value 2
$Toaster1 | Add-Member NoteProperty -Name currentlyToasting -Value $false
$Toaster1 | Add-Member ScriptMethod -Name toast -Value {
    $Toaster1.currentlyToasting = $true
}

$Toaster1.color
$Toaster1.currentlyToasting
$Toaster1.toast()
$Toaster1.currentlyToasting