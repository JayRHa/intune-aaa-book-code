<#
    Chapter 4 - Intune's Capabilities in Analytics and Automation
    From the book "AI, Automation and Analytics - Transforming Device Management
    with Intune" (2nd Edition) by Jannik Reinhard.
    https://github.com/JayRHa/intune-aaa-book-code

    The REMEDIATION half of the pair - runs only when detect-temp-bloat.ps1 exits
    non-zero. Clears the temp folder. Deploy the pair under Devices > Scripts and
    remediations > Remediations, assign to a device group, and watch the results.
#>

Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Temp files cleared."
exit 0
