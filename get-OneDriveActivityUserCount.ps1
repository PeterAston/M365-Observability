
#Period
$periodId = 'D7'

# Get OneDrive Activity User Counts
Get-MgReportOneDriveActivityUserCount -Period $periodId  -OutFile 'E:\M365Storage\OneDriveActivityUserCount.csv'

# Remove spaces in  CSV headers
$OneDriveActivityUserCount = Get-Content 'E:\M365Storage\OneDriveActivityUserCount.csv' 
$OneDriveActivityUserCount[0] = $OneDriveActivityUserCount[0] -replace " ", ""
$OneDriveActivityUserCount_updated = $OneDriveActivityUserCount | Out-File 'E:\M365Storage\OneDriveActivityUserCount_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\OneDriveActivityUserCount_updated.csv'-Delimiter ','
$report | select-object *