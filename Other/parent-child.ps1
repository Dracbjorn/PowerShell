Write-Host "-Global Scope"
$globalVar = "varGlobal"
Write-Host "-globalVar defined"
function function1{
    Write-Host "--Local Scope function1"
    $var1 = "varFunction1"
    Write-Host "--var1 defined"
    Write-Host $globalVar
    function function2{
        Write-Host "---Local Scope function2"
        Write-Host $globalVar
        Write-Host $var1
        $var2 = "varFunction2"
        Write-Host "---var2 defined"
        function function3{
            Write-Host "----Local Scope function3"
            Write-Host $globalVar
            Write-Host $var1
            Write-Host $var2
            $var3 = "varFunction3"
            Write-Host "----var3 defined"
            function function4{
                Write-Host "-----Local Scope function4"
                Write-Host $globalVar
                Write-Host $var1
                Write-Host $var2
                Write-Host $var3
                $var4 = "varFunction4"
                Write-Host "-----var4 defined"
            }
            function4
        }
        function3
        Write-Host $var4
    }
    function2
}
function1