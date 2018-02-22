$value = Read-Host "Enter a value between 1-5"
switch($value){
    1{
        "The value is 1"
    }
    2{
        "The value is 2"
    }
    3{
        "The value is 3"
    }
    4{
        "The value is 4"
    }
    5{
        "The value is 5"
    }
    default{
        "Not a valid value"
    }
}