Class Toaster{
    static [int]$numberOfToasters = 0
    [String]$toasterColor
    [int]$numberOfToastingSlots
    [int]$toastingLevel
    [bool]$pluggedIn
    [bool]$currentlyToasting

    Toaster([String]$toasterColor, [int]$numberOfToastingSlots){
        $this.toasterColor = $toasterColor
        $this.numberOfToastingSlots = $numberOfToastingSlots
        $this.toastingLevel = 0
        $this.pluggedIn = $false
        $this.currentlyToasting = $false
        [Toaster]::addToaster()
    }

    [String] getColor(){
        return $this.toasterColor
    }

    [void] toast([bool]$action){
        
        if ($action){
            $this.currentlyToasting = $true
        } else{
            $this.currentlyToasting = $false
        }
    }

    static [void] addToaster(){
        [Toaster]::numberOfToasters += 1
    }
}