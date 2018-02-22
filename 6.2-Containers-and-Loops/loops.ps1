#for ($var = 10;$var -gt 0;$var--){
#    Write-Host $var
#}

#for (;;){
#    Write-Host Loop
#}

foreach ($file in (Get-Childitem C:\)){
    Write-Host $file
}

Get-Childitem C:\ | ? { $_ | select-string "Program" }

Get-Process | % {$_.ProcessName}

Get-Process | ? {$_.ProcessName -eq "chrome"}

Get-Process | Where-Object -Property ProcessName -EQ -Value "chrome"