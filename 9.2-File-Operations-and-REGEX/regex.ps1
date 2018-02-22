$ipList = (
  '192.168.122.1',
  '192.1111.22.1', 
  '10.11.32.254',
  '172.16.15.14', 
  '192,168,1,1',
  '255.255.255255', 
  '10.301.256',
  '301.999.999.999',
  '0.168.0.1',
  '192.168.1.255',
  '10.11.1.0'
)

$pattern = [regex]"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

$ipList | % {

    Write-Host "Evaluating $_..."

    #Method 1
    #$_ -match "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

    #Method 2
    if (($pattern.match($_)).Success){
        $valid = $true
        $octets = $_ -split "\."
        $octets | % {
            [int]$num = $_
            if ( ($num -lt 0) -or ($num -gt 255) ){
                Write-Host "$num is less than 0 or greater than 255"
                $valid = $false
            }
        }

        if ( ( ($octets[3] -as [int]) -eq 255) -or ( ($octets[3] -as [int]) -eq 0) -or ( ($octets[0] -as [int]) -eq 0) ){
            Write-Host "4th octet '$($octets[3])' equals 255 or 0 or 1st octet '$($octets[0])' equals 0"
            $valid = $false
        }

        $octets.Clear()

    } else {
        Write-Host "Does not match IP pattern"
        $valid = $false
    }

    $matches = $null

    if ($valid -eq $true){
        Write-Host -f green VALID: $_
    } elseif ($valid -eq $false) {
        Write-Host -f red INVALID: $_
    } else {
        Write-Host -f red "ERROR: Validity not set!"
    }

    $valid = $null

    Write-Host
}

