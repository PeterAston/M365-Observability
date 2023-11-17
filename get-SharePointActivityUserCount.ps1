#Period
$periodId = 'D7'

# Get SharePoint Activity User Counts
Get-MgReportSharePointActivityUserCount   -Period $periodId  -OutFile 'E:\M365Storage\SharePointActivityUserCount.csv'

# Remove spaces in  CSV headers
$SharePointActivityUserCount = Get-Content 'E:\M365Storage\SharePointActivityUserCount.csv' 
$SharePointActivityUserCount[0] = $SharePointActivityUserCount[0] -replace " ", ""
$SharePointActivityUserCount_updated = $SharePointActivityUserCount | Out-File 'E:\M365Storage\SharePointActivityUserCount_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\SharePointActivityUserCount_updated.csv'-Delimiter ','
$report | select-object * | Sort-Object ReportDate -Descending