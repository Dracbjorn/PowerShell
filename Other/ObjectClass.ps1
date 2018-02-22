Class myObject{
    [String]$myProperty
}

$Object = [myObject]::New()
$object.myProperty = "red"
$object.myProperty
$object.myProperty = "blue"
$object.myProperty