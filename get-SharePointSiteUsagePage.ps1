
#Period
$periodId = 'D7'

# Get SharePoint Site Usage Page Counts
Get-MgReportSharePointSiteUsagePage       -Period $periodId  -OutFile 'E:\M365Storage\SharePointSiteUsagePage.csv'

# Remove spaces in  CSV headers
$SharePointSiteUsagePage = Get-Content 'E:\M365Storage\SharePointSiteUsagePage.csv' 
$SharePointSiteUsagePage[0] = $SharePointSiteUsagePage[0] -replace " ", ""
$SharePointSiteUsagePage_updated = $SharePointSiteUsagePage | Out-File 'E:\M365Storage\SharePointSiteUsagePage_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\SharePointSiteUsagePage_updated.csv'-Delimiter ','
$report | select-object *