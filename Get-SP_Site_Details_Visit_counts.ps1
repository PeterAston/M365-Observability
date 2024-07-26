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
##############################################
$siteUrl = "https://xxxx.sharepoint.com/sites/xxxxxx"
$periodId = 'D7' #Options are D7, D30. D90

# Get the site ID from the URL
$siteRelativeUrl = $siteUrl.Replace("https://xxxx.sharepoint.com", "")
$siteIdResponse = (Invoke-WebRequest -Uri "https://graph.microsoft.com/v1.0/sites/bham.sharepoint.com:$siteRelativeUrl" -Headers $headers).Content | ConvertFrom-Json
$siteId = $siteIdResponse.id

# Debug: Print the site ID
Write-Output "Site ID: $siteId"

if ($siteId) {
    # Get the site by ID
    $site = Get-MgSite -SiteId $siteId

    # Get site usage reports (adjust the period as needed)
    $reportUrl = "https://graph.microsoft.com/v1.0/reports/getSharePointSiteUsagePages(period='$periodId')"
    $outputFilePath = "E:\M365Storage\IntranetSharePointSiteUsagePages.csv"
    Invoke-MgGraphRequest -Method Get -Uri $reportUrl -Headers $headers -OutputFilePath $outputFilePath

    # Read the CSV file and filter for the specific site
    $report = Import-Csv -Path $outputFilePath

    # Debug: Print the first few lines of the report
    $report | Select-Object -First 5 | Format-Table

    # Debug: Print the site IDs from the report
    $report | Select-Object -Property SiteId | Format-Table

    $siteUsage = $report | Where-Object { $_.SiteId -eq $siteId }

    # Display the site usage statistics
    $siteUsage | Format-Table -Property ReportDate, PageViewCount
} else {
    Write-Warning "Site ID not found for URL '$siteUrl'"
}
