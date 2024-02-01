$csvPath = ".\printers.csv"


function Install-Printers {
    param (
        [string]$csvPath
    )

    $Printers = Import-Csv -path $csvPath

    foreach($row in $Printers){
        
        # Add printer by IP Address
        Add-Printer -IppURL $row.IPAddress
        $Printer = Get-Printer -Name $row.OriginalPrinterName

        # Rename printer name, the orignal printer name will be the name setup on the printer, we need to update it
        #Rename-Printer -Name $printer.Name -NewName $row.PrinterName
        # Set Port and Driver for the printer

        #$RenamedPrinter = Get-Printer -Name $row.PrinterName

        $Ports = Get-PrinterPort

        if(!($Ports.Name -ne $row.IPAdress)){
            Add-PrinterPort -Name $row.IPAddress -PrinterHostAddress $row.IPAddress
        }

        Set-Printer -Name $Printer.Name -PortName $row.IPAddress -DriverName $row.PrinterDriverName

        Rename-Printer -Name $Printer.Name -NewName $row.PrinterName
        
        

    }
    
}

Install-Printers -csvPath $csvPath