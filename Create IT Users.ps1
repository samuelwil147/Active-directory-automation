# Set the root of your domain
$domainRoot = "DC=techhub,DC=com"
$itOUPath = "OU=IT,$domainRoot"

# Prompt for user information
$numberOfUsers = 4
$users = 1..$numberOfUsers | ForEach-Object {
    $name = Read-Host "Enter name for User $_"
    $username = Read-Host "Enter username for User $_"
    $password = Read-Host "Enter password for User $_" -AsSecureString

    # Create user
    New-ADUser -SamAccountName $username -UserPrincipalName "$username@techhub.com" -GivenName $name -Surname "Last" -Enabled $true -Path $itOUPath -AccountPassword $password
}

# Display created users
$users | Select-Object SamAccountName, DistinguishedName

# Display all users in the IT OU
Get-ADUser -Filter * -SearchBase $itOUPath | Select-Object SamAccountName, DistinguishedName

Write-Host "User creation completed."
