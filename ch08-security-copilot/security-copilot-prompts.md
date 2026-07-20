# Chapter 8 - Security Copilot prompts

From the book **AI, Automation and Analytics - Transforming Device Management with Intune** (2nd Edition) by Jannik Reinhard.
https://github.com/JayRHa/intune-aaa-book-code

Security Copilot responds to plain language - no special syntax, no KQL required
(though it will happily write KQL for you). The quality of what you get back
tracks the quality of what you ask: name the object, state the goal, and ask for
the format you want. These are prompts from the chapter, written for the current
product. Substitute your own device names, incident ids, and time windows.

## Device-centric (from Intune or the portal)

```
Summarize the device WKS-4821: compliance state, security posture,
vulnerable software, and any anomalies from the last 14 days.
```

```
List all Windows devices that fell out of compliance in the last 24 hours
and group them by the compliance policy setting that failed.
```

```
Explain what the "Require BitLocker" setting in this configuration profile
does, which devices it is assigned to, and what breaks if I make it required.
```

## Vulnerability and remediation

```
For device WKS-4821, list the vulnerable software Defender has flagged,
sorted by severity, and for the top three recommend the Intune remediation.
```

## Incident and triage (device-adjacent)

```
Summarize incident INC-10293, focus on the endpoint impact, list the
affected Intune-managed devices, and give me the recommended containment steps.
```

## Conditional Access / identity (device posture matters here)

```
Show Conditional Access gaps for devices: users or apps not covered by a
policy that requires a compliant or hybrid-joined device.
```

## Promptbooks and agents

A **promptbook** packages a sequence like the above into one reusable, parameterized
unit - for example a "device investigation" promptbook that summarizes the device,
pulls its vulnerabilities, checks its compliance history, and drafts a remediation
plan, run as a single action. Where a promptbook is a *scripted* sequence you
trigger, an **agent** is the *autonomous* version of the same idea. Start with
promptbooks to standardize how your team investigates; graduate the well-worn ones
to agents when you trust the pattern and are ready to pay for it to run on its own.

---

[<- All chapters](../README.md)
