#Foreach
$names = @("Julie","Abby","Ben","Kevin")
$names | ForEach-Object -Process { Write-Output $_}
$names | ForEach -Process { Write-Output $_}
$names | ForEach { Write-Output $_}
$names | % { Write-Output $_}

$names[1].Length
#Foreach vs Foreach
ForEach-Object -InputObject (1..100) {
    $_
} | Measure-Object

ForEach ($num in (1..100)) {
    $num
} | Measure-Object

'Z'..'A'