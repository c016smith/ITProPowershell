$left = import-csv 'C:\users\csmith\downloads\2021exportHOME.csv'
$left = import-csv 'C:\users\csmith\downloads\homeshares.csv'
$right = import-csv 'C:\users\csmith\downloads\allusers.csv'


$joinedFunction2 = Join-Object -Left $Left -Right $right -LeftJoinProperty FolderName -RightJoinProperty samaccountname -type AllInBoth -LeftProperties foldername, sizegb, fullpath -RightProperties userprincipalname, name, title, department, manager, enabled, whencreated

$joinedFunction2 | Out-GridView


($joinedFunction2).Add($_.sizegb)


$joinedFunction2 | Measure-Object -Sum sizegb
$joinedFunction2 | where userprincipalname -eq $null | Measure-Object -Sum sizegb 
$joinedFunction2 | where userprincipalname -eq $null | export-csv 'c:\users\csmith\downloads\EmptyHOMEFolders.csv'