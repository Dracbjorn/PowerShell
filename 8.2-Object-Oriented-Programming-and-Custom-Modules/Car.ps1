class Car{

    [String]$color
    [int]$speed
    [String]$make
    [String]$model
    [int]$year
    [bool]$engineStatus

    Car([String]$color,[String]$make,[String]$model,[int]$year){
        $this.color = $color
        $this.make = $make
        $this.model = $model
        $this.year = $year
        $this.engineStatus = $false
        $this.speed = 0
    }

    [String] getColor(){
        return $this.color
    }

    [Void] setColor($color){
        $this.color = $color
    }

    [Void] speedUp(){
        if ($this.engineStatus -eq $true){
            $this.speed++
        }
    }

    [Void] brake(){
        if ($this.speed -gt 0){
            $this.speed--
        }
    }

    [Int] getSpeed(){
        return $this.speed
    }

    [Void] engine($status){
        if ($status -eq "start"){
            $this.engineStatus = $true
        } elseif ($status -eq "stop"){
            $this.engineStatus = $false
        }
    }

}