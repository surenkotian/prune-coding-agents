# Zoo Code → Prune (optional)

**Expected setup time:** ~5–10 minutes (OpenAI Compatible; same fields as Cline).

Zoo Code is the community successor to Roo Code. Use it if you want continuity
with Roo-style workflows; otherwise prefer Cline or Kilo Code.

## Steps

1. Install Zoo Code from the VS Code Marketplace.
2. **API Provider** → **OpenAI Compatible**.
3. Fill in:

| Field | Value |
|-------|--------|
| Base URL | `https://api.withprune.com/v1` |
| API Key | your `prune_…` key |
| Model ID | a vaulted id (e.g. `gpt-4o-mini`) |

4. Send a short prompt and confirm a reply.

## Checks

- If you imported Roo settings, open secrets and confirm only `prune_…` remains
- Prune dashboard shows usage / a receipt

## Common failures

| Symptom | Likely cause |
|---------|----------------|
| Leak of old Roo keys | Import reintroduced `sk-…` into Zoo settings |
| 404 / auth errors | Same base URL mistakes as Cline (`/v1` path) |
