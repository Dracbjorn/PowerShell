class UserManagement{}

function getUserName($first, $middle, $last){
    $first = $first.substring(0,1)
    $middle = $middle.substring(0,1)
    $last = $last.substring(0,5)

    $username = $first+$middle+$last
    return $username.ToLower()
}

function createUser($username){
    $defaultPassword = $username+"1017!"
    NET USER $username "$defaultPassword" /ADD
    return $?
}

#Export-ModuleMember -Verbose -Function getUserName
#Export-ModuleMember -Verbose -Function createUser

#$adsi = [ADSI]"WinNT://$env:COMPUTERNAME"
#$adsi.Children | where {$_.SchemaClassName -eq 'user'} | Foreach-Object {
#    $groups = $_.Groups() | Foreach-Object {$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)}
#    $_ | Select-Object @{n='UserName';e={$_.Name}},@{n='Groups';e={$groups -join ';'}}
#}

#OR

#net user tkgrave