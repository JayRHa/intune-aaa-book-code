"""Chapter 9 - Grounding AI in Your Data: hybrid + semantic query in one call, keyless.

From the book "AI, Automation and Analytics - Transforming Device Management with
Intune" (2nd Edition) by Jannik Reinhard.
https://github.com/JayRHa/intune-aaa-book-code

The payoff of the grounding chapter: a single query that fuses keyword (BM25) and
vector search (hybrid), then runs the semantic ranker on top - keyless.

  - search_text drives BM25 keyword matching.
  - vector_queries with VectorizableTextQuery lets the service embed the query for
    you (integrated vectorization at query time) and run vector search.
  - having both means AI Search fuses them with RRF into a hybrid result.
  - query_type="semantic" re-ranks the fused candidates with the semantic ranker.
  - @search.reranker_score in the output is the ranker's judgment; sorting by it
    is what puts the genuinely-best passage first.

Those five chunks are precisely what you inject into the model prompt in Chapter 10
(see ch10-foundry-assistant/). This is the keyless replacement for the
api-key-in-a-header script from the first edition.

Prerequisites: an index named "intune-kb" with a chunk-text field, a vector field,
and a semantic configuration named "default". Your identity (az login) needs a
data-plane read role such as Search Index Data Reader on the service.

Setup:
    pip install -r ../requirements.txt
    az login
Replace <service> with your AI Search service name.
"""

from azure.identity import DefaultAzureCredential
from azure.search.documents import SearchClient
from azure.search.documents.models import VectorizableTextQuery

client = SearchClient(
    endpoint="https://<service>.search.windows.net",
    index_name="intune-kb",
    credential=DefaultAzureCredential(),
)

query = "device fails compliance after BitLocker rotation"

results = client.search(
    search_text=query,                       # BM25 keyword leg
    vector_queries=[VectorizableTextQuery(   # vector leg, embedded service-side
        text=query, k_nearest_neighbors=50, fields="vector"
    )],
    query_type="semantic",                   # semantic ranker re-rank
    semantic_configuration_name="default",
    query_caption="extractive",
    top=5,
)

for r in results:
    print(r["@search.reranker_score"], r["chunk"][:200])
