"""Chapter 10 - Building Your Own Assistant on Microsoft Foundry: first call, keyless.

From the book "AI, Automation and Analytics - Transforming Device Management with
Intune" (2nd Edition) by Jannik Reinhard.
https://github.com/JayRHa/intune-aaa-book-code

The habit worth building before you write a line of code: do not use API keys. The
first edition authenticated with OPENAI_API_KEY, which is how everyone did it in
2024. The current, documented default is Microsoft Entra ID with
DefaultAzureCredential - keyless. On your laptop that identity comes from az login;
in Azure from a managed identity; in a pipeline from workload identity federation.
The same code runs in all three without a secret in sight.

Two current-API details that trip up anyone returning from 2024: the SDK now targets
v1 routes (/openai/v1/), so you no longer chase a monthly api-version string; and the
old extensions/chat/completions "bring your own data" endpoint is gone (grounding is
done with a knowledge base now - see the chapter).

Setup:
    pip install -r ../requirements.txt
    az login
    # base URL is on the project overview page in the Foundry portal (ai.azure.com)
    export FOUNDRY_OPENAI_BASE_URL="https://<resource>.openai.azure.com/openai/v1/"
"""

import os

from openai import OpenAI
from azure.identity import DefaultAzureCredential, get_bearer_token_provider

token_provider = get_bearer_token_provider(
    DefaultAzureCredential(), "https://cognitiveservices.azure.com/.default"
)

client = OpenAI(
    base_url=os.environ["FOUNDRY_OPENAI_BASE_URL"],  # https://<resource>.openai.azure.com/openai/v1/
    api_key=token_provider,  # a token provider, not a static key
)

resp = client.chat.completions.create(
    model="gpt-4.1",  # your DEPLOYMENT name
    messages=[
        {"role": "system", "content": "You are a senior Intune expert. Answer only about Intune, and only when you are confident."},
        {"role": "user", "content": "What does a compliance policy grace period actually do?"},
    ],
)
print(resp.choices[0].message.content)
