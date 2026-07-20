<#
    Chapter 5 - Building Custom Analytics and Automation Solutions with Intune
    From the book "AI, Automation and Analytics - Transforming Device Management
    with Intune" (2nd Edition) by Jannik Reinhard.
    https://github.com/JayRHa/intune-aaa-book-code

    Every solution in this chapter is keyless: Azure-hosted resources (Logic Apps,
    Automation accounts, Function apps) use a system-assigned managed identity,
    and there is no secret to store, leak, or rotate.

    A managed identity starts with no permissions, and there is no consent UI for
    it. So you grant it Microsoft Graph APPLICATION permissions by creating an
    app-role assignment against Microsoft Graph's service principal. Run this once,
    interactively, as an admin who can assign app roles (e.g. Privileged Role
    Administrator). Adjust $permission for whatever the solution needs - for
    example Mail.Send to send reports, DeviceManagementConfiguration.Read.All to
    read policies. Grant the least privilege the solution needs and nothing more.

    Uses the current Microsoft.Graph SDK. MSOnline and AzureAD are retired - do
    not use them.

    Install once:  Install-Module Microsoft.Graph -Scope CurrentUser
#>

Connect-MgGraph -Scopes "Application.Read.All","AppRoleAssignment.ReadWrite.All" -NoWelcome

# Object ID of the managed identity's service principal.
# Find it on the resource's Identity blade, or via Get-MgServicePrincipal.
$managedIdentityId = "<managed-identity-object-id>"

# The Graph application permission to grant.
$permission = "DeviceManagementManagedDevices.Read.All"

# Microsoft Graph's own service principal (well-known, first-party app id).
$graphSp = Get-MgServicePrincipal -Filter "appId eq '00000003-0000-0000-c000-000000000000'"

# Find the matching application role.
$appRole = $graphSp.AppRoles | Where-Object {
    $_.Value -eq $permission -and $_.AllowedMemberTypes -contains "Application"
}

# Assign it: PrincipalId and ServicePrincipalId are both the managed identity;
# ResourceId is Microsoft Graph.
New-MgServicePrincipalAppRoleAssignment `
    -ServicePrincipalId $managedIdentityId `
    -PrincipalId        $managedIdentityId `
    -ResourceId         $graphSp.Id `
    -AppRoleId          $appRole.Id

Disconnect-MgGraph
