# Author: Kentgrav 10/1/2017
# Inspired by caizer68's Batch script re-posted by Iggy_2539 on /r/pcmasterrace
# https://www.reddit.com/r/pcmasterrace/comments/736tfh/skype_is_officially_bloatware_uninstalled_it/dno65sy/?context=3

# In order to execute this sript you may need to run the following command as an Administrator:
# Set-ExecutionPolicy Unrestricted

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    pause
    exit
}

Write-Host -f cyan "`nWindows Cleanup v1.0`n"
Write-Host -f white "This script will attempt to clean the following unnecessary Windows features:`n"
Write-Host -f yellow "Stoping and Disable Services"
Write-Host -f yellow "Disabling Scheduled Tasks"
Write-Host -f yellow "Removing Windows Applications"
Write-Host -f yellow "Uninstalling Programs"
Write-Host -f yellow -NoNewline "Deleting Directories and Files "
Write-Host -f white "(Associated with uninstalled apps and programs)"
Write-Host -f yellow "Modifying Registry Entries`n"

while ($true) {
    $input = Read-Host "Would you like to create a system restore point before we begin? [y/n]"
    if ($input -eq "y"){
        Write-Host -f yellow "Creating restore point..."
        Enable-ComputerRestore -Drive $env:HOMEDRIVE
        Checkpoint-Computer -Description "Prior to Windows Cleanup" -RestorePointType MODIFY_SETTINGS 
        if ( (((Get-EventLog -InstanceId 8194 -LogName Application -Newest 1).TimeGenerated) -split ' ')[0] -eq ((date) -split ' ')[0] ){
            Write-Host -f green "[*] Successfully created restore point"
            Write-Host -f yellow "To restore your system simply run the following command:`n`nRestore-Computer (Get-ComputerRestorePoint)[-1].SequenceNumber"
            break
        } else {
            Write-Host -f red "ERROR: Failed to create restore point!"
            pause
            exit
        }
    } elseif ($input -eq "n"){
        Write-Host -NoNewline -f Yellow "Are you sure you want to continue without creating a restore point? [y/n]"
        $input = read-Host
        if ($input -eq "n"){
            continue
        } elseif ($input -eq "y") {
            break
        } else {
            Write-Host -f red "ERROR: Invalid input"
            continue
        }
    } else {
        Write-Host -f red "ERROR: Invalid input"
        continue
    }
}

#List of Services to Stop
$stopServices = (
    'DiagTrack',
    'diagnosticshub.standardcollector.service',
    'dmwappushservice',
    'WMPNetworkSvc',
    'WSearch'
)

#Stop services listed above
$stopServices | % { 
    Write-Host -f Yellow "Stopping service: ${_}"
    Stop-Service $_ -ErrorAction SilentlyContinue | Out-Null
    if ($? -eq $false){
            Write-Host -f red "ERROR: Unable to stop: $_"
    }
}

#List of services to disable
$disableServices = (
    #Windows Defender
    #'WinDefend',

    #Windows Tracking Services
    'DiagTrack',
    'diagnosticshub.standardcollector.service',
    'TrkWks',
    'WMPNetworkSvc',

    #WAP Push Message Routing Service
    'dmwappushservice',

    #Disable remote registry query
    'RemoteRegistry', 

    #Windows Search
    'WSearch',

    #Superfetch
    'SysMain'

)

$disableServices | % {
    Write-Host -f Yellow "Disabling service: $_"
    Set-Service $_ -StartupType Disabled -ErrorAction SilentlyContinue | Out-Null
    if ($? -eq $false){
            Write-Host -f red "ERROR: Unable to disable: $_"
    }
}

