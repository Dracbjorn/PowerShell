function touch ($path){
    New-Item -path "$path" -type file
}

function rm ($path){
    Remove-Item "$path"
}

function ls ($path) {
    Get-ChildItem -Path "$path"
}

Export-ModuleMember -Function 'touch'
Export-ModuleMember -Function 'rm'
Export-ModuleMember -Function 'ls'
#Appended Comment
