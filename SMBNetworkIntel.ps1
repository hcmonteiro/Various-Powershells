# Lista as configuraçoes da placa de rede -Name <nome>
Get-NetAdapterAdvancedProperty -Name SAN10G#1 | ft Name, InterfaceDescription, Displayname, DisplayValue, DefaultDisplayValue, ValidDisplayValues, RegistryValue, DefaultRegistryValue, ValidRegistryValues -auto | Out-File -Width 4000 C:\dep-it\Nics.txt
# Muda as configurações da placa de rede 
Set-NetAdapterAdvancedProperty -Name SAN10G#1 -DisplayName "Jumbo Packet" -DisplayValue "9014 Bytes"
Set-NetAdapterAdvancedProperty -Name SAN10G#1 -DisplayName "Maximum Number of RSS Queues" -DisplayValue "8 Queues"
Set-NetAdapterAdvancedProperty -Name SAN10G#1 -DisplayName "Interrupt Moderation Rate" -DisplayValue "Off"
#A tribuir IP às Placas de rede
New-NetIPAddress -InterfaceAlias "SAN10G#1" -IPAddress "172.16.12.62" -PrefixLength 24