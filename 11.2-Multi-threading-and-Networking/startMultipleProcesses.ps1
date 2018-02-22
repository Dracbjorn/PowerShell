$script = {
    & 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
}

foreach ($count in 1..10){
    Start-Job $script
}

while (Get-Job -State "Running"){
    Start-Sleep 1
}

#Get-Job | Remove-Job -Force
Write-Host "Jobs have completed"
