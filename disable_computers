clear

$Cred = Get-Credential -Credential contoso\user1

$date = [DateTime]::Today.AddDays(-90) 

$computers = Get-ADComputer -Filter 'lastLogonTimestamp -lt $date' -SearchBase "OU=Workstations,DC=contoso,DC=corp" -Properties CN, DistinguishedName, Description, Enabled, lastLogonTimestamp | 
Select-Object  -Property “CN”, @{Name=“LastLogonDate”;Expression={[datetime]::FromFileTime($_.“lastLogonTimestamp”).ToString("MM/dd/yyyy")}}, "DistinguishedName", "Description" 

Write-Output $computers.CN

foreach ($computer in $computers) {
    #Disable computer object
    Disable-ADAccount -Identity $computer.DistinguishedName -Credential $Cred
    
    #Add a description to the machine for future references
    $description = $computer.Description  + '. Moved here by powershell script. Original location: ' + $computer.DistinguishedName
    Set-ADComputer -Identity $computer.DistinguishedName -Description $description -Credential $Cred
    
    #Move computer object to DEACTIVATED OU
    Move-ADObject -Identity $computer.DistinguishedName -TargetPath "OU=DEACTIVATED,DC=contoso,DC=corp" -Credential $Cred
}
