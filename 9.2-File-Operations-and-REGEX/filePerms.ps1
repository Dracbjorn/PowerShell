$file = Get-Item ${HOME}/TEST/testfile.txt
$dir = Get-Item ${HOME}/TEST

$ar = New-Object System.Security.AccessControl.FileSystemAccessRule("TestUser", "FullControl", "Allow")

$fileAcl = $file.GetAccessControl()
$dirAcl = $dir.GetAccessControl()

$fileAcl.AddAccessRule($ar)
$dirAcl.AddAccessRule($ar)

$file.SetAccessControl($fileAcl)
$dir.SetAccessControl($dirAcl)

$file.GetAccessControl() | Format-List
$dir.GetAccessControl() | Format-List
