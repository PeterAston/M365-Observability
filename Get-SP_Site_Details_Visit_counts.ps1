# Label: Get SharePoint Site Details by URL, and get Site Visit Counts
$tenantId = ""
$clientId = ""
$certificate = Get-Item Cert:\LocalMachine\My\
$token = Get-MsalToken -ClientId $clientID -TenantId $tenantID -ClientCertificate $certificate
# Define the headers for the API request
$headers = @{
    'Authorization' = "Bearer $($token.AccessToken)"
    'ConsistencyLevel' = "eventual"
}
Connect-MgGraph -ClientID xxx  -TenantId xxx -CertificateThumbprint xxx
##############################################
$siteUrl = "https://xxxx.sharepoint.com/sites/xxxxxxxx"
$periodId = 'D7' #Options are D7, D30. D90

# Get the site ID from the URL
$siteRelativeUrl = $siteUrl.Replace("https://xxxx.sharepoint.com", "")
$siteIdResponse = (Invoke-WebRequest -Uri "https://graph.microsoft.com/v1.0/sites/xxxx.sharepoint.com:$siteRelativeUrl" -Headers $headers).Content | ConvertFrom-Json
$siteId = $siteIdResponse.id.Split(',')[1]  # Extract the correct GUID

# Debug: Print the site ID
Write-Output "Site ID: $siteId"

if ($siteId) {
    # Get the site by ID
    $site = Get-MgSite -SiteId $siteId

    # Get site usage details
    $siteUsageUrl = "https://graph.microsoft.com/v1.0/sites/$siteId/analytics/lastSevenDays"
    $siteUsageResponse = Invoke-WebRequest -Uri $siteUsageUrl -Headers $headers | ConvertFrom-Json

    # Extract relevant data
    $actionCount = $siteUsageResponse.access.actionCount
    $actorCount = $siteUsageResponse.access.actorCount
    $timeSpentInSeconds = $siteUsageResponse.access.timeSpentInSeconds

    # Display the site usage statistics
    Write-Output "Action Count: $actionCount"
    Write-Output "Actor Count: $actorCount"
    Write-Output "Time Spent (seconds): $timeSpentInSeconds"
} else {
    Write-Warning "Site ID not found for URL '$siteUrl'"
}


<# Here’s what each of these terms means in the context of SharePoint site analytics:

Action Count:
This represents the total number of actions performed on the site. Actions can include activities such as viewing, editing, sharing, or deleting files and pages.
Actor Count:
This indicates the number of unique users (actors) who have performed actions on the site. It helps you understand how many different users are engaging with the site.
Time Spent:
This is the total amount of time (in seconds) that users have spent performing actions on the site. It provides insight into how much time users are spending on the site, which can be useful for understanding engagement levels.
These metrics help you gauge the level of activity and engagement on your SharePoint site over a specified period.
#>
