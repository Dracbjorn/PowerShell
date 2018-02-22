Class Car{
    [String]$vin
    static [int]$numberOfWheels = 4
    [int]$numberOfDoors
    [datetime]$year
    [String]$model
    [MakeOfCar]$make
    [ColorOfCar]$color
}

Enum MakeOfCar{
    Chevy = 1
    Ford = 2
    Olds = 3
    Toyota = 4
    BMW = 5
}

Enum ColorOfCar{
    Red = 1
    Blue = 2
    Green = 3
}

$a = [car]::New()
$a.color = 1
$a.make = 2
$a.make = "bmw"

$a