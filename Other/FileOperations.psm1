function mkdir($path){
    New-Item -type Directory -path $path
}

function mkfile($path){
    New-Item -type file -path $path
}

function writefile($path,$string){
    $string | Add-Content -path $path
}