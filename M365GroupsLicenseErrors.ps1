#This finds groups in your M365 tenant that have members with license errors
Get-MgGroup -Filter "hasMembersWithLicenseErrors eq true" | Select-Object DisplayName, Description, Mail, MailNickName, Id, SecurityIdentifier

#Find the Users with License Errors in a group
# Specify the groupID
$groupid = '00000000-0000-0000-0000-00000000000000'

# Get the ID of users with license errors
$ID = Get-MgGroupMemberWithLicenseError -GroupId $groupid

#Get User with errors - presumably you can pass $ID instead of specifying the full Id, but it didn't work for me!
$User = get-mguser -UserId 000000-0000-0000-0000-0000000000000 | Format-List DisplayName

#Result
$User