# Disable Scheduled Tasks
$disableTasks = (

    "Microsoft\Windows\AppID\SmartScreenSpecific",
    "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
    "Microsoft\Windows\Application Experience\ProgramDataUpdater",
    "Microsoft\Windows\Application Experience\StartupAppTask",
    "Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
    "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask",
    "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip",
    "Microsoft\Windows\Customer Experience Improvement Program\Uploader",
    "Microsoft\Windows\Shell\FamilySafetyUpload",
    "Microsoft\Office\OfficeTelemetryAgentLogOn",
    "Microsoft\Office\OfficeTelemetryAgentFallBack",
    "Microsoft\Office\Office 15 Subscription Heartbeat",
     "Microsoft\Windows\Autochk\Proxy",
    "Microsoft\Windows\CloudExperienceHost\CreateObjectTask",
    "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector",
    
    #Not sure if should be disabled, maybe related to S.M.A.R.T.
    #"Microsoft\Windows\DiskFootprint\Diagnostics",
    
    "Microsoft\Windows\FileHistory\File History (maintenance mode)",
    "Microsoft\Windows\Maintenance\WinSAT",
    "Microsoft\Windows\NetTrace\GatherNetworkInfo",
    "Microsoft\Windows\PI\Sqm-Tasks",
    
    
    "Microsoft\Windows\Time Synchronization\ForceSynchronizeTime",
    "Microsoft\Windows\Time Synchronization\SynchronizeTime",
    "Microsoft\Windows\Windows Error Reporting\QueueReporting",
    "Microsoft\Windows\WindowsUpdate\Automatic App Update",

    #Microsoft Malicious Software Removal Tool
    "Microsoft\Windows\RemovalTools\MRT_HB"
)

#Disable the scheduled tasks listed above
$disableTasks | % {
    Write-Host -f Yellow "Disabling Scheduled Task: $_"
    Disable-ScheduledTask $_ -ErrorAction SilentlyContinue | Out-Null
    if ($? -eq $false){
            Write-Host -f red "ERROR: Unable to disable: $_"
    }
}

# List of apps to Remove
$apps = (
    '*people*',
    '*zune*',
    '*bing*',
    '*Messaging*',
    '*Facebook*',
    '*Twitter*',
    '*solitaire*',
    '*officehub*',
    '*Skype*',
#    '*OneNote*',
    '*WindowsCamera*',
    '*WindowsAlarms*',
    '*WindowsSoundRecorder*',
    '*windowscommunicationsapps*',
    '*WindowsMaps*',
    '*sway*',
    '*commsphone*',
#    '*WindowsCalculator*',
    '*phone*',
    '*ConnectivityStore*',
    '*Drawboard PDF*',
    '*getstarted*',
    '*3dbuilder*',
    '*pdf*',
    '*paint*',
    '*nytcrossword*',
    '*xbox*',
    '*SurfaceHub*',
    '*flipboard*'
)

#Remove the apps listed above
$apps | % {
    Write-Host -f Yellow "Removing application: $_"
    if (Get-AppxPackage $_){
        Get-AppxPackage $_ -ErrorAction SilentlyContinue | Remove-AppxPackage -ErrorAction SilentlyContinue | Out-Null
        if ($? -eq $false){
            Write-Host -f red "ERROR: Unable to remove: $_"
        }
    }
}

# List of Windows Programs to uninstall
$programs = (
    "C:\Windows\SysWOW64\OneDriveSetup.exe"
)

# Uninstall the list of programs above
$programs | % {
    Write-Host -f Yellow "Uninstalling program: $_"
    Start-Process -Wait $_ -ArgumentList "/UNINSTALL" | Out-Null
    if ($? -eq $false){
            Write-Host -f red "ERROR: Unable to uninstall: $_"
    }
}


#List of directories and files to delete
$files = (
    "C:\OneDriveTemp",
    "$env:USERPROFILE\OneDrive",
    "$env:LOCALAPPDATA\Microsoft\OneDrive",
    "$env:PROGRAMDATA\Microsoft OneDrive"
)

$files | % {

    if (Test-Path $_){
        Write-Host -f Yellow "Removing files: $_"
        Remove-Item $_ -Recurse -Force | Out-Null
        if ($? -eq $false){
            Write-Host -f red "ERROR: Unable to remove: $_"
        }
    }

}

# The stubborn task Microsoft\Windows\SettingSync\BackgroundUploadTask can be Disabled using a simple bit change. I use a REG file for that (attached to this post).


# List of registry entries to modify in order to remove Telemetry & Data Collection
$registryEntries = (
    
    #Disable Cortana
    ("HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search", "AllowCortana", 1),
    ("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search","CortanaEnabled", 0),

    #Bing Start Menu Search
    ("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search", "BingSearchEnabled", 0),

    #Prevent Windows From Downloading Broken Drivers From Windows Update
    ("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata", "PreventDeviceMetadataFromNetwork", 1),

    # Telemetry Diagnostic and usage data
    ("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection", "AllowTelemetry", 0),
    ("HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection", "AllowTelemetry", 0),
    ("HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience\Program-Telemetry", "Enabled", 0),
    ("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat", "DisableUAR", 1),
    ("HKLM\SOFTWARE\Policies\Microsoft\MRT", "DontOfferThroughWUAU", 1),
    ("HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener", "Start", 0),
    ("HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger", "Start", 0),

    # Cortana Telemetry
    ("HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0", "f!dss-winrt-telemetry.js", 0),
    ("HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0", "f!proactive-telemetry.js", 0),
    ("HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0", "f!proactive-telemetry-event_8ac43a41e5030538", 0),
    ("HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0", "f!proactive-telemetry-inter_58073761d33f144b", 0),
  

     # Disable Customer Experience Improvement Telemetry (CEIP/SQM - Software Quality Management)
    ("HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows", "CEIPEnable", 0),

    # Disable Application Impact Telemetry (AIT)
    ("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat", "AITEnable", 0),

    #Get fun facts, tips, tricks, and more on your lock screen (ADs) / Windows Spotlight
    ("HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager", "RotatingLockScreenEnabled", 0),
    ("HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager", "RotatingLockScreenOverlayEnabled", 0),
    
    # Get tips, tricks, and suggestions as you use Windows (ADs) / Can cause high disc usage via a process System and compressed memory
    ("HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager", "SoftLandingEnabled", 0), 

    # Shows occasional suggestions in Start menu (ADs)
    ("HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager", "SystemPaneSuggestionsEnabled",0),

    # Disable AD customization: Settings -> Privacy -> General -> Let apps use my advertising ID...
    ("HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo", "DisabledByGroupPolicy", 1),
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo", 'Enabled', 0),

    # SmartScreen Filter for Store Apps: Disable
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost", 'EnableWebContentEvaluation', 0),

    # Let websites provide locally...
    ("HKCU:\Control Panel\International\User Profile", 'HttpAcceptLanguageOptOut', 1),

    # WiFi Sense: HotSpot Sharing: Disable
    ("HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting", 'value', 0),

    # WiFi Sense: Shared HotSpot Auto-Connect: Disable
    ("HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots", 'value', 0),

    # Change Windows Updates to "Notify to schedule restart"
    ("HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings", 'UxOption', 1),

    #Disable P2P Update downlods outside of local network
    ("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config", 'DODownloadMode', 0),

    # Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for ***
    # 0 = hide completely, 1 = show only icon, 2 = show long search box
    #("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search", "SearchboxTaskbarMode", 0),

    # *** Disable MRU lists (jump lists) of XAML apps in Start Menu ***
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "Start_TrackDocs", 0),

    # *** Set Windows Explorer to start on This PC instead of Quick Access ***
    # 1 = This PC, 2 = Quick access
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "LaunchTo", 1),

    # Keys related to onedrive uninstall
    ("HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder", "Attributes", 0),
    ("HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder", "Attributes", 0),
    
    #Microsoft Malicious Software Removal Tool
    ("HKLM:\SOFTWARE\Policies\Microsoft\MRT", 'DontOfferThroughWUAU', 1)
)

# Modify Registry Entries using the List above
# 0 = Registry Path, 1 = Registry Key Name, 2 = Key Value
$registryEntries | % { 
    
    if (Test-Path $_[0]){ 

        #If registry entry exists then modify it
        Write-Host -f Yellow "Modifying Registry Key: $($_[0])\$($_[1])"
        Set-ItemProperty -Path "$($_[0])" -Name "$($_[1])" -Value "$($_[2])" -Force -ErrorAction SilentlyContinue | Out-Null
        if ($? -eq $false){
            #Get-ItemProperty -Path "$($_[0])" -Name "$($_[1])" -ErrorAction SilentlyContinue
            Write-Host -f red "ERROR: Unable to modify: $($_[0])\$($_[1])"
        }
    }
 }

# Restart Windows Explorer

Write-Host -f yellow "`nWindows Explorer needs to be restarted..."
pause
Stop-Process -name explorer -Force

Write-Host -f green "`nCleanup is Complete`n"