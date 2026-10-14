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

# Chapter 10 - Building Your Own Assistant on Microsoft Foundry

Code from the book **AI, Automation and Analytics - Transforming Device Management with Intune** (2nd Edition) by Jannik Reinhard.

The pro-code path: a current model on Microsoft Foundry (formerly Azure OpenAI Studio, at [ai.azure.com](https://ai.azure.com)), keyless auth, and a minimal chat UI. Grounding on your own data (Chapter 9) sits behind it; giving it hands via a Microsoft Graph tool call uses the same keyless managed identity from Chapter 5.

| File | What it does |
|---|---|
| [`chat.py`](chat.py) | A first chat completion against a Foundry model, keyless via `DefaultAzureCredential` on the v1 (`/openai/v1/`) route. |
| [`app.py`](app.py) | A minimal Streamlit chat over the assistant - `streamlit run app.py`. |

Requires `pip install -r ../requirements.txt` and `az login`. Both read `FOUNDRY_OPENAI_BASE_URL` (the base URL on your project's overview page).

---

[<- All chapters](../README.md)

<!-- jr-brand-footer:start -->
---

[Articles and guides](https://jannikreinhard.com/) · [Repository index](https://github.com/JayRHa/.github/blob/main/REPOSITORIES.md)
<!-- jr-brand-footer:end -->
