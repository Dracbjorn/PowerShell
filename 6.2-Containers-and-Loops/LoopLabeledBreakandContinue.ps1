:mainLoop while ($true){
   sleep 1
   Write-Host -f cyan "Main"
   :firstInner while ($true){
     sleep 1
     Write-Host -f green "firstInner"
     $count=0
     :secondInner while ($true){
       $count++
       sleep 1
       Write-Host -f magenta "secondInner"
       if ($count -eq 3){
         continue mainloop
       }
     }
   }
 }