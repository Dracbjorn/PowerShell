If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")){   
    $script = {
        $path = 'C:\Program Files (x86)\Notepad++'
        $acl = Get-Acl $path
        $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule('kgraves','FullControl','Allow')
        $acl.SetAccessRule($accessRule)
        Set-Acl -AclObject $acl $path
    }
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -ScriptBlock $script" -Verb RunAs
    return
}

