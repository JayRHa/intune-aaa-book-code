<#
    Chapter 5 - Building Custom Analytics and Automation Solutions with Intune
    Solution 4: Azure Functions
    From the book "AI, Automation and Analytics - Transforming Device Management
    with Intune" (2nd Edition) by Jannik Reinhard.
    https://github.com/JayRHa/intune-aaa-book-code

    An Azure Function as the secure broker between the device and your data store:
    a remediation script POSTs its inventory to the function's HTTPS endpoint, and
    the function - authenticating with its managed identity - validates and writes
    that data to Log Analytics via the modern Logs Ingestion API (a Data
    Collection Endpoint governed by a Data Collection Rule, Entra-authenticated).
    The device holds no ingestion credential; it only knows a URL.

    This is the shape of the function itself - an HTTP-triggered PowerShell
    function (run.ps1). Deploy it into a Function app whose system-assigned managed
    identity has been granted the Graph/Monitor permissions it needs (see
    grant-graph-permission.ps1). The reference end-to-end implementation is the
    community project "Intune Enhanced Inventory" by Sandy Zeng and Jan Ketil
    Skanke (MSEndpointMgr), which ships a Deploy-to-Azure button.

    Note: outside Azure (GitHub Actions, a self-hosted job) the same logic uses
    workload identity federation instead of a managed identity - a federated
    credential trusting the platform's OIDC issuer, azure/login with no client
    secret, and the identical Graph app-role grants.
#>

using namespace System.Net
param($Request, $TriggerMetadata)

# Inventory posted by the device's remediation script.
$inventory = $Request.Body

# Authenticate as the Function app's managed identity - no secret.
Connect-MgGraph -Identity -NoWelcome

# ... validate $inventory, enrich it from Graph if needed, then write it
#     to Log Analytics via the Logs Ingestion API (Data Collection Endpoint) ...

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body       = "Inventory received."
})
