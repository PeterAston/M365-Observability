
#Period
$periodId = 'D7'

# Get M365 Service User Count
Get-MgReportOffice365ServiceUserCount  -Period $periodId  -OutFile 'E:\M365Storage\365ServiceUserCount.csv'

# Remove spaces in  CSV headers
$365ServiceUserCount = Get-Content 'E:\M365Storage\365ServiceUserCount.csv' 
$365ServiceUserCount[0] = $365ServiceUserCount[0] -replace " ", ""
$365ServiceUserCount_updated = $365ServiceUserCount | Out-File 'E:\M365Storage\365ServiceUserCount_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\365ServiceUserCount_updated.csv'-Delimiter ','
$report | select-object *