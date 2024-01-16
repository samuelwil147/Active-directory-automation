# Get all disabled user accounts
$disabledAccounts = Get-ADUser -Filter {Enabled -eq $false} | Select-Object SamAccountName, DistinguishedName

# Display disabled user accounts
if ($disabledAccounts.Count -eq 0) {
    Write-Host "No disabled user accounts found."
} else {
    Write-Host "Disabled User Accounts:"
    $disabledAccounts | Format-Table -AutoSize

    # Prompt to enable and reset password for each account
    $disabledAccounts | ForEach-Object {
        $enableChoice = Read-Host "Do you want to enable the account $($_.SamAccountName) and reset its password? (Y/N)"
        
        if ($enableChoice -eq 'Y' -or $enableChoice -eq 'y') {
            # Enable the user account
            Enable-ADAccount -Identity $_.SamAccountName
            Write-Host "Enabled account: $($_.SamAccountName)"

            # Reset password
            $newPassword = Read-Host "Enter a new password for $($_.SamAccountName)" -AsSecureString
            Set-ADAccountPassword -Identity $_.SamAccountName -NewPassword $newPassword -Reset

            Write-Host "Password reset for $($_.SamAccountName)"
        } else {
            Write-Host "Skipped account: $($_.SamAccountName)"
        }
    }
}
