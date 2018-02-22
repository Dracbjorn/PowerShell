function declareValue{
    $private:var = 1
    write-host "Scope function declareValue: var=$var"
    function getValue{
        write-host "Scope function getValue: var=$var"
        function setValue{
            $global:var = 2
            write-host "Scope function setValue: var=$var"
        }
        setValue
    }
    getValue
}
declareValue
write-host "Scope Global: var=$var"
"------------------"