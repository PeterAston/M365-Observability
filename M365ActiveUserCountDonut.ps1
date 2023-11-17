
# Script for donut for M365 Active User Count - 1day

#Period
$periodId = 'D7'

# Get M365 Active User Count
Get-MgReportOffice365ActiveUserCount -Period $periodId  -OutFile 'E:\M365Storage\365ActiveUserCount.csv'

# Remove spaces in  CSV headers
$365ActiveUserCount = Get-Content 'E:\M365Storage\365ActiveUserCount.csv' 
$365ActiveUserCount[0] = $365ActiveUserCount[0] -replace " ", ""
$365ActiveUserCount_updated = $365ActiveUserCount | Out-File 'E:\M365Storage\365ActiveUserCount_updated.csv' 

$report = import-csv -LiteralPath 'E:\M365Storage\365ActiveUserCount_updated.csv'-Delimiter ',' | Select-Object -First 1
#$report | select-object Office365, Exchange, OneDrive, SharePoint, Teams

$office365Value = [int64]$report.Office365
$exchangeValue = [int64]$report.Exchange
$onedriveValue = [int64]$report.OneDrive
$sharepointValue = [int64]$report.SharePoint
$teamsValue = [int64]$report.Teams

#Create an array of custom objects with value and grouping properties
$Data = (
 [PSCustomObject]@{Value = $office365Value; Grouping = 'Office365'},
 [PSCustomObject]@{Value = $exchangeValue; Grouping = 'Exchange'},
 [PSCustomObject]@{Value = $onedriveValue; Grouping = 'OneDrive'},   
 [PSCustomObject]@{Value = $sharepointValue; Grouping = 'SharePoint'},   
 [PSCustomObject]@{Value = $teamsValue; Grouping = 'Teams'} 
 )

#Return the array of objects
$Data


### Script for SquaredUp donut tile for M365 storage ###

### Total Storage Used
# Import Exchange storage data from CSV file and extract first row storage usage
$exchangestorage = import-csv -LiteralPath 'E:\M365Storage\ExchangeScalar_updated.csv'-Delimiter ',' | Select-Object -First 1

# Extract Exchange storage usage (bytes) from first row
$exchangeStorageUsed = $exchangestorage.'storageused(byte)'

# Import OneDrive storage data from CSV file and extract first row storage usage
$onedrivestorage = import-csv -LiteralPath 'E:\M365Storage\OneDriveScalar_updated.csv'-Delimiter ',' | Select-Object -First 1

# Extract OneDrive storage usage (bytes) from first row
$onedriveStorageUsed = $onedrivestorage.'storageused(byte)'

# Import SharePoint storage data from CSV file and extract first row storage usage
$sharepointstorage = import-csv -LiteralPath 'E:\M365Storage\SharepointScalar_updated.csv'-Delimiter ',' | Select-Object -First 1

# Extract SharePoint storage usage (bytes) from first row
$sharepointStorageUsed = $sharepointstorage.'storageused(byte)'

#Get Values for all services (first row values only)
$ExchangeValue = [Math]::Round([int64]$exchangeStorageUsed / 1.099511627776E+12, 1) 
$OneDriveValue = [Math]::Round([int64]$onedriveStorageUsed / 1.099511627776E+12, 1) 
$SharePointValue = [Math]::Round([int64]$sharepointStorageUsed / 1.099511627776E+12, 1)

#Create an array of custom objects with value and grouping properties
$Data = ( [PSCustomObject]@{Value = $ExchangeValue; Grouping = 'Exchange'}, [PSCustomObject]@{Value = $OneDriveValue; Grouping = 'OneDrive'}, [PSCustomObject]@{Value = $SharePointValue; Grouping = 'SharePoint'} )

#Return the array of objects
$Data