Class Toaster {

  note -static ObjectCount 0

  method -static DisplayObjectCount {
    "$($this.ClassName) has created $($this.ObjectCount) toasters"
  }

  note -private toasterColor
  note -private toastingLevel
  note -private numberOfToastingSlots
  note -private pluggedIn
  note -private currentlyToasting

  constructor {
    param ($toasterColor,$numberOfToastingSlots)

    $private.toasterColor = $toasterColor
    $private.numberOfToastingSlots = $numberOfToastingSlots
    
    $private.toastingLevel = 1
    $private.pluggedIn = "No"
    $private.currentlyToasting = "No"

    $ToasterClass.objectCount += 1
  }

  property toasterColor -get {
    $private.toasterColor
  }

  property numberOfToastingSlots -get {
    $private.numberOfToastingSlots
  }
  
  property toastingLevel -get {
    $private.toastingLevel
  }

  property pluggedIn -get {
    $private.pluggedIn
  }

  property currentlyToasting -get {
    $private.currentlyToasting
  }

  method changeLevel {
    param ($newLevel)
    if (($newLevel -le 5) -and ($newLevel -ge 1)){
      $private.toastingLevel = $newLevel
    } else {
      Write-Host "Invalid Toasting Level.  Must be Level 1-5."
    }
  }

  method plugIn {
    $private.pluggedIn = "Yes"
  }

  method unPlug {
    $private.pluggedIn = "No"
  }

  method startToasting {
    $private.currentlyToasting = "Yes"
    switch ($private.toastingLevel) 
    { 
        1 {"Toasting for 1 minute"
            Start-Sleep -s (60*1)
            $private.cancelToasting} 

        2 {"Toasting for 2 minutes"
            Start-Sleep -s (60*2)
            $private.cancelToasting} 

        3 {"Toasting for 3 minutes"
            Start-Sleep -s (60*3)
            $private.cancelToasting} 

        4 {"Toasting for 4 minutes"
            Start-Sleep -s (60*4)
            $private.cancelToasting} 
 
        5 {"Toasting for 5 minutes"
            Start-Sleep -s (60*4)
            $private.cancelToasting} 
 
        default {"Invalid Toasting Level.  Must be Level 1-5."
                   $private.cancelToasting}
    }
  }

  method stopToasting {
    $private.currentlyToasting = "No"
    Write-Host "Toasting Complete"
  }

  method -override ToString {
    "A $($this.Class.ClassName) named $($this.name) has the following statuses:"
    "Toaster Color: $($this.toasterColor)"
    "Toasting Level: $($this.toastingLevel)"
    "Number of Toasting Slots: $($this.numberOfToastingSlots)"
    "Plugged In: $($this.pluggedIn)"
    "Currently Toasting: $($this.currentlyToasting)"
  }
}