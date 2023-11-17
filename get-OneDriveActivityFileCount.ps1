
#Period
$periodId = 'D7'

# Get OneDrive Activity File Counts
Get-MgReportOneDriveActivityFileCount -Period $periodId  -OutFile 'E:\M365Storage\OneDriveActivityFileCount.csv'

# Remove spaces in  CSV headers
$OneDriveActivityFileCount = Get-Content 'E:\M365Storage\OneDriveActivityFileCount.csv' 
$OneDriveActivityFileCount[0] = $OneDriveActivityFileCount[0] -replace " ", ""
$OneDriveActivityFileCount_updated = $OneDriveActivityFileCount | Out-File 'E:\M365Storage\OneDriveActivityFileCount_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\OneDriveActivityFileCount_updated.csv'-Delimiter ','
$report | select-object *