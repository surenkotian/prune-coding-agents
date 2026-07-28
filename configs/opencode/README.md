# OpenCode → Prune

**Surfaces:** Terminal only (CLI-native — OpenCode *is* the CLI; no separate
VS Code extension).  
**Expected setup time:** ~10–15 minutes (config file + auth login; slightly
more friction than Cline/Kilo).

## Steps

1. Install [OpenCode](https://opencode.ai/).
2. Copy `opencode.json.example` to `~/.config/opencode/opencode.json`
   (Windows: `%USERPROFILE%\.config\opencode\opencode.json`) or a project
   `opencode.json`.
3. Adjust the model id under `models` to a vaulted id you use.
4. Authenticate (preferred — keeps the key out of the JSON file):

```bash
opencode auth login
# Other → provider id: prune → paste prune_…
```

5. Start OpenCode and select `prune/<model>`.

## Checks

- `opencode.json` has `baseURL` but **no** plaintext `apiKey`
- Chat returns a reply; Prune dashboard shows a receipt
- Use `@ai-sdk/openai-compatible` for `/v1/chat/completions` (Prune’s OpenAI path)

## Optional run-budget headers

If you need per-run spend brakes, add under `options`:

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
| Calls miss Prune | Auth login skipped; key bound to a different provider id |
