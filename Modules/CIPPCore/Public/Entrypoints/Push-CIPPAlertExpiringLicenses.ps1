function Push-CIPPAlertExpiringLicenses {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $QueueItem,
        $TriggerMetadata
    )


            try {
                Get-CIPPLicenseOverview -TenantFilter $QueueItem.tenant | Where-Object -Property [int]TimeUntilRenew -LT 29 | ForEach-Object {
                    Write-AlertMessage -tenant $($QueueItem.tenant) -message "$($_.License) will expire in $($_.TimeUntilRenew) days"
                }
            } catch {
                Write-AlertMessage -tenant $($QueueItem.tenant) -message "Error occurred: $(Get-NormalizedError -message $_.Exception.message)"
            }
        }

