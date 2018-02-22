$script = {
        $path = 'C:\Program Files (x86)\Notepad++'
        $acl = Get-Acl $path
        $prop = New-Object System.Security.AccessControl.PropagationFlags
        $prop.value__ = 2
        $inheritance = New-Object System.Security.AccessControl.InheritanceFlags
        $inheritance.value__ = 1
        $accessRule = New-Object System.Security.AccessControl.RemoveAccessRule('kgraves', 'FullControl', $inheritance, $prop, 'Allow')
        $acl.SetAccessRule($accessRule)
        Set-Acl -AclObject $acl $path
    }
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command $script" -Verb RunAs