########################################################
# Name: Get-GroupsUsersDesc.ps1                              
# Creator: Hugo Monteiro
# CreationDate: 26.08.2016                              
# LastModified: 26.08.2016
# Version: 1.0                                         
# Doc: https://github.com/hcmonteiro/Various-Powershells/
#
# SCript that lists all groups with a name like ??
# Insert Where {$_.name -like "**"} if you whant all the groups
# with theis users
# It also posts the descriptions of the Groups
# 
# EXAMPLE
# Username	Group Location	Group Name	Name
# rnteixeira	@{Description=\\Shares\Unidade Negócio Educação\P&S}	FS UNE PeS_RW	Ricardo N. Teixeira
# jmferreira	@{Description=\\Shares\Unidade Negócio Educação\P&S}	FS UNE PeS_RW	João M. Ferreira
# haquadrado	@{Description=\\Shares\Unidade Negócio Educação\P&S}	FS UNE PeS_RW	Hugo A. Quadrado
# amcosta	@{Description=\\Shares\Unidade Negócio Educação\P&S}	FS UNE PeS_RW	Ana Mouta
# arpaulino	@{Description=\\Shares\Unidade Negócio Educação\P&S}	FS UNE PeS_RW	Ana R. Paulino
# nmandrade	@{Description=\\Shares\Unidade Negócio Educação\P&S}	FS UNE PeS_RW	Nuno M. Andrade
# jccouto	@{Description=\\Shares\Unidade Negócio Educação\P&S}	FS UNE PeS_RW	Jorge C. Couto
# agferreira	@{Description=\\Shares\Unidade Negócio Educação\P&S}	FS UNE PeS_RW	Andreia G. Ferreira
# haquintela	@{Description=\\Shares\Unidade Negócio Educação\P&S}	FS UNE PeS_RW	Helder A. Quintela
#   
#
# Version 1.0
########################################################
#
# hcmonteiro@live.com
#
########################################################
#
$Groups = (Get-AdGroup -filter * | Where {$_.name -like "FS UNE PES*"} | select name -ExpandProperty name)

$Table = @()

$Record = @{
  "Group Name" = ""
  "Group Location" = ""
  "Name" = ""
  "Username" = ""
}


Foreach ($Group in $Groups) {

  $Arrayofmembers = Get-ADGroupMember -identity $Group -recursive | select name,samaccountname

  foreach ($Member in $Arrayofmembers) {
    $Record."Group Name" = $Group
    $Record."Group Location" = (Get-ADGroup -identity $Group -Properties * | select Description)
    $Record."Name" = $Member.name
    $Record."UserName" = $Member.samaccountname
    $objRecord = New-Object PSObject -property $Record
    $Table += $objrecord

  }
}

$Table | export-csv "c:\IT-Main\SecurityGroups1.csv" -NoTypeInformation -Encoding Unicode