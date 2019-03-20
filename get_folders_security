$folders = Get-ChildItem -Directory -Path "C:\Users\user1\Documents" | Select Name, FullName

$security_list =@()

foreach($folder in $folders){

    $row = New-Object System.Object
    $row | Add-Member -type NoteProperty -name Folder_Name -value $folder.Name

    $security = Get-Acl $folder.FullName
    
    $access = $security.Access       
    $security_string = ''

    foreach($acc in $access) {
        $temp_string = '' + $acc.IdentityReference + ', '
        $security_string += $temp_string
    }

    $row | Add-Member -type NoteProperty -name Security -value $security_string

    $security_list += $row

}

#Export data to a speadsheet
$location = 'C:\Users\user1\Desktop\folder_permissions.csv'
$security_list | Export-Csv -NoTypeInformatio $location
Write-Output $security_list
