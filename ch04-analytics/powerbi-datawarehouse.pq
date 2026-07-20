// Chapter 4 - Intune's Capabilities in Analytics and Automation
// From the book "AI, Automation and Analytics - Transforming Device Management
// with Intune" (2nd Edition) by Jannik Reinhard.
// https://github.com/JayRHa/intune-aaa-book-code
//
// Power Query M for connecting Power BI to the Intune Data Warehouse OData feed.
// Paste into Power BI Desktop via Get Data > Blank Query > Advanced Editor, or
// use Get Data > OData Feed and paste just the feed URL.
//
// The Data Warehouse is an OData v4 feed secured with Entra ID (OAuth2). Pinning
// Implementation and api-version explicitly - rather than letting it default -
// gives you a controlled, reproducible connection.
//
// Reality check: the "Intune Data Warehouse (beta)" v1 Power BI connector retires
// after April 2026 (migrate to the generic OData Feed connector), and a 2025/2026
// re-platform cut retained history to about 30 days. For long-run trend data,
// archive your own Graph exports (see export-report.ps1) or route through Log
// Analytics instead. Replace <region> with your tenant's reporting region.

let
    Source = OData.Feed(
        "https://fef.<region>.manage.microsoft.com/ReportingService/DataWarehouseFEService?api-version=v1.0",
        null,
        [Implementation = "2.0", Query = [#"api-version" = "v1.0"]]
    )
in
    Source
