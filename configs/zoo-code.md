# Zoo Code → Prune (optional)

**Surfaces:** VS Code extension  
**Expected setup time:** ~5–10 minutes

Zoo Code is the community successor to Roo Code. Prefer Cline or Kilo if you
are starting fresh; use Zoo if you want Roo-style continuity.

## Steps

1. Install [Zoo Code](https://marketplace.visualstudio.com/items?itemName=zoocodeorganization.zoo-code)
   from the VS Code Marketplace.
2. Open Zoo settings → **API Provider** → **OpenAI Compatible**.
3. Fill in:

| Field | Value |
|-------|--------|
| Base URL | `https://api.withprune.com/v1` |
| API Key | your `prune_…` key |
| Model ID | a vaulted id (e.g. `gpt-4o-mini`) |

4. Send a short prompt and confirm a reply.
5. Open the Prune dashboard — you should see a new request / receipt.

### Switch models

Keep the same base URL and `prune_…` key. Change only **Model ID** to any
vaulted id. Vault that provider under Connect → Providers first.

### If you imported Roo settings

Open secrets / API keys and delete any leftover `sk-…` / `sk-ant-…`. Only
`prune_…` should remain for the Prune provider entry.

## Checks

- Settings show `prune_…`, **not** provider `sk-…`
- Prune dashboard shows usage / a receipt
- Base URL ends at `/v1`

## Common failures

| Symptom | Likely cause |
|---------|----------------|
| Leak of old Roo keys | Import reintroduced `sk-…` into Zoo settings |
| 404 | Missing `/v1` or doubled `/v1/v1` |
| Works but no Prune usage | Provider key pasted instead of `prune_…` |
| Model error | Model id not vaulted under Connect → Providers |
