function getUserName($first, $middle, $last){

    $first = $first.substring(0,1)
    $middle = $middle.substring(0,1)
    $last = $last.substring(0,5)

    $userName = $first+$middle+$last
    return $userName.ToLower()
}

function createUser($username){
    $defaultPassword = $username+"2017!"
    NET USER $username "$defaultPassword" /ADD
}

Export-ModuleMember -Verbose -Function getUserName
Export-ModuleMember -Verbose -Function createUser