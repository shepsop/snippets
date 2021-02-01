#enabling WinRM and PS Remoting
Enable-PSRemoting

Invoke-Command -ComputerName dc01 {$env:computername}
Invoke-Command -ComputerName dc01 {$var=10}
Invoke-Command -ComputerName dc01 {$var}

#Filter on remote and perform actions or strange results
Invoke-Command -ComputerName dc01 -ScriptBlock {get-eventlog -logname security} | select-object -First 10
Invoke-command -computername dc01 -scriptblock {get-eventlog -logname security | select-object -first 10}
Invoke-command -computername dc01 -scriptblock {get-eventlog -logname security -newest 10}

Invoke-Command -ComputerName dc01 -ScriptBlock {get-process} | where {$_.name -eq "notepad"} | Stop-Process
Invoke-Command -ComputerName dc01 -ScriptBlock {get-process | where {$_.name -eq "notepad"} | Stop-Process }

Measure-Command {Invoke-Command -ComputerName dc01 -ScriptBlock {get-process} | where {$_.name -eq "notepad"} }
Measure-Command {Invoke-Command -ComputerName dc01 -ScriptBlock {get-process | where {$_.name -eq "notepad"}} }

#Sessions
$session = New-PSSession -ComputerName dc01
Invoke-Command -SessionName $session {$var=10}
Invoke-Command -SessionName $session {$var}
Enter-PSSession -Session $session  #also interactive
Get-PSSession
$session | Remove-PSSession

#Multiple machines
$dcs = "savazuusedc01", "dc01"
Invoke-Command -ComputerName $dcs -ScriptBlock {$env:computername}
$sess = New-PSSession -ComputerName $dcs
$sess
icm –session $sess –scriptblock {$env:computername}

#Implicit remoting
$adsess = New-PSSession -ComputerName dc01
Import-Module -Name ActiveDirectory -PSSession $adsess
Get-Module #type different from the type on the actual DC
Get-Command -Module ActiveDirectory #functions instead of cmdlets
Get-ADUser -Filter *
$c = Get-Command Get-ADUser
$c.Definition
Remove-Module ActiveDirectory
Import-Module -Name ActiveDirectory -PSSession $adsess -Prefix OnDC
Get-Command -Module ActiveDirectory
Get-OnDCADUser -Filter *  #I don't have regular Get-ADUser anymore
