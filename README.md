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

# Intune AI, Automation and Analytics book code

## October 2026 book revision

The updated example is [ch10-foundry-assistant/chat.py](ch10-foundry-assistant/chat.py). Its opening instructions list the required endpoint and deployment variables. Keep credentials out of source files.

The relevant SDK interfaces were checked with Azure AI Projects 2.9.0, Azure Identity 1.26.0, OpenAI 3.35.1, and Anthropic 1.15.0 where applicable. These checks do not replace a test against your own authorized deployment. The existing ch10-foundry-assistant directory corresponds to Chapter 15 in the expanded second edition.


**Type:** Book companion · **Status:** Community project

<a id="about-this-repository"></a>

## Overview

Companion code for the book 'AI, Automation and Analytics: Transforming Device Management with Intune' (2nd Edition) by Jannik Reinhard - every listing as a runnable file: Microsoft Graph, KQL, Device Query, keyless automation, Azure AI Search grounding, and a Microsoft Foundry assistant.

Every code listing from the book **AI, Automation and Analytics: Transforming Device Management with Intune** (2nd Edition) by [Jannik Reinhard](https://jannikreinhard.com), as a file you can run, organized by chapter.

This is the second edition, rechecked line by line for the Microsoft cloud as it actually is in 2026 - which is a different place than when the first edition shipped. Azure OpenAI became **Microsoft Foundry**. The way you authenticate to Microsoft Graph changed: the honest current answer is **stop using secrets**. Copilot in Intune went GA and now writes the very KQL this book teaches you to write by hand. So the code here is keyless from the start and current, not a reprint of 2024 patterns.

<a id="start-here"></a>

## Quickstart

```bash
git clone https://github.com/JayRHa/intune-aaa-book-code
cd intune-aaa-book-code

# PowerShell listings (ch04, ch05)
Install-Module Microsoft.Graph -Scope CurrentUser
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All"

# Python listings (ch09, ch10)
az login
pip install -r requirements.txt
```

Nothing here stores a secret. In Azure the identity is a managed identity; on your laptop it comes from `az login` / `Connect-MgGraph`; in a pipeline it comes from workload identity federation. See [Chapter 5](ch05-automation-solutions) for the full keyless story.

## The 2026 Context

Three ideas run through all of it. **Keyless auth**: Azure-hosted automation uses a **managed identity**; code outside Azure uses **workload identity federation**; there is no client secret anywhere. **The current SDKs**: the `Microsoft.Graph` PowerShell SDK for Intune (MSOnline and AzureAD are retired), and `DefaultAzureCredential` from `azure-identity` in Python. **KQL in three places**: the same Kusto you learn for Log Analytics also drives **Device Query** and **Copilot in Intune** - learn it once, use it everywhere.

## Chapters

| | Chapter | What is in it |
|---|---|---|
| 4 | [Intune's Capabilities in Analytics and Automation](ch04-analytics) | Graph, keyless auth, the report export API, `$batch`, a full KQL tutorial, Device Query, a remediation pair |
| 5 | [Building Custom Analytics and Automation Solutions](ch05-automation-solutions) | The managed-identity grant, an Automation runbook, a remediation pair, an Azure Function broker |
| 8 | [Security Copilot](ch08-security-copilot) | Plain-language prompts and promptbooks I actually use |
| 9 | [Grounding AI in Your Data](ch09-grounding) | Azure AI Search as code, hybrid + semantic retrieval, keyless |
| 10 | [Building Your Own Assistant on Microsoft Foundry](ch10-foundry-assistant) | A keyless Foundry chat call and a minimal Streamlit UI |

Chapters 1-3, 6-7, and 11 are prose - concepts, history, prompting theory, and where this all goes next - so they have no code folder here.

## About the Code

**These are the book's listings, not a rewrite of them.** A listing printed in a book can lean on the prose around it: the book explains what a managed identity is a page earlier, so the listing just calls `Connect-MgGraph -Identity`. A file cannot. So each file here adds the bootstrap the book resolves in prose - reading endpoints from the environment, naming the exact scopes and roles it needs - and otherwise leaves the code exactly as printed. Where the book shows a fragment on purpose (a Graph request you run in Graph Explorer, the skeleton of an Azure Function), the file says so in its header and shows the surrounding lines it needs.

Every file starts with a header naming its chapter and the book, and the setup it needs. There is no shared config module: each file stands alone, so you can copy one out of here into your own project without dragging anything with it.

## Related

- 📘 The book: **AI, Automation and Analytics: Transforming Device Management with Intune** (2nd Edition) - Jannik Reinhard
- 📗 [foundry-book-code](https://github.com/JayRHa/foundry-book-code) - the companion code for the author's Microsoft Foundry book
- 🌐 [jannikreinhard.com](https://jannikreinhard.com)

## License

MIT - see [LICENSE](LICENSE).

<!-- jr-brand-footer:start -->
---

[Articles and guides](https://jannikreinhard.com/) · [Repository index](https://github.com/JayRHa/.github/blob/main/REPOSITORIES.md)
<!-- jr-brand-footer:end -->
