$a = Get-WMIObject -query "Select * From Win32_Printer Where ShareName = 'HQ-MFP-CO-A3-21'"
$a.SetDefaultPrinter()
Remove-Printer *srv-print*