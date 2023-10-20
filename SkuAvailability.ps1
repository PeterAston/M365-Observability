<#
  This script will find how many licenses for a specified Sku assigned by membership of a group are available.
  It gets the count of members of a group, any directly assigned licenses and takes those away from the total consumed units.
  It's good with the PowerShell Scalar tile in SquaredUp for a simple dashboard to show current license availability.
  You can use formatting in the Scalar tile to colour code whether the number is positive e.g. Green, negative e.g. Red, or balanced - maybe Blue?!
  You need to pick colours that reflect the state and also work for either light or dark theme!
#>

# Specify the AAD group display name to query
$groupName = "groupM365-Licenses"

# Get the details of the group to find the groupID
Get-MgGroup -Filter "displayName eq '$groupName'" -ConsistencyLevel eventual

# Specify the groupID
$groupid = 'ecbfe9cc-3186-49e4-8f93-cbbc58bec56a'

#Get the count of group members
$GroupMemberCount = get-mggroupmembercount -groupid $groupid -ConsistencyLevel eventual

#Get the Sku you're interested in e.g. M365EDU_A3_FACULTY
$Sku = get-mgsubscribedsku | Where-Object SkuPartNumber -eq "M365EDU_A3_FACULTY" | Select -Property SkuID, SkuPartNumber, ConsumedUnits -ExpandProperty PrepaidUnits

#Find any directly assigned licenses for the Sku that aren't in the AAD group
$directAssLic = $Sku.ConsumedUnits - $GroupMemberCount

#Subtract GroupMemberCount and any directly assigned licenses from the Sku Consumed Count
$result = $SKU.Enabled - $directAssLic - $GroupMemberCount

$result
