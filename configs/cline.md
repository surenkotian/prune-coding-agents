# Cline → Prune

**Expected setup time:** ~5–10 minutes (extension install + three fields).

## Steps

1. Install the Cline extension in VS Code (or a compatible editor).
2. Open Cline settings (gear icon).
3. **API Provider** → **OpenAI Compatible**.
4. Fill in:

| Field | Value |
|-------|--------|
| Base URL | `https://api.withprune.com/v1` |
| API Key | your `prune_…` key |
| Model ID | a vaulted id (e.g. `gpt-4o-mini`) |

5. Send a short prompt and confirm a reply.

## Checks

- Cline settings / exported config show `prune_…`, **not** `sk-…` / `sk-ant-…`
- Prune dashboard shows usage / a receipt for the call
- Base URL ends at `/v1` (not `/v1/chat/completions`)

## Common failures

| Symptom | Likely cause |
|---------|----------------|
| 404 | Missing `/v1` or doubled `/v1/v1` |
| Works but no Prune usage | Real provider key pasted instead of `prune_…` |
| Model error | Model id not vaulted under Connect → Providers |
