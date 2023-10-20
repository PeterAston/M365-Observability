#Get the Microsoft 365 licenses and services information
$a = Get-MgSubscribedSku | Select -Property SkuID, SkuPartNumber, ConsumedUnits -ExpandProperty PrepaidUnits | Sort-Object -Descending -Property ConsumedUnits

#Download the CSV file from Microsoft that contains the product names and service plan identifiers for licensing
#$b = Invoke-RestMethod -Method Get -Uri "https://download.microsoft.com/download/e/3/e/e3e9faf2-f28b-490a-9ada-c6089a1fc5b0/Product%20names%20and%20service%20plan%20identifiers%20for%20licensing.csv" | ConvertFrom-Csv
$b = Import-CSV -Path E:\Service_Skus_Service_Plans.csv

#Select only the skuId and Product_Display_Name properties from the CSV file and remove any duplicates
$b = $b | select -Property @{Name = 'skuId'; Expression = {($_.GUID)}}, Product_Display_Name | Select skuId,Product_Display_Name -Unique

#Declare and initialize an index variable
$i = 0

# Create an array of custom objects that contain the friendly name, 
# the number of consumed units, and the number and status of the 
# prepaid units for each licensing plan
$prettynameArray = @() 
foreach($item in $a) {$prettyname=($b | Where-Object {$_.skuId -eq $item.SkuId} | Sort-Object Product_Display_Name -Unique).Product_Display_Name

$prettynameArray += [pscustomobject]@{
     ProductDisplayName = $prettyname
     ConsumedUnits=$item.ConsumedUnits
     Enabled=$item.Enabled
     LockedOut=$item.LockedOut
     Suspended=$item.Suspended
     Warning=$item.Warning
     Available=($item.Enabled - $item.ConsumedUnits)
     SkuID=$item.SkuId
     SkuPartNumber=$item.SkuPartNumber
    
}

# Update the index variable
$i++
}
#Display the output of the script
$prettynameArray
