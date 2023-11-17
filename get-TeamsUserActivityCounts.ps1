function Convert-Iso8601DurationToHumanReadable {
    param (
        [string]$isoDuration
    )

    # Parse ISO 8601 duration using TimeSpan
    $timeSpan = [System.Xml.XmlConvert]::ToTimeSpan($isoDuration)

    # Format TimeSpan to human-readable format
    return "{0:D2}:{1:D2}:{2:D2}" -f $timeSpan.Hours, $timeSpan.Minutes, $timeSpan.Seconds
}

#Period
$periodId = 'D7'

# Get TeamsUserActivityCounts
Get-MgReportTeamUserActivityCount -Period $periodId -OutFile 'E:\M365Storage\TeamsUserActivityCounts.csv'

# Remove spaces in CSV headers
$TeamsUserActivityCounts = Get-Content 'E:\M365Storage\TeamsUserActivityCounts.csv' 
$TeamsUserActivityCounts[0] = $TeamsUserActivityCounts[0] -replace " ", ""
$TeamsUserActivityCounts_updated = $TeamsUserActivityCounts | Out-File 'E:\M365Storage\TeamsUserActivityCounts_updated.csv' 

# Import the CSV
$report = Import-Csv -LiteralPath 'E:\M365Storage\TeamsUserActivityCounts_updated.csv' -Delimiter ','

# Convert ISO 8601 durations to human-readable format
foreach ($entry in $report) {
    $entry.AudioDuration = Convert-Iso8601DurationToHumanReadable $entry.AudioDuration
    $entry.VideoDuration = Convert-Iso8601DurationToHumanReadable $entry.VideoDuration
    $entry.ScreenShareDuration = Convert-Iso8601DurationToHumanReadable $entry.ScreenShareDuration
}

# Output the updated report
$report | Select-Object *
