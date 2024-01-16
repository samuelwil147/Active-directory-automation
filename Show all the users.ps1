# Set the root of your domain
$domainRoot = "DC=techhub,DC=com"

# Get all users
$allUsers = Get-ADUser -Filter * -SearchBase $domainRoot | Select-Object SamAccountName, Name, @{Name='OU';Expression={$_.DistinguishedName -replace "^.+?,(OU=.+?),(DC=.+)$",'$1'}}

# Display all users in tabular form
if ($allUsers.Count -eq 0) {
    Write-Host "No users found."
} else {
    Write-Host "All Users:"
    $allUsers | Format-Table -AutoSize
}
