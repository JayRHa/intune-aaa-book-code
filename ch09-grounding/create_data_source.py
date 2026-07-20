"""Chapter 9 - Grounding AI in Your Data: create an Azure AI Search data source, keyless.

From the book "AI, Automation and Analytics - Transforming Device Management with
Intune" (2nd Edition) by Jannik Reinhard.
https://github.com/JayRHa/intune-aaa-book-code

Two years ago every example (including the first edition of this book) passed API
keys around in connection strings. Stop doing that. The current best practice is
keyless authentication with Microsoft Entra and managed identities, using
DefaultAzureCredential in code. The same pattern - create_or_update_* with a
DefaultAzureCredential client - creates indexes, indexers, and skillsets too.

Prerequisites:
  - The AI Search service's system-assigned managed identity is turned on.
  - That identity has Storage Blob Data Reader on the storage account below.
  - You are signed in locally (az login) so DefaultAzureCredential can get a token;
    in Azure this comes from the app's managed identity instead.

Setup:
    pip install -r ../requirements.txt
    az login
    export AZURE_SEARCH_ENDPOINT="https://<name>.search.windows.net"

Fill in the <sub>/<rg>/<storage> placeholders in the connection ResourceId.
"""

import os

from azure.identity import DefaultAzureCredential, get_bearer_token_provider  # noqa: F401
from azure.search.documents.indexes import SearchIndexerClient
from azure.search.documents.indexes.models import (
    SearchIndexerDataSourceConnection,
    SearchIndexerDataContainer,
)

endpoint = os.environ["AZURE_SEARCH_ENDPOINT"]  # https://<name>.search.windows.net

# Keyless: uses your logged-in identity locally, the app's managed identity in Azure.
credential = DefaultAzureCredential()

indexer_client = SearchIndexerClient(endpoint=endpoint, credential=credential)

data_source = SearchIndexerDataSourceConnection(
    name="ds-intune-runbooks",
    type="azureblob",
    # ResourceId connection string => the SEARCH SERVICE's managed identity
    # reads the blob. No account key, no SAS token.
    connection_string=(
        "ResourceId=/subscriptions/<sub>/resourceGroups/<rg>/providers/"
        "Microsoft.Storage/storageAccounts/<storage>;"
    ),
    container=SearchIndexerDataContainer(name="runbooks"),
)

indexer_client.create_or_update_data_source_connection(data_source)
print("Data source created.")
