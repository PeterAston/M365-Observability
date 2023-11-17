
#Period
$periodId = 'D7'

# Get OneDrive Usage File Count
Get-MgReportOneDriveUsageFileCount  -Period $periodId  -OutFile 'E:\M365Storage\OneDriveUsageFileCount.csv'

# Remove spaces in  CSV headers
$OneDriveUsageFileCount = Get-Content 'E:\M365Storage\OneDriveUsageFileCount.csv' 
$OneDriveUsageFileCount[0] = $OneDriveUsageFileCount[0] -replace " ", ""
$OneDriveUsageFileCount_updated = $OneDriveUsageFileCount | Out-File 'E:\M365Storage\OneDriveUsageFileCount_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\OneDriveUsageFileCount_updated.csv'-Delimiter ','
$report | select-object *