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

# Chapter 9 - Grounding AI in Your Data

Code from the book **AI, Automation and Analytics - Transforming Device Management with Intune** (2nd Edition) by Jannik Reinhard.

Retrieval over your own documents with Azure AI Search, defined as code so it is reproducible - and keyless, using `DefaultAzureCredential` and the search service's managed identity instead of the api-keys the first edition passed around.

| File | What it does |
|---|---|
| [`create_data_source.py`](create_data_source.py) | Create an AI Search data source over Blob Storage, keyless (the search service's managed identity reads the blob via a `ResourceId=` connection). |
| [`query_hybrid_semantic.py`](query_hybrid_semantic.py) | One query that fuses keyword + vector (hybrid) and re-ranks with the semantic ranker, keyless. The five chunks it returns are what you feed the model in Chapter 10. |
| [`query-hybrid-semantic.http`](query-hybrid-semantic.http) | The same hybrid + semantic query as raw REST against the stable API. |

Requires `pip install -r ../requirements.txt` and `az login`.

---

[<- All chapters](../README.md)

<!-- jr-brand-footer:start -->
---

[Articles and guides](https://jannikreinhard.com/) · [Repository index](https://github.com/JayRHa/.github/blob/main/REPOSITORIES.md)
<!-- jr-brand-footer:end -->
