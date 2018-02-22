param($string)

function sliceString($string){

    $str1a = $string -match "^..."
    $str1a = $matches[0]
    #$str1a = $string.Substring(0,3)
    #$str1a = $string[0..2]

    $str1b = $string -match "...$"
    $str1b = $matches[0]
    #$str1b = $string.Substring(($string.Length - 3))
    #$str1b = $string[-3..-1]

    $str1 = "${str1a}${str1b}"

    $str2a = $string -split "^..."
    $str2 = $str2a -split "...$"
    #$str2 = $string.Substring(3,($string.length - 6))
    #$str2 = $string[3..($String.length - 4)]

    return $str1, $str2

}

function strUpcase($string){
    return $string.ToUpper()
}

function reverseStr($string){
    $charArray = $string -split ""
    [array]::Reverse($charArray)
    #$charArray = $string[-1..$($string.length * -1)]
    return ($charArray -join '')
}

$str1, $str2 = sliceString $string
$str1 = strUpcase $str1
$str2 = strUpcase $str2
$str1 = reverseStr $str1
$string = "$str2$str1"
Write-Host $string