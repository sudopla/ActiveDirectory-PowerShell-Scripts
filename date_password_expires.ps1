
$user_name = "test_user"

Get-ADUser $user_name -properties msDS-UserPasswordExpiryTimeComputed | Select-Object Name,@{Name="Expry";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}
