#Custom objects
$cusobj = New-Object PSObject
Add-Member -InputObject $cusobj -MemberType NoteProperty `
    -Name greeting -Value "Hello"

    $cusobj
$favthings = @{"Julie"="Sushi";"Ben"="Trains";"Abby"="Princess";"Kevin"="Minecraft"}
$favobj = New-Object PSObject -Property $favthings
#In PowerShell v3 can skip a step
$favobj2
$favobj2 = [PSCustomObject]@{"Julie"="Sushi";"Ben"="Trains";"Abby"="Princess";"Kevin"="Minecraft"}
