$Student1 = New-Object -TypeName PSObject
$Student1 | Add-Member -MemberType NoteProperty -Name name -Value "John Smith"
$Student1 | Add-Member -MemberType NoteProperty -Name age -Value 30

$Student2 = New-Object -TypeName PSObject
$Student2 | Add-Member -MemberType NoteProperty -Name name -Value "Pam Smith"
$Student2 | Add-Member -MemberType NoteProperty -Name age -Value 27

$Student1.name
$Student1.age
$Student2.name
$Student2.age
 