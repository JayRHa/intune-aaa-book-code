<#
    Chapter 5 - Building Custom Analytics and Automation Solutions with Intune
    Solution 3: Intune Remediation Scripts (REMEDIATION)
    From the book "AI, Automation and Analytics - Transforming Device Management
    with Intune" (2nd Edition) by Jannik Reinhard.
    https://github.com/JayRHa/intune-aaa-book-code

    Runs only when detect-device-uptime.ps1 exits non-zero. Pops a toast telling
    the user their device is due a reboot. It has to run in the logged-on user's
    context so the toast is visible - in the Create remediation wizard set "Run
    this script using the logged-on credentials" to Yes.

    (The full branded toast that also captures the user's choice is longer; this
    is the skeleton that gets the notification on screen.)
#>

$title = "Contoso IT"
$text  = "Your device has been running for over a week. Please save your work and restart when convenient."

[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument,               Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

[xml]$toast = @"
<toast scenario="reminder">
  <visual><binding template="ToastGeneric">
    <text>$title</text>
    <text>$text</text>
  </binding></visual>
</toast>
"@

$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($toast.OuterXml)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($title).Show($xml)
exit 0
