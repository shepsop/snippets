$name = Read-Host "Who are you?"
$pass = Read-Host "What's your password?" -AsSecureString
[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass))
