<#
    Chapter 4 - Intune's Capabilities in Analytics and Automation
    From the book "AI, Automation and Analytics - Transforming Device Management
    with Intune" (2nd Edition) by Jannik Reinhard.
    https://github.com/JayRHa/intune-aaa-book-code

    Modern, keyless connection to Microsoft Graph with the Microsoft.Graph
    PowerShell SDK. The old MSOnline (retired) and AzureAD (retired 2025) modules
    are gone; do not use them. The underpinning is MSAL, not the long-dead ADAL.

    Install once:  Install-Module Microsoft.Graph -Scope CurrentUser
#>

# --- Interactive, for exploration -------------------------------------------
# Interactive sign-in with least-privilege scopes. Note the backtick line
# continuation - request only the scopes the task actually needs.
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All", `
                        "DeviceManagementConfiguration.Read.All"

# Prove it works: pull three managed devices.
Get-MgDeviceManagementManagedDevice -Top 3 |
    Select-Object DeviceName, OperatingSystem, ComplianceState

Disconnect-MgGraph

# --- Unattended, inside Azure with a managed identity -----------------------
# Runs in an Azure Automation runbook, Function App, or VM that has a
# system-assigned managed identity. There is NO secret anywhere - the single
# -Identity switch is the whole point. If your automation still passes a client
# id and secret into Connect-MgGraph, you are carrying a liability you no longer
# need to carry. See ch05-automation-solutions/grant-graph-permission.ps1 for how
# the managed identity is granted its Graph application permissions.
#
#   Connect-MgGraph -Identity
