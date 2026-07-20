<#
    Chapter 4 - Intune's Capabilities in Analytics and Automation
    From the book "AI, Automation and Analytics - Transforming Device Management
    with Intune" (2nd Edition) by Jannik Reinhard.
    https://github.com/JayRHa/intune-aaa-book-code

    Remediations (Devices > Scripts and remediations) are detect-and-fix script
    pairs that run on the device on a schedule. The detection script decides
    whether the device has the problem: exit 0 means "compliant, do nothing",
    non-zero means "issue found, run the remediation". Whatever it writes to
    stdout is captured and surfaced in the remediation report.

    This is the DETECTION half: exit 1 if %TEMP% exceeds 500 MB.
    Pair it with remediate-temp-bloat.ps1.
#>

$sizeMB = (Get-ChildItem $env:TEMP -Recurse -ErrorAction SilentlyContinue |
    Measure-Object -Property Length -Sum).Sum / 1MB

if ($sizeMB -gt 500) {
    Write-Host "Temp is $([math]::Round($sizeMB)) MB"
    exit 1   # triggers remediation
}

Write-Host "Temp within limits"
exit 0
