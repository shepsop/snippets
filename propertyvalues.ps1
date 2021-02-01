$samacctname = "robert2"
Get-ADUser $samacctname  -Properties mail
Get-ADUser $samacctname  -Properties mail | select-object mail
Get-ADUser $samacctname  -Properties mail | select-object mail | get-member
Get-ADUser $samacctname  -Properties mail | select-object -ExpandProperty mail | get-member
Get-ADUser $samacctname  -Properties mail | select-object -ExpandProperty mail