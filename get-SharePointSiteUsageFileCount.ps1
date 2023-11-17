
#Period
$periodId = 'D7'

# Get SharePoint Site Usage File Counts
Get-MgReportSharePointSiteUsageFileCount     -Period $periodId  -OutFile 'E:\M365Storage\SharePointSiteUsageFileCount.csv'

# Remove spaces in  CSV headers
$SharePointSiteUsageFileCount = Get-Content 'E:\M365Storage\SharePointSiteUsageFileCount.csv' 
$SharePointSiteUsageFileCount[0] = $SharePointSiteUsageFileCount[0] -replace " ", ""
$SharePointSiteUsageFileCount_updated = $SharePointSiteUsageFileCount | Out-File 'E:\M365Storage\SharePointSiteUsageFileCount_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\SharePointSiteUsageFileCount_updated.csv'-Delimiter ','
$report | select-object *