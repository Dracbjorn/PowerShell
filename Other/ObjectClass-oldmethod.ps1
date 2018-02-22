$Object = New-Object -TypeName PSObject
$Object | Add-Member -MemberType NoteProperty -Name myProperty -Value "red"
$Object.myProperty
$Object.myProperty = "blue"
$Object.myProperty