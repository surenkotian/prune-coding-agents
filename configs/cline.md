# Cline → Prune

**Surfaces:** VS Code, JetBrains, standalone CLI, SDK  
**Expected setup time:** ~5–10 minutes (install + three fields).

## Steps

1. Install [Cline](https://cline.bot) (extension, CLI, and/or SDK).
2. Settings (or CLI / SDK config) → **API Provider** → **OpenAI Compatible**.
3. Fill in:

| Field | Value |
|-------|--------|
| Base URL | `https://api.withprune.com/v1` |
| API Key | your `prune_…` key |
| Model ID | a vaulted id (e.g. `gpt-4o-mini`) |

4. Send a short prompt and confirm a reply. The same three values work
   across the extension, standalone CLI, and SDK.

## Checks

- Cline settings / exported / CLI config show `prune_…`, **not** `sk-…` / `sk-ant-…`
- Prune dashboard shows usage / a receipt for the call
- Base URL ends at `/v1` (not `/v1/chat/completions`)

## Common failures

| Symptom | Likely cause |
|---------|----------------|
| 404 | Missing `/v1` or doubled `/v1/v1` |
| Works but no Prune usage | Real provider key pasted instead of `prune_…` |
| Model error | Model id not vaulted under Connect → Providers |
