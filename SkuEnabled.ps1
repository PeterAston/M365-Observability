#Get the SKU and selected properties
 $SKU = get-mgsubscribedsku | Where-Object SkuPartNumber -eq "M365EDU_A3_FACULTY" | Select -Property SkuID, SkuPartNumber, ConsumedUnits -ExpandProperty PrepaidUnits

#Subtract GroupMemberCount from Consumed Count
 $result = $SKU.Enabled

 $result
