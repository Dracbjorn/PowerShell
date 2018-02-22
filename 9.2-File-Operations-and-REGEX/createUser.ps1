Easy way out
NET USER TestUser "password" /ADD

#The PS method
$computerName = $env:COMPUTERNAME
$ADSIComp = [adsi]"WinNT://$ComputerName"
$username = "TestUser"
$newUser = $ADSIComp.Create('User', $username)
$newUser.SetPassword("password")
$newUser.SetInfo()
