$date = [DateTime]::Today.AddDays(-90) 

$computers = Get-ADComputer -Filter 'lastLogonTimestamp -lt $date' -SearchBase "OU=Workstations,DC=na,DC=contoso,DC=corp" -Properties CN, Description, Enabled, lastLogonTimestamp | 
Select-Object  -Property “CN”, @{Name=“LastLogonDate”;Expression={[datetime]::FromFileTime($_.“lastLogonTimestamp”).ToString("MM/dd/yyyy")}} 

Write-Output $computers

$computers | Export-Csv 'C:\Users\ng68d63\Desktop\no_login_in_90days.csv' -NoTypeInformation
