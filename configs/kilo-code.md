# Kilo Code → Prune

**Surfaces:** VS Code extension and CLI (`npm i -g @kilocode/cli`)  
**Expected setup time:** ~5–10 minutes

Same three fields as Cline. Use **OpenAI Compatible / BYOK**, not Kilo Gateway
subscription, if you want traffic through Prune.

## Steps

1. Install [Kilo Code](https://kilo.ai/) for VS Code and/or:

   ```bash
   npm i -g @kilocode/cli
   ```

2. Open provider / API settings (extension sidebar or CLI config).
3. Choose **OpenAI Compatible** (or “Custom OpenAI-compatible endpoint”).
   - If you see both **OpenAI** and **OpenAI Compatible**, pick **Compatible**.
   - Do **not** use Kilo Gateway / subscription-only paths for this test.
4. Fill in:

| Field | Value |
|-------|--------|
| Base URL | `https://api.withprune.com/v1` |
| API Key | your `prune_…` key |
| Model ID | a vaulted id (e.g. `gpt-4o-mini`) |

5. Send a short prompt and confirm a reply.
6. Open the Prune dashboard — you should see a new request / receipt.

### Switch models

Keep the same base URL and `prune_…` key. Change only **Model ID** to any
vaulted id (`claude-…`, `openai/gpt-4o-mini`, etc.). That provider’s key must
already be vaulted under Connect → Providers.

## Checks

- Secrets store contains `prune_…` only — wipe any imported `sk-…` / `sk-ant-…`
- Prune dashboard shows usage / a receipt
- Base URL ends at `/v1` (not `/v1/chat/completions`)
- If you migrated from Roo-style settings, re-check that no provider key
  survived the import

## Common failures

| Symptom | Likely cause |
|---------|----------------|
| No Prune usage row | Using Kilo Gateway / subscription instead of BYOK Compatible |
| 401 | Wrong or revoked `prune_…` key |
| 404 | Missing `/v1` or doubled `/v1/v1` |
| Works but no Prune usage | Real provider key pasted instead of `prune_…` |
| Model error | Model id not vaulted under Connect → Providers |
| Inherited Roo/Zoo export errors | Old keys still in imported settings |
