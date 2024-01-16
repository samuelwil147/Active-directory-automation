# Set the root of your domain
$domainRoot = "DC=techhub,DC=com"
$hrOUPath = "OU=HR,$domainRoot"

# Prompt for user information
##intilze the number of users to create
$numberOfUsers = 2
$users = 1..$numberOfUsers | ForEach-Object {
    $name = Read-Host "Enter name for HR User $_"
    $username = Read-Host "Enter username for HR User $_"
    $password = Read-Host "Enter password for HR User $_" -AsSecureString

    # Create user
    New-ADUser -SamAccountName $username -UserPrincipalName "$username@techhub.com" -GivenName $name -Surname "Last" -Enabled $true -Path $hrOUPath -AccountPassword $password
}

# Display all users in the HR OU
Get-ADUser -Filter * -SearchBase $hrOUPath | Select-Object SamAccountName, DistinguishedName

Write-Host "HR User creation and display completed."
