."C:\Users\LocalAdmin\Documents\Scripting\PowerShell\8.2-Object-Oriented-Programming-and-Custom-Modules\Car.ps1"

function stepOntheGas($mph, $car){
    $currentSpeed = $car.getSpeed()
    foreach ($speed in ${currentSpeed}..${mph}){
        $car.speedUp()
        #Write-Host "Cars current speed: $($car.getSpeed())"
    }
}

function stepOntheBrake($mph, $car){
    $currentSpeed = $car.getSpeed()
    foreach ($speed in ${currentSpeed}..${mph}){
        $car.brake()
        #Write-Host "Cars current speed: $($car.getSpeed())"
    }
}

$car1 = [Car]::new("red", "Chevrolet", "Corvette", "2017")
$car2 = [Car]::new("white", "Ford", "Mustang", "2018")

$cars = $car1, $car2

foreach ($car in $cars){

    Write-Host "Cars color: $($car.getColor())"

    Write-Host "Painting car black..."
    $car.setColor("black")

    Write-Host "Cars new color: $($car.getColor())"

    Write-Host "Engine on: $($car.engineStatus)"

    Write-Host "Attempting to speed up the car to 60mph..."

    stepOntheGas 60 $car

    Write-Host "Starting engine..."
    $car.engine("start")

    Write-Host "Attempting to speed up the car to 60mph..."
    stepOntheGas 60 $car

    Write-Host "Slowing down..."
    stepOntheBrake 0 $car

    Write-Host "Turning off the engine..."
    $car.engine("Stop")

    Write-Host "Engine on: $($car.engineStatus)"
}