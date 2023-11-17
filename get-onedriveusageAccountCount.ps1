
#Period
$periodId = 'D7'

# Get OneDrive Usage Account Count
Get-MgReportOneDriveUsageAccountCount   -Period $periodId  -OutFile 'E:\M365Storage\OneDriveUsageAccountCount.csv'

# Remove spaces in  CSV headers
$OneDriveUsageAccountCount = Get-Content 'E:\M365Storage\OneDriveUsageAccountCount.csv' 
$OneDriveUsageAccountCount[0] = $OneDriveUsageAccountCount[0] -replace " ", ""
$OneDriveUsageAccountCount_updated = $OneDriveUsageAccountCount | Out-File 'E:\M365Storage\OneDriveUsageAccountCount_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\OneDriveUsageAccountCount_updated.csv'-Delimiter ','
$report | select-object *