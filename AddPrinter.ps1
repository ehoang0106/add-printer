$csvPath = ".\printers.csv"


function Install-Printers {
    param (
        [string]$csvPath
    )

    $Printers = Import-Csv -path $csvPath

    foreach($row in $Printers){
        # Add printer by IP Address
        Add-Printer -IppURL $row.IPAddress
        $printer = Get-Printer -Name $row.OriginalPrinterName

        # Rename printer name, the orignal printer name will be the name setup on the printer, we need to update it
        Rename-Printer -Name $printer.Name -NewName $row.PrinterName
        # Set Port and Driver for the printer
        $RenamedPrinter = Get-Printer -Name $row.PrinterName

        Set-Printer -Name $RenamedPrinter.Name -PortName $row.IPAddress -DriverName $row.PrinterDriverName
        

    }
    
}

Install-Printers -csvPath $csvPath