#Read Users from .txt file
$users_displayname = Get-Content -Path 'C:\Users\user1\Desktop\users_list.txt'
$search_base = "OU=Users,DC=contoso,DC=corp"

$AD_group_name = "TEST_GROUP"

foreach ($displayname in $users_displayname) {

    $ad_user = Get-ADUser -Filter { DisplayName -eq $displayname} -SearchBase $search_base

    Write-Output $ad_user.Name
    Add-ADGroupMember -Identity $AD_group_name -Members $ad_user.DistinguishedName

}
