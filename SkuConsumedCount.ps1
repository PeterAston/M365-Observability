#Get the SKU
$SKU = get-mgsubscribedsku | Where-Object SkuPartNumber -eq "M365EDU_A3_FACULTY" | Select -Property SkuID, SkuPartNumber, ConsumedUnits -ExpandProperty PrepaidUnits

#Consumed Count
$result = $SKU.ConsumedUnits

$result
