# Get all service announcement issues
$ServiceAnnouncementIssues = Get-MgServiceAnnouncementIssue

# Filter for open issues
$OpenServiceAnnouncementIssues = $ServiceAnnouncementIssues | Where-Object IsResolved -ne 'True'

# Select all properties for the open issues and expand Details
$OpenServiceAnnouncementIssues | ForEach-Object {
    $output = $_ | Select-Object *
    $details = $_ | Select-Object -ExpandProperty Details
    $output | Add-Member -MemberType NoteProperty -Name "Details" -Value ($details | ForEach-Object { "$($_.Key): $($_.Value)" }) -Force
    $output
} | Sort-Object StartDateTime
