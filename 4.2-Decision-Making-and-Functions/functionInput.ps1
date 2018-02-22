#Defining function input parameters

function myFunction($string1, $string2){    #Method 1
    #param($string1, $string2)               #Method 2

    Write-Host $string1 $string2

}

#Function Calls

myFunction("Hello", "World")    #Method 1
myFunction "Hello" "World"      #Method 2

"======================================"