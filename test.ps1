$csvPath = ".\printers.csv"


function Install-Printers {
    param (
        [string]$csvPath
    )

    $Printers = Import-Csv -path $csvPath

    foreach($row in $Printers){
        if(Get-PrinterPort -Name "11.0.0.69"){
            write-host "asd"
        }
        else {
            write-host "zxc"
        }
        
        

    }
    
}

Install-Printers -csvPath $csvPath