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

# Chapter 5 - Building Custom Analytics and Automation Solutions with Intune

Code from the book **AI, Automation and Analytics - Transforming Device Management with Intune** (2nd Edition) by Jannik Reinhard.

Four patterns cover almost everything you will build: a Logic App (low-code, no code file), an Azure Automation runbook, an Intune remediation script, and an Azure Function. The thread through all four is **keyless authentication** - a managed identity in Azure, workload identity federation outside it. There is no secret to store, leak, or rotate.

| File | Solution | What it does |
|---|---|---|
| [`grant-graph-permission.ps1`](grant-graph-permission.ps1) | (all) | Grant a Graph application permission to a managed identity - the one-time `New-MgServicePrincipalAppRoleAssignment` grant every solution depends on. |
| [`windows11-adoption-runbook.ps1`](windows11-adoption-runbook.ps1) | 2 - Automation runbook | Emails a daily Windows 11 adoption report, authenticating with `Connect-MgGraph -Identity`. |
| [`detect-device-uptime.ps1`](detect-device-uptime.ps1) / [`remediate-device-uptime.ps1`](remediate-device-uptime.ps1) | 3 - Remediation scripts | On-device pair: detect >7 days uptime, then toast the user to reboot. |
| [`inventory-function.ps1`](inventory-function.ps1) | 4 - Azure Function | The secure-broker HTTP function that receives device inventory and writes it onward with its managed identity. |

> Solution 1 (Microsoft Graph + Logic Apps) is built in the portal designer with a managed-identity HTTP action - there is no code file, just the grant above and the wiring described in the chapter.

---

[<- All chapters](../README.md)

<!-- jr-brand-footer:start -->
---

[Articles and guides](https://jannikreinhard.com/) · [Repository index](https://github.com/JayRHa/.github/blob/main/REPOSITORIES.md)
<!-- jr-brand-footer:end -->
