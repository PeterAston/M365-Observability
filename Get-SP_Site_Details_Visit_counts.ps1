# Label: Get SharePoint Site Details by URL, and get Site Visit Counts

$tenantId = ""
$clientId = ""
$certificate = Get-Item Cert:\LocalMachine\My\
$token = Get-MsalToken -ClientId $clientID -TenantId $tenantID -ClientCertificate $certificate

Connect-MgGraph -ClientId $clientId  -TenantId $tenantId -CertificateThumbprint $certificate


# Define the headers for the API request
$headers = @{
    'Authorization' = "Bearer $($token.AccessToken)"
    'ConsistencyLevel' = "eventual"
}

$siteUrl = "https://*.sharepoint.com/sites/*"

# Get the site ID from the URL
$siteRelativeUrl = $siteUrl.Replace("https://*.sharepoint.com", "")
$siteId = (Invoke-WebRequest -Uri "https://graph.microsoft.com/v1.0/sites/*.sharepoint.com:$siteRelativeUrl" -Headers $headers).Content | 
            ConvertFrom-Json | Select-Object -ExpandProperty id 

if ($siteId) {
    # Get the site by ID
    $site = Get-MgSite -SiteId $siteId

    # Get site usage reports (adjust the period as needed)
    $reportUrl = "https://graph.microsoft.com/v1.0/reports/getSharePointSiteUsagePages(period='D7')"
    $outputFilePath = "C:\Temp\IntranetSharePointSiteUsagePages.csv"
    Invoke-MgGraphRequest -Method Get -Uri $reportUrl -Headers $headers -OutputFilePath $outputFilePath

    # Read the CSV file
    $report = Import-Csv -Path $outputFilePath

    if ($report) {
        # Extract the most recent site visits
        $siteVisits = $report | Sort-Object ReportDate -Descending 
        $siteVisits | Select-Object 'Page View Count','Report Date'
    } else {
        Write-Warning "No usage report found for site '$siteUrl'"
    }
} else {
    Write-Warning "Site ID not found for URL '$siteUrl'"
}
