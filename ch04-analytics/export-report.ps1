<#
    Chapter 4 - Intune's Capabilities in Analytics and Automation
    From the book "AI, Automation and Analytics - Transforming Device Management
    with Intune" (2nd Edition) by Jannik Reinhard.
    https://github.com/JayRHa/intune-aaa-book-code

    The Intune report export API is asynchronous: start a job, poll it, download
    the result. This is the whole loop with the Microsoft.Graph SDK. Drop it into
    an Azure Automation runbook or a Function App with a managed identity and you
    have a scheduled, credential-free export you can point at a storage account, a
    Power BI dataset, or a data lake.

    Assumes you have already run Connect-MgGraph (interactively with the scope
    DeviceManagementManagedDevices.Read.All, or with -Identity inside Azure -
    see connect-mggraph.ps1).

    Common reportName values: Devices, DevicesWithInventory, DeviceCompliance,
    DeviceNonCompliance, AllAppsList, AppInstallStatusAggregate, DevicesByAppInv,
    AppInvAggregate, AppInvRawData, DefenderAgents, FeatureUpdateDeviceState.
#>

param(
    [string]$ReportName = 'DevicesByAppInv',
    [string]$OutDir     = './intuneExport'
)

$body = @{
    reportName       = $ReportName
    localizationType = 'LocalizedValuesAsAdditionalColumn'
} | ConvertTo-Json

# 1. Start the export job.
$job = Invoke-MgGraphRequest -Method POST `
    -Uri 'https://graph.microsoft.com/v1.0/deviceManagement/reports/exportJobs' `
    -Body $body

# 2. Poll until completed. The Start-Sleep matters: hammering the endpoint in a
#    tight loop is how you get throttled (HTTP 429 - honor the Retry-After header).
do {
    Start-Sleep -Seconds 5
    $job = Invoke-MgGraphRequest -Method GET `
        -Uri "https://graph.microsoft.com/v1.0/deviceManagement/reports/exportJobs('$($job.id)')"
    Write-Host "Status: $($job.status)"
} while ($job.status -ne 'completed')

# 3. Download and unpack. The file comes back as a zipped CSV (or JSON).
$zip = Join-Path (Split-Path $OutDir -Parent) 'intuneExport.zip'
Invoke-WebRequest -Uri $job.url -OutFile $zip
Expand-Archive $zip -DestinationPath $OutDir -Force
Write-Host "Export unpacked to $OutDir"
