"""First model call from the October 2026 Intune book revision (Chapter 15).

Set FOUNDRY_OPENAI_ENDPOINT to the resource root and FOUNDRY_MODEL_DEPLOYMENT
to an existing deployment. The earlier FOUNDRY_OPENAI_BASE_URL variable is also
supported and must include /openai/v1/.
"""
import os
from azure.identity import DefaultAzureCredential, get_bearer_token_provider
from openai import OpenAI

def main():
    base_url = os.getenv("FOUNDRY_OPENAI_BASE_URL")
    if not base_url:
        base_url = os.environ["FOUNDRY_OPENAI_ENDPOINT"].rstrip("/") + "/openai/v1/"
    token_provider = get_bearer_token_provider(
        DefaultAzureCredential(), "https://ai.azure.com/.default"
    )
    with OpenAI(base_url=base_url, api_key=token_provider) as client:
        response = client.chat.completions.create(
            model=os.environ["FOUNDRY_MODEL_DEPLOYMENT"],
            messages=[
                {"role": "system", "content": "Explain Intune behavior and identify any assumptions."},
                {"role": "user", "content": "What does a compliance policy grace period do?"},
            ],
        )
        print(response.choices[0].message.content)

if __name__ == "__main__":
    main()
