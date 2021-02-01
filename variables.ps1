#Var types
$number=42
$boolset=$true
$stringval="hello"
$charval='a'
$number.GetType()
$boolset.GetType()
$stringval.GetType()
$charval.GetType()

[char]$newchar= 'a'
$newchar.GetType()

42 –is [int]

$number = [int]42
$number.ToString() | gm

$string1 = "the quick brown fox jumped over the lazy dog"
$string1 -like "*fox*"
$string2 = $string1 + " who was not amused"

#Variable Scope
function test-scope()
{
    write-output $defvar
    write-output $global:globvar
    write-output $script:scripvar
    write-output $private:privvar
    $funcvar = "function"
    $private:funcpriv = "funcpriv"
    $global:funcglobal = "globfunc"
}

$defvar = "default/local" #default
get-variable defvar -scope local
$global:globvar = "global"
$script:scripvar = "script"
$private:privvar = "private"
test-scope
$funcvar
$funcglobal #this should be visible

#Variables with Invoke-Command
$message = "Message to John"
Invoke-Command -ComputerName savazuusscdc01 -ScriptBlock {Write-Host $message}

$ScriptBlockContent = {
    param ($MessageToWrite)
    Write-Host $MessageToWrite }
Invoke-Command -ComputerName savazuusscdc01 -ScriptBlock $ScriptBlockContent -ArgumentList $message
#or
Invoke-Command -ComputerName savazuusscdc01 -ScriptBlock {Write-Output $args} -ArgumentList $message

Invoke-Command -ComputerName savazuusscdc01 -ScriptBlock {Write-Host $using:message}

