# Set the root of your domain
$domainRoot = "DC=techhub,DC=com"

# Specify the Organizational Unit (OU)
$ouPath = "OU=IT,DC=techhub,DC=com"  # Replace "YourOU" with the actual OU name

# Prompt to enter the username for password reset
$username = Read-Host "Enter the username for password reset"

# Get the user by username in the specified OU
$user = Get-ADUser -Filter {SamAccountName -eq $username} -SearchBase $ouPath

if ($user -eq $null) {
    Write-Host "User '$username' not found in the specified OU."
} else {
    $newPassword = Read-Host "Enter a new password for $username" -AsSecureString
    Set-ADAccountPassword -Identity $username -NewPassword $newPassword -Reset
    Write-Host "Password reset for $username in the specified OU."
}
