# Kilo Code → Prune

**Surfaces:** VS Code extension and CLI (`npm i -g @kilocode/cli`) — same
core engine on both.  
**Expected setup time:** ~5–10 minutes (same OpenAI Compatible path as Cline).

## Steps

1. Install [Kilo Code](https://kilo.ai/) for VS Code and/or
   `npm i -g @kilocode/cli`.
2. Open provider settings (extension or CLI) and choose **OpenAI Compatible**
   (or equivalent custom OpenAI-compatible endpoint) — not a
   subscription-only gateway path if you want traffic through Prune.
3. Fill in:

| Field | Value |
|-------|--------|
| Base URL | `https://api.withprune.com/v1` |
| API Key | your `prune_…` key |
| Model ID | a vaulted id (e.g. `gpt-4o-mini`) |

4. Send a short prompt and confirm a reply.

## Checks

- Secrets store contains `prune_…` only — wipe any imported `sk-…` keys
- Prune dashboard shows usage / a receipt
- If you migrated from Roo-style settings, re-check that no provider key
  survived the import

## Common failures

| Symptom | Likely cause |
|---------|----------------|
| No Prune usage row | Using Kilo Gateway / subscription path instead of BYOK Compatible |
| 401 | Wrong or revoked `prune_…` key |
| Inherited Roo/Zoo export errors | Old keys still in imported settings |
