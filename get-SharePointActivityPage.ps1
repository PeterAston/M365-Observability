
#Period
$periodId = 'D7'

# Get SharePoint Activity Page Counts
Get-MgReportSharePointActivityPage    -Period $periodId  -OutFile 'E:\M365Storage\SharePointActivityPage.csv'

# Remove spaces in  CSV headers
$SharePointActivityPage = Get-Content 'E:\M365Storage\SharePointActivityPage.csv' 
$SharePointActivityPage[0] = $SharePointActivityPage[0] -replace " ", ""
$SharePointActivityPage_updated = $SharePointActivityPage | Out-File 'E:\M365Storage\SharePointActivityPage_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\SharePointActivityPage_updated.csv'-Delimiter ','
$report | select-object *