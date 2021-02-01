get-process | Export-csv c:\temp\proc.csv
Compare-Object -ReferenceObject (Import-Csv c:\temp\proc.csv) -DifferenceObject (Get-Process) -Property Name

notepad
$procs = get-process
get-process -Name notepad | Stop-Process
$procs2 = get-process
Compare-Object -ReferenceObject $procs -DifferenceObject $procs2 -Property Name