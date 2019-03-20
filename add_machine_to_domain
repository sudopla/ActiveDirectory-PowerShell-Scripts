$machine_name = "aws-test002"
$domain = "contoso.corp"
$password = "Password123!" | ConvertTo-SecureString -AsPlainText -Force
$username = "$domain\test_account"
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Add-Computer -NewName $machine_name -DomainName $domain -Credential $credential -Restart -Force
