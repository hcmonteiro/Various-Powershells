########################################################
# Name: RemovePrinter.ps1                              
# Creator: Hugo Monteiro
# CreationDate: 18.08.2016                              
# LastModified: 18.08.2016
# Version: 1.0                                         
# Doc: https://github.com/hcmonteiro/Various-Powershells/
#
# First it sets the default printer to HQ-MFP-CO-A3-21 (change to your printer)
# Then it removes all the printers from the print server srv-print
# 
# 
# 
#   
#
# Version 1.0
########################################################
#
# hcmonteiro@live.com
#
########################################################
$a = Get-WMIObject -query "Select * From Win32_Printer Where ShareName = 'HQ-MFP-CO-A3-21'"
$a.SetDefaultPrinter()
Remove-Printer *srv-print*