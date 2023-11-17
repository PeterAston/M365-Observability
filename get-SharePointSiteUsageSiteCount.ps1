#Period
$periodId = 'D7'

# Get SharePoint Site Usage Site Counts
Get-MgReportSharePointSiteUsageSiteCount      -Period $periodId  -OutFile 'E:\M365Storage\SharePointSiteUsageSiteCount.csv'

# Remove spaces in  CSV headers
$SharePointSiteUsageSiteCount = Get-Content 'E:\M365Storage\SharePointSiteUsageSiteCount.csv' 
$SharePointSiteUsageSiteCount[0] = $SharePointSiteUsageSiteCount[0] -replace " ", ""
$SharePointSiteUsageSiteCount_updated = $SharePointSiteUsageSiteCount | Out-File 'E:\M365Storage\SharePointSiteUsageSiteCount_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\SharePointSiteUsageSiteCount_updated.csv'-Delimiter ','
$report | select-object *