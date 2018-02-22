#Get command line arguments
#$args.Length
#param($string1, $string2, $string3, $string4="one")     #Method 1
#$args.GetType()
#$string1, $string2, $string3, $string4 = $args #method 2

$ErrorActionPreference = "inquire"

$string1 = "one"

Write-Host string1=$string1
#Write-Host string2=$string2
#Write-Host string3=$string3
#Write-Host string4=$string4

Get-Variable -Scope Script