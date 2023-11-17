
#Period
$periodId = 'D7'

# Get SharePoint Activity File Counts
Get-MgReportSharePointActivityFileCount  -Period $periodId  -OutFile 'E:\M365Storage\SharePointActivityFileCount.csv'

# Remove spaces in  CSV headers
$SharePointActivityFileCount = Get-Content 'E:\M365Storage\SharePointActivityFileCount.csv' 
$SharePointActivityFileCount[0] = $SharePointActivityFileCount[0] -replace " ", ""
$SharePointActivityFileCount_updated = $SharePointActivityFileCount | Out-File 'E:\M365Storage\SharePointActivityFileCount_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\SharePointActivityFileCount_updated.csv'-Delimiter ','
$report | select-object *