# Set the root of your domain
$domainRoot = "DC=techhub,DC=com"

# Create OUs
New-ADOrganizationalUnit -Name "IT" -Path $domainRoot
New-ADOrganizationalUnit -Name "Accounts" -Path $domainRoot
New-ADOrganizationalUnit -Name "Operations" -Path $domainRoot
New-ADOrganizationalUnit -Name "HR" -Path $domainRoot

# Display created OUs
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName

Write-Host "OU creation completed."
