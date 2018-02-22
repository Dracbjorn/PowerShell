$Toaster = New-Object -TypeName PSObject
$Toaster | Add-Member -MemberType NoteProperty -Name objectCount -Value 0

$displayObjectCount = {
    "You have created $($this.ObjectCount) toasters"
}

$Toaster | Add-Member -MemberType ScriptMethod -Name displayObjectCount -Value $method

$properties = "toasterColor","toastingLevel","numberOfToastingSlots","pluggedIn","currentlyToasting"

foreach ($property in $properties) {
    $Toaster | Add-Member -MemberType NoteProperty -Name $property -Value $null
}

$constructor = {


}


$Toaster | Get-Member