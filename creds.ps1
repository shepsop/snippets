#Credentials
#This is not good
$user = "administrator"
$password = 'Pa55word'
$securePassword = ConvertTo-SecureString $password `
    -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($user, $securePassword)

#An encrypted string
$encryptedPassword = ConvertFrom-SecureString (ConvertTo-SecureString -AsPlainText -Force "Password123")
$securepassword = ConvertTo-SecureString "<the huge value from previous command>"

#Another file
$credpath = "c:\temp\MyCredential.xml"
New-Object System.Management.Automation.PSCredential("john@savilltech.com", (ConvertTo-SecureString -AsPlainText -Force "Password123")) | Export-CliXml $credpath
$cred = import-clixml -path $credpath

#Using Key Vault
Select-AzSubscription -Subscription (Get-AzSubscription | where Name -EQ "MPN2")
$cred = Get-Credential

#Store username and password in keyvault
Set-AzKeyVaultSecret -VaultName 'shepslabkv1' -Name 'SamplePassword' -SecretValue $cred.Password
$secretuser = ConvertTo-SecureString $cred.UserName -AsPlainText -Force #have to make a secure string
Set-AzKeyVaultSecret -VaultName 'shepslabkv1' -Name 'SampleUser' -SecretValue $secretuser

#Getting back
$username = (get-azkeyvaultsecret -vaultName 'shepslabkv1' -Name 'SampleUser').SecretValueText
$password = (get-azkeyvaultsecret -vaultName 'shepslabkv1' -Name 'SamplePassword').SecretValue
(get-azkeyvaultsecret -vaultName 'shepslabkv1' -Name 'SamplePassword').SecretValueText #Can get the plain text via key vault
[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)) #Inspect if want to double check

#Recreate
$newcred = New-Object System.Management.Automation.PSCredential ($username, $password)
#Test
invoke-command -ComputerName dc01 -Credential $newcred -ScriptBlock {whoami}
