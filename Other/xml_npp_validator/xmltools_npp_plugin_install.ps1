if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { 
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; return 
 }

$scriptPath = Split-Path ((Get-Variable MyInvocation).Value).MyCommand.Path
$xmlToolsFolder = "${scriptPath}\Xml Tools 2.4.9.2 x86 Unicode"
$xmlToolsZip = "${xmlToolsFolder}.zip"
$CASE_STUDY_SCHEMA = "asset_case_study.xsd"
$CASE_STUDY_XML = "modExam_xml_template.xml"
$EXAM_SCHEMA = "asset_exam.xsd"
$QUESTION_POOL_SCHEMA = "asset_question_pool.xsd"
#$CurrentUser = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
#$AdminRole = [Security.Principal.WindowsBuiltInRole] “Administrator”
#$IsAdmin = $CurrentUser.IsInRole($AdminRole)


#Write-Host -f yellow "[*] Granting write permissions to the Notepad++ directory..."
#$path = 'C:\Program Files (x86)\Notepad++'
#$acl = Get-Acl $path
#$prop = New-Object System.Security.AccessControl.PropagationFlags
#$prop.value__ = 2
#$inheritance = New-Object System.Security.AccessControl.InheritanceFlags
#$inheritance.value__ = 1
#$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule('kgraves', 'FullControl', $inheritance, $prop, 'Allow')
#$acl.SetAccessRule($accessRule)
#Set-Acl -AclObject $acl $path

while (Get-Process | Select-String "notepad`+"){
    Write-Host -f red "[*] Please close Notepad++ to install plugins"
    pause
}

if (-not (Test-Path "${xmlToolsFolder}")){
    if (Test-Path "$xmlToolsZip"){
        Write-Host -f green "[*] Found zip: $xmlToolsZip"
        Start-Sleep 1
        Try{
            Write-Host -f yellow "[*] Expanding archive to ${xmlToolsFolder}..."
            Expand-Archive -path "$xmlToolsZip" -DestinationPath "$xmlToolsFolder"
        } Catch {
            if ( -not (Test-Path "$xmlToolsZip") ){
                $err = ${_}.Exception.Message
                Write-Host -f red "ERROR: $err"
                Write-Host -f red "[*] Unzip of $xmlToolsZip failed"
                pause
                Return
            }
        }
    } else {
        Write-Host -f red "ERROR: $xmlToolsZip does not exist"
        pause
        return
    }
} else {
    Write-Host --f yellow "[*] $xmlToolsZip already unzipped"
}

if (Test-Path "${env:ProgramFiles(x86)}\Notepad++" ){
    $NOTEPAD_DIR = "${env:ProgramFiles(x86)}\Notepad++"
} elseif (Test-Path "${env:ProgramFiles}\Notepad++" | Out-Null){
    $NOTEPAD_DIR = "${env:ProgramFiles}\Notepad++"
} else {
    Write-Host -f red "ERROR: Could not find Notepad++ installation"
    pause
    return
}

if ($NOTEPAD_DIR -ne $null){
    $nppPlugins = "${NOTEPAD_DIR}\plugins\"
    $nppMain = "${NOTEPAD_DIR}\"
    $xmlToolsdllFile = "XMLTools.dll"
    $xmlToolsdllPath = "${xmlToolsFolder}\${xmlToolsdllFile}"
    $xmlToolsDeps = "${xmlToolsFolder}\dependencies"

    Write-Host -f yellow "[*] Installing plugin..."
    Start-Sleep 1

    Try {
        Copy-Item "$xmlToolsdllPath" "$nppPlugins" -ErrorAction Stop
        Copy-Item "${xmlToolsDeps}\*" "$nppMain" -ErrorAction Stop
    } Catch {
        Write-Host -f red "ERROR: Could not copy xmltools files to the Notepad++ directory"
        pause
        return
    }
} else {
    Write-Host -f red "[*] Notepad++ is not installed"
    pause
    Return
}

$install = $false
if (Test-path "${nppPlugins}\${xmlToolsdllFile}"){
    Write-Host -f yellow "[*] Successfully installed ${xmlToolsdllFile}"
    Start-Sleep 1
    $install = $true
} else {
    Write-Host -f red "ERROR: Failed to install ${xmlToolsdllFile}"
    $install = $false
    Start-Sleep 1
}

$pluginFiles = Get-ChildItem "$xmlToolsDeps"

$pluginFiles | Foreach-Object { 
    if (Test-Path "${nppMain}\${_}"){
        Write-Host -f yellow "[*] Plugin file $_ successfully installed"
        $install = $true
        Start-Sleep 1
    } else {
         Write-Host -f red "ERROR: Plugin file $_ did not install"
         $install = $false
         Start-Sleep 1
    }
}

if ($install -eq $true){
    Write-Host -f Green "[*] Plugin Installation Complete"
    pause
    return
} else {
    Write-Host -f red "ERROR: Plugin installation failed"
    pause
    return
}
