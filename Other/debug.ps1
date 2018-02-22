$name="Kent"
$string="Hello"
$greeting="$string $name"
Write-Host $greeting


if ( (($g -gt $a) -and ($g -eq ($a * 2))) -or (($d -lt $g) -and ($g -eq $b*4))){
  $true
  }



  $var=21
  if ($var -gt  23){ Write-Host 4}
  elseif ($var -le 23){Write-Host 3}
  elseif ($var -eq 23){Write-Host 2}
  else{Write-Host 1}



  $var="blue"
  if ($var -eq "red"){$false}
  elseif ($var -ne "blue"){$true}


$var=1024
if ((($var -ge 1500) -and ($var -le 2048)) -or ($var -eq 1023+1)){Write-Host 1}
elseif ((($var -le 2000) -and ($var -gt 998)) -and ($var -eq 1022+2)){Write-Host 2}
elseif ((($var > 1) -and (var -lt 1000+25)) -or (var == 1024)){Write-Host 3}
else{Write-Host 4}


param($string)
$string="esestringehc"
function sliceString($string){
    $str1a = $string -match "^..."
    $str1a = $matches[0]
    $str1b = $string -match "...$"
    $str1b = $matches[0]
    $str1 = "$str1a$str1b"
    $str2 = $string -split "^..."
    $str2 = $str2 -split "...$"
    return $str1, $str2
}

function strUpCase($string){
    $string = $string.ToUpper()
    return $string
}

function reverseString($string){
    $charArray = $string -split ""
    [array]::Reverse($charArray)
    $string = $charArray –join ‘’
    return $string
}

$str1, $str2 = sliceString $string
$str1 = strUpCase $str1
$str2 = strUpCase $str2
$str1 = reverseString $str1
$string = "$str2$str1"
Write-Host "$string"


$a=7
Write-Host ($a-2)
function function1($a){
    $a--
    Write-Host $a
}
function function2($a){
    Write-Host $a
    $a += 2
    return $a
}
function function3($a){
    $a--
    Write-Host $a
    function function4(){
        $a = $global:a
        Write-Host $a
    }
    function4
}
function1 $a
$a=function2 $a
function3 $a
$a++
Write-Host $a


function my_function($a){
    $b=($a-2)
    return $b
}
$c=3
if ($c -gt 2){
    $d=my_function 5
}
Write-Host $a,$b,$c,$d

$var="global"
function outer(){
    function length($var){
        $num=0
        foreach($i in 1..($var.Length)){
            $num++
        }
        return $num
    }
    $var="local"
    function inner(){
        $Global:length
        $var="variable"
        return $var
    }
    $i=inner
    $var+=$i
    Write-Host "Var is a $var and has a length of "(length $var)
}
outer


$computername = $env:COMPUTERNAME
$ADSIComp = [adsi]”WinNT://$Computername”
$username = “TestUser”
$newUser = $ADSIComp.Create(‘User’,$username)
$newUser.SetPassword(“password”)
$newUser.SetInfo()



$file = Get-Item <path>
$dir = Get-Item <path>
$ar = New-Object System.Security.AccessControl.FileSystemAccessRule(“TestUser”,”FullControl”,”Allow”)
$fileAcl = $file.GetAccessControl()
$dirAcl = $dir.GetAccessControl()
$dirAcl.AddAccessRule($ar)
$fileAcl.AddAccessRule($ar)
$file.SetAccessControl($fileAcl)
$dir.SetAccessControl($dirAcl)
$file.GetAccessControl() | Format-List
$dir.GetAccessControl() | Format-List

try{
    [console]::TreatControlCAsInput=$true
    while($true){
    Start-Sleep 1
    }
} finally {
    [console]::TreatControlCAsInput=$false
    Write-Host "CTRL + c was pressed"
}











