$Users = Get-ADUser -filter {Enabled -eq $True -and Memberof -eq "CN=MacPro Users,OU=Groups,DC=contoso,DC=com"} `
-SearchBase "OU=Chicago,DC=contoso,DC=com" –Properties “DisplayName”, "lastLogonTimestamp" |
Select-Object -Property “Displayname”, @{Name=“LastLogon”;Expression={[datetime]::FromFileTime($_.“lastLogonTimestamp”).ToString("MM/dd/yyyy")}} 

$Users | Export-Csv 'C:\Users\username\Desktop\Users.csv' -NoTypeInformation
