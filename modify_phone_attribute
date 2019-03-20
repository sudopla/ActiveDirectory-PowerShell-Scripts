Import-Module ActiveDirectory

$Cred = Get-Credential -Credential contoso.corp\test_user

#CHANGE THE SEARCH BASE
$search_base = "OU=Users,DC=contoso,DC=corp"

$Users = Get-ADUser -Filter * -SearchBase $search_base -Properties OfficePhone -Credential $Cred| Select-Object OfficePhone, DistinguishedName, SamAccountName

foreach($user in $Users) {

    $phone_number = $user.OfficePhone
    $username = $user.SamAccountName

    if ($phone_number) {
        Write-Output $phone_number
        # Remove all characters that are not a digit
        $phone_number = $phone_number -replace '\D+',''
        #If the phone starts with a 1, remove it
        $phone_number = $phone_number -replace '^1',''
        #Format the number
        $new_phone_number = '+1-'+$phone_number.Substring(0,3)+'-'+$phone_number.Substring(3,3)+'-'+$phone_number.Substring(6)

        $console_text = 'Username: '+$username+' New phone number: '+$new_phone_number
        Write-Output $console_text

        #Set-ADUser -Identity $User.DistinguishedName -OfficePhone $new_phone_number -Credential $Cred

    } else {
        $console_text = 'Username: '+$username+' does not have phone number'
        Write-Output $console_text
    }

}
