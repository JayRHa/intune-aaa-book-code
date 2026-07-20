<#
    Chapter 5 - Building Custom Analytics and Automation Solutions with Intune
    Solution 3: Intune Remediation Scripts (DETECTION)
    From the book "AI, Automation and Analytics - Transforming Device Management
    with Intune" (2nd Edition) by Jannik Reinhard.
    https://github.com/JayRHa/intune-aaa-book-code

    Remediation scripts run ON the device, in the Intune management extension,
    which lets you inspect and fix things Graph never sees. Each remediation is a
    pair: a detection script that decides whether the device has the problem, and
    a remediation script that runs only when detection reports one.

    The engine reads the detection script's exit code and stdout. Exit 0 means
    "compliant, do nothing"; non-zero means "issue found, run remediation". Stdout
    is captured into the report - which is how you collect data, not just fix it.

    This DETECTION checks whether the device rebooted in the last seven days.
    Pair it with remediate-device-uptime.ps1.
#>

$maxDays = 7
$lastBoot = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$uptime   = (Get-Date) - $lastBoot

if ($uptime.TotalDays -gt $maxDays) {
    Write-Output "Uptime $([math]::Round($uptime.TotalDays,1)) days exceeds $maxDays."
    exit 1   # triggers remediation
}

Write-Output "Uptime within policy."
exit 0
