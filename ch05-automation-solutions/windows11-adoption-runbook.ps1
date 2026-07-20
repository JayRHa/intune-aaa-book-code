<#
    Chapter 5 - Building Custom Analytics and Automation Solutions with Intune
    Solution 2: Azure Automation Runbooks
    From the book "AI, Automation and Analytics - Transforming Device Management
    with Intune" (2nd Edition) by Jannik Reinhard.
    https://github.com/JayRHa/intune-aaa-book-code

    An Azure Automation runbook runs PowerShell on a schedule on Azure-managed
    infrastructure, and (like a Logic App) it has a system-assigned managed
    identity, so it authenticates to Graph the keyless way. This one emails a
    daily Windows 11 adoption report.

    Prerequisites:
      - Automation account with its system-assigned managed identity turned on.
      - That identity granted DeviceManagementManagedDevices.Read.All AND Mail.Send
        (run grant-graph-permission.ps1 once for each).
      - Modules imported into the account: Microsoft.Graph.Authentication,
        Microsoft.Graph.DeviceManagement, Microsoft.Graph.Users.Actions.
      - Runbook runtime version: a current PowerShell 7.x.

    The one authentication line, Connect-MgGraph -Identity, replaces the entire
    old dance of Connect-AzAccount, Get-AzAccessToken, and passing a token into
    Connect-MgGraph.
#>

param(
    [string]$MailSender = "reports@contoso.com",
    [string]$MailTo     = "admin@contoso.com"
)

# Keyless connect - no secret, no token juggling.
Connect-MgGraph -Identity -NoWelcome

# Pull all Windows devices from Intune.
$devices = Get-MgDeviceManagementManagedDevice -All `
    -Filter "operatingSystem eq 'Windows'"

# Windows 11 is build 22000 and above.
$windows11 = $devices | Where-Object { [version]$_.OsVersion -ge [version]"10.0.22000" }

$total       = $devices.Count
$win11Count  = $windows11.Count
$win11Pct    = if ($total) { [math]::Round(($win11Count / $total) * 100, 1) } else { 0 }

# Build a simple HTML report.
$rows = ($devices | ForEach-Object {
    "<tr><td>$($_.DeviceName)</td><td>$($_.UserPrincipalName)</td>" +
    "<td>$($_.LastSyncDateTime)</td><td>$($_.OsVersion)</td></tr>"
}) -join "`n"

$html = @"
<html><head><style>
body{font-family:Segoe UI,Arial,sans-serif}
h1{color:#0078d4}
table{border-collapse:collapse;width:100%}
th{background:#0078d4;color:#fff;padding:8px;text-align:left}
td{border:1px solid #ddd;padding:8px}
tr:nth-child(even){background:#f2f2f2}
</style></head><body>
<h1>Windows 11 Adoption Report</h1>
<p><b>$win11Count of $total</b> Windows devices are on Windows 11 (<b>$win11Pct%</b>).</p>
<table>
<tr><th>Device</th><th>User</th><th>Last sync</th><th>OS version</th></tr>
$rows
</table>
</body></html>
"@

# Send the report with the Graph SDK cmdlet (needs Mail.Send).
$mail = @{
    Message = @{
        Subject      = "Windows 11 adoption report"
        Body         = @{ ContentType = "HTML"; Content = $html }
        ToRecipients = @( @{ EmailAddress = @{ Address = $MailTo } } )
    }
    SaveToSentItems = $false
}

Send-MgUserMail -UserId $MailSender -BodyParameter $mail
Write-Output "Report sent to $MailTo ($win11Pct% on Windows 11)."

Disconnect-MgGraph
