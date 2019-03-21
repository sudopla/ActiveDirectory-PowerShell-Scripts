#Get user
$username = (Get-WmiObject -class Win32_ComputerSystem | select UserName).UserName

#Remove domain part. Ex. contoso/user_1 -> user_1
[regex]$rx="\w+$"
$username = $rx.match($username).value

#Get mapped drives
$ShareList = Get-WmiObject -Class Win32_NetworkConnection

$security_list =@()

foreach($share in $ShareList) {
    
    $list = New-Object System.Object
    $list | Add-Member -type NoteProperty -name Share_Patch -value $share.RemoteName

    $security = Get-Acl $share.RemoteName
    $list | Add-Member -type NoteProperty -name Owner -value $security.Owner
        
    $access = $security.Access       
    $security_string = ''

    foreach($acc in $access) {
        $temp_string = ' Identity: '+$acc.IdentityReference + ' - Permission: ' + $acc.FileSystemRights + ' ; '
        $security_string += $temp_string
    }

    $list | Add-Member -type NoteProperty -name Access -value $security_string 
    $security_list += $list   
}

#Write-Output $security_list
#Export data to a speadsheet
$location = 'C:\Users\'+$username+'\Desktop\netowrk_drives_'+$username+'.csv'
$security_list | Export-Csv -NoTypeInformatio $location
Write-Output $security_list
