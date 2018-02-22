function New-File ($fileName,$directory) {
    #Create a new file in a specific directory
    New-Item -path "${directory}\${fileName}" -type file
}

function Remove-File ($filename,$directory) {
    #Remove a file in a specific directory
    Remove-Item "${directory}\${fileName}"
}

function Get-File ($directory) {
    #List files in a directory
    Get-ChildItem -Path "${directory}"
}

Export-ModuleMember -Function 'New-File'
Export-ModuleMember -Function 'Remove-File'
Export-ModuleMember -Function 'Get-File'