import-module ./FileOperations.psm1

#globals
$global:directory
$global:path

#valide arguments from user input
if ($args.Length -eq 1){
    $directory = $args[0]    #set directory name
} else {
    #print usage if arguments weren't given
    Write-Host -f red "Usage: CreateFiles.ps1 /path"
    exit
}

#check if the directory exists
$res = Test-Path $directory
if (!$res){  #if directory does not exist
    while (1 -eq 1){
        Write-Host "$directory does not exist"
        $ans = Read-Host "Would you like to create it?[y/n]"
        #validate user input as y or n
        if ($ans -eq "y"){
            #make directory
            mkdir $directory
            Write-Host "Directory was created: $directory"
            break
        } elseif ($ans -eq "n"){
            Write-Host "Directory does not exist"
            exit
        } else {
            Write-Host "Invalid Response"
            continue
        }

    }
}

#create path to file
$path = $directory+"/file"
foreach ($i in 1..20){
    $fileName = $path+$i    #create name of file
    if (!(Test-Path $fileName)){               #check if file exists
        mkfile $fileName    #create the file
        Write-Host "Created file: $fileName"
        #Write to the file
        writeFile $fileName "file${i}: This is an Exercise"
        Write-Host "Wrote to file: $fileName"
    } else {
        Write-Host "$fileName already exists"
        continue
    }
}

#get a list of files in the directory
$files = Get-ChildItem $directory
Write-Host "Listing contents of ${directory}:`n"
foreach ($i in $files){
    Write-Host $i
}

#read the contents of each file and print
foreach ($i in $files){
    $contents = Get-Content "${directory}/${i}"
    Write-Host "$contents"
}