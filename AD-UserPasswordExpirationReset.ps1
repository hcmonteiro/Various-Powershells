# Script: AD-UserPasswordExpirationReset.ps1
# Parameters: Username
#
# By:JClemente
# Last edit: 2016-08-16 11:00
# Edited: Hugo Monteiro
# Version 1.1
#
# Use Example:
# .\AD-UserPasswordExpirationReset.ps1 hmmonteiro.test
Param ($ThisUser)
If ($ThisUser) {
    $User = Get-ADUser $ThisUser -properties pwdlastset
    $OldExpirationDate = [datetime]::FromFileTime($User.pwdlastset).ToString("g")
    $Msg = "Reseting password expiration date of " + $User.name + " user account..."
    Write-Host `n$Msg
    $User.pwdlastset = 0 
    Set-ADUser -Instance $User 
    $User.pwdlastset = -1 
    Set-ADUser -instance $User
    $User = Get-ADUser $ThisUser -properties pwdlastset
    $NewExpirationDate = [datetime]::FromFileTime($User.pwdlastset).ToString("g")
    Write-Host "Password last set date changed from $OldExpirationDate to $NewExpirationDate`n" -ForegroundColor Green
} else {
    Write-Host "`nNothing done! Please specify user name parameter.`n" -ForegroundColor Yellow
}
