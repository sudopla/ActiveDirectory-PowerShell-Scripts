clear

$today_date = Get-Date

$Users = Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False -and Memberof -eq "CN=Mac_Users,OU=Groups,DC=contoso,DC=com"} `
-SearchBase "OU=Chicago,DC=contoso,DC=com" –Properties “DisplayName”, “msDS-UserPasswordExpiryTimeComputed” |
Select-Object -Property “Displayname”, "SamAccountName" ,@{Name=“ExpiryDate”;Expression={[datetime]::FromFileTime($_.“msDS-UserPasswordExpiryTimeComputed”)}} 


function SendEmail{
   
    $DisplayName = $args[0]
    $email_address = $args[1]
    $days_to_expire = $args[2]

    $From="email_address"
    $password = "password" | ConvertTo-SecureString -AsPlainText -Force
    $To= $email_address
    $Subject="Password Expiration Notification"
    $exp =""
    if($days_to_expire -eq 1){$exp = " day." } else {$exp = " days."}
    $message1 = "Dear " + $DisplayName + ",`n`n" + "Your Domain Account password will expire in "+$days_to_expire+ $exp 
    $message2 = " It's recommended to change it before it expires."
    $message3 = "`n`n" + "This is an automatically generated email. If you have any questions please reply to support@domain.com."
    $message4 = "`n`n" + "Thank you,"
    $message5 = "`n" + "IT Team"
    $Body = $message1 + $message2 + $message3 + $message4 + $message5
    $SMTPServer="smtp.office365.com"
    $SMTPPort = "587"
    $cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $password
    send-mailmessage -from $From -to $To -subject $Subject -body $Body -SmtpServer $SMTPServer -Port $SMTPPort -Credential $cred -UseSsl    
    
}


foreach($user in $Users){
    $expiry_date = $user.ExpiryDate
    $value = New-TimeSpan -Start $today_date -End $expiry_date

    if ($value.Days -ge 1 -and $value.Days -le 7){
        
        $email = $user.SamAccountName+"@domain.com"
        SendEmail $user.Displayname  $email  $value.Days
    }
    
}

