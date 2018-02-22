function toaster($values){

    $properties = "color", "toastingLevels", "numberOfSlots", "currentlyToasting"

    function addMembers($object, $values){
       
        $count = 0
        while($count -le ($properties.Length - 1)){
            Write-Host -f yellow "Name=$($properties[$count]) Value=$($values[$count])"
            $object | Add-Member -MemberType NoteProperty -Name $properties[$count] -Value $values[$count]
            $count++
        }
    }

    $object = New-Object -TypeName PSObject
    addMembers $object $values

    $object | Add-Member -MemberType ScriptMethod -name toast -Value {
        param($var1, $var2)
        Write-Host $var1 $var2
        $Toaster1.currentlyToasting = "yes"
    }

    return $object
}

$Toaster1 = toaster ("Black",5,2)
$Toaster2 = toaster ("Red",3,4)

Write-Host -f magenta "========Toaster 1 ========="
$Toaster1.color
$Toaster1.toastingLevels
$Toaster1.numberOfSlots
$Toaster1.currentlyToasting
$Toaster1.toast("Im a", "Toaster")
$Toaster1.currentlyToasting
<#write-Host -f cyan "========Toaster 2 ========="
$Toaster2.color
$Toaster2.toastingLevels
$Toaster2.numberOfSlots
$Toaster2.currentlyToasting
$Toaster2.toast()
$Toaster2.currentlyToasting
#>

