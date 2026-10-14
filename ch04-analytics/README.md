<!-- jr-brand:start -->
<p align="center">
  <a href="https://jannikreinhard.com/">
    <img src="https://raw.githubusercontent.com/JayRHa/.github/main/assets/readme/brand-header.png" alt="Jannik Reinhard — I help enterprises ship secure AI agents" width="100%">
  </a>
</p>
<p align="center">
  <a href="https://jannikreinhard.com/">Website</a> ·
  <a href="https://www.linkedin.com/in/jannik-r/">LinkedIn</a> ·
  <a href="https://x.com/jannik_reinhard">X</a> ·
  <a href="https://www.youtube.com/@jannikreinhard">YouTube</a>
</p>
<!-- jr-brand:end -->

# Chapter 4 - Intune's Capabilities in Analytics and Automation

Code from the book **AI, Automation and Analytics - Transforming Device Management with Intune** (2nd Edition) by Jannik Reinhard.

This is the chapter the whole book leans on: getting data *out* of Intune and acting on it. Microsoft Graph, keyless auth, the report export API, KQL, Device Query, and the on-device remediation primitive.

| File | What it does |
|---|---|
| [`graph-requests.http`](graph-requests.http) | The read-only Graph surface - managed devices, tenant overview, and the beta device-inventory endpoints. |
| [`connect-mggraph.ps1`](connect-mggraph.ps1) | Modern, keyless connection with the Microsoft.Graph SDK: interactive scopes and `-Identity`. |
| [`export-report.ps1`](export-report.ps1) | The full async report-export loop (start job, poll, download the zipped CSV), ready to schedule. |
| [`report-export-job.http`](report-export-job.http) | The same export flow as raw REST, with two example request bodies. |
| [`batch-request.http`](batch-request.http) | Several small Graph calls in one `$batch` round trip. |
| [`kql-tutorial.kql`](kql-tutorial.kql) | The Log Analytics KQL tutorial - filter, summarize, `arg_max` de-duplication, joins, `let`, trends, exercises. |
| [`device-query.kql`](device-query.kql) | Live Device Query KQL (CPU, registry, event log) against a single device's real-time state. |
| [`powerbi-datawarehouse.pq`](powerbi-datawarehouse.pq) | Power Query M for the Intune Data Warehouse OData feed, with the 2026 retirement/retention caveats. |
| [`detect-temp-bloat.ps1`](detect-temp-bloat.ps1) / [`remediate-temp-bloat.ps1`](remediate-temp-bloat.ps1) | A minimal detection/remediation pair: flag and clear a bloated `%TEMP%`. |

---

[<- All chapters](../README.md)

<!-- jr-brand-footer:start -->
---

[Articles and guides](https://jannikreinhard.com/) · [Repository index](https://github.com/JayRHa/.github/blob/main/REPOSITORIES.md)
<!-- jr-brand-footer:end -->
