"""Chapter 10 - Building Your Own Assistant on Microsoft Foundry: a minimal Streamlit chat UI.

From the book "AI, Automation and Analytics - Transforming Device Management with
Intune" (2nd Edition) by Jannik Reinhard.
https://github.com/JayRHa/intune-aaa-book-code

You do not need a heavy front end to make a grounded assistant usable. A small
Streamlit app is enough to put a chat box in front of it for a pilot. The important
corrections versus the first edition's snippet: the OpenAI Python SDK is now 1.x, so
there is no openai.Completion.create and no module-level openai.api_key; you use the
client object, keyless, exactly as in chat.py.

For production you would host this on Azure App Service or Container Apps with a
managed identity, and put the grounding (Chapter 9) behind it - but for showing
colleagues what a tenant-aware assistant feels like, this is enough.

Setup:
    pip install -r ../requirements.txt
    az login
    export FOUNDRY_OPENAI_BASE_URL="https://<resource>.openai.azure.com/openai/v1/"
    streamlit run app.py
"""

import os

import streamlit as st
from openai import OpenAI
from azure.identity import DefaultAzureCredential, get_bearer_token_provider

client = OpenAI(
    base_url=os.environ["FOUNDRY_OPENAI_BASE_URL"],
    api_key=get_bearer_token_provider(
        DefaultAzureCredential(), "https://cognitiveservices.azure.com/.default"
    ),
)

st.title("Intune Assistant")
if "messages" not in st.session_state:
    st.session_state.messages = [
        {"role": "system", "content": "You are a helpful Intune expert. Answer only about Intune."}
    ]

for m in st.session_state.messages[1:]:
    st.chat_message(m["role"]).write(m["content"])

if prompt := st.chat_input("Ask about Intune..."):
    st.session_state.messages.append({"role": "user", "content": prompt})
    st.chat_message("user").write(prompt)
    reply = client.chat.completions.create(
        model="gpt-4.1", messages=st.session_state.messages
    ).choices[0].message.content
    st.session_state.messages.append({"role": "assistant", "content": reply})
    st.chat_message("assistant").write(reply)
