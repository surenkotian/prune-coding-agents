# OpenCode → Prune

**Surfaces:** OpenCode Desktop app and terminal CLI  
**Expected setup time:** ~10–15 minutes (config file + auth)

OpenCode does **not** use a VS Code “OpenAI Compatible” UI. You add a
custom provider in `opencode.json`, then store the `prune_…` key with
`opencode auth login`. Same config works in **Desktop** and the CLI.

## Steps

1. Install [OpenCode](https://opencode.ai/).
2. Copy the example config:

   ```bash
   # macOS / Linux
   mkdir -p ~/.config/opencode
   cp configs/opencode/opencode.json.example ~/.config/opencode/opencode.json

   # Windows (PowerShell)
   New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode"
   Copy-Item configs\opencode\opencode.json.example "$env:USERPROFILE\.config\opencode\opencode.json"
   ```

   Or place `opencode.json` in your project root.

3. Edit the file so it looks like this (adjust model ids to ones you vaulted):

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "prune": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Prune",
      "options": {
        "baseURL": "https://api.withprune.com/v1"
      },
      "models": {
        "gpt-4o-mini": { "name": "GPT-4o mini (via Prune)" }
      }
    }
  },
  "model": "prune/gpt-4o-mini"
}
```

Important:
- Use `@ai-sdk/openai-compatible` (not `@ai-sdk/openai`)
- Put `baseURL` only — **do not** put `apiKey` in the JSON
- Model picker entries must be listed under `provider.prune.models`

4. Authenticate (stores the key outside the JSON file):

```bash
opencode auth login
# Other → provider id: prune → paste your prune_… key
```

5. Start OpenCode and select `prune/gpt-4o-mini` (or another model you listed).
6. Send a short prompt; confirm a reply and a Prune dashboard receipt.

### Switch models

1. Vault the provider for that model in Prune (OpenAI / Anthropic / OpenRouter).
2. Add the model id under `provider.prune.models` in `opencode.json`.
3. Set `"model": "prune/<id>"` or pick it in the UI.

Example OpenRouter-style id: `"openai/gpt-4o-mini"` → select `prune/openai/gpt-4o-mini`
only if you listed that key under `models`.

## Checks

- `opencode.json` has `baseURL` but **no** plaintext `apiKey`
- Chat returns a reply; Prune dashboard shows a receipt
- Provider id used at auth login is exactly `prune` (matches JSON)

## Optional run-budget headers

Under `provider.prune.options`:

```json
"headers": {
  "X-Prune-Run-Id": "opencode-smoke",
  "X-Prune-Run-Budget-Usd": "0.01"
}
```

## Common failures

| Symptom | Likely cause |
|---------|----------------|
| Model missing from picker | Model not listed under `provider.prune.models` |
| Wrong path / empty responses | Used `@ai-sdk/openai` instead of `openai-compatible` |
| Calls miss Prune | Auth login skipped, or key bound to a different provider id |
| 401 | Wrong / revoked `prune_…`, or auth for id other than `prune` |
| Model error | Model id not vaulted under Connect → Providers |
