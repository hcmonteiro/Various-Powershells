#
# Criação de novo disco na Pool
#
$SSD = Get-StorageTier -FriendlyName Microsoft_SSD_Template
$HDD = Get-StorageTier -FriendlyName Microsoft_HDD_Template
$DISKNAME = "DiskWNONOC1GB"
New-VirtualDisk -StoragePoolFriendlyName "Pool01" -FriendlyName $DISKNAME -StorageTiers @($SSD, $HDD) -StorageTierSizes @(100GB, 1TB) -ResiliencySettingName Mirror -WriteCacheSize 1GB

Start-Sleep -Second 5

Get-VirtualDisk $DISKNAME  | Get-Disk | Set-Disk -IsReadOnly 0

Get-VirtualDisk $DISKNAME  | Get-Disk | Set-Disk -IsOffline 0

Get-VirtualDisk $DISKNAME  | Get-Disk | Initialize-Disk -PartitionStyle GPT

Start-Sleep -Second 2

Get-VirtualDisk $DISKNAME  | Get-Disk | New-Partition -DriveLetter “L” -UseMaximumSize

Start-Sleep -Second 2

Initialize-Volume -DriveLetter “L” -FileSystem NTFS -Confirm:$false

Start-Sleep -Second 2

Set-Volume -DriveLetter L -NewFileSystemLabel $DISKNAME

#Get-StorageTier -FriendlyName *HDD*

