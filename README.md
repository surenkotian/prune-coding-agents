# Point your coding agent at Prune

**Problem:** Coding agents (Cline, Kilo Code, OpenCode, …) store provider API
keys in local config. Keys leak via screenshots, exports, and shared
dotfiles — and there is no spend brake or audit trail on that traffic.

**Fix:** Vault the real provider key in Prune. Point the agent at Prune with
a `prune_…` key only.

```
Base URL:  https://api.withprune.com/v1
API Key:   prune_••••
Model:     <any vaulted model id>
```

Provider secrets never sit in the agent config. Spend caps and signed
receipts apply to traffic that routes through Prune.

> This repo is **client setup only**. It does not include Prune’s backend,
> vault, or Shield implementation.

## Supported tools

| Tool | Status | Config style | Typical setup time |
|------|--------|--------------|--------------------|
| **Cline** | Primary | VS Code → OpenAI Compatible | ~5–10 min |
| **Kilo Code** | Active | VS Code → OpenAI Compatible | ~5–10 min |
| **OpenCode** | Active | `opencode.json` + auth login | ~10–15 min |
| **Zoo Code** | Optional | Same OpenAI Compatible path as Roo | ~5–10 min |

Subscription IDE backends (Cursor Ultra, Claude Pro, …) do **not** route
through Prune. Use those as-is.

## Prerequisites (once)

1. Create a Prune account → get a `prune_…` key
2. Dashboard → Connect → Providers → vault OpenAI / Anthropic / OpenRouter
3. Pick a model id your vaulted provider can serve

Prune shared setup (account + vault) is usually **~5 minutes** before the
per-tool steps below.

## Setup

### Cline (recommended) — ~5–10 min

1. Install [Cline](https://cline.bot) in VS Code (fresh profile / no prior keys)
2. Settings → **API Provider** → **OpenAI Compatible**
3. Set:

| Field | Value |
|-------|--------|
| Base URL | `https://api.withprune.com/v1` |
| API Key | `prune_…` |
| Model ID | e.g. `gpt-4o-mini` |

4. Send a short prompt. Confirm a reply and a receipt in the Prune dashboard.

See [configs/cline.md](./configs/cline.md).

### Kilo Code — ~5–10 min

Same OpenAI Compatible fields as Cline (Kilo shares that provider path).
Use Base URL `https://api.withprune.com/v1` and your `prune_…` key.
Do not paste `sk-…` / `sk-ant-…` into Kilo.

See [configs/kilo-code.md](./configs/kilo-code.md).

### OpenCode — ~10–15 min

Copy [configs/opencode/opencode.json.example](./configs/opencode/opencode.json.example)
to `~/.config/opencode/opencode.json` (or a project `opencode.json`), then:

```bash
opencode auth login
# choose Other → provider id `prune` → paste prune_…
```

Prefer auth login over putting `apiKey` in the JSON file.

### Zoo Code (optional) — ~5–10 min

API Provider → OpenAI Compatible — same three fields as Cline.

See [configs/zoo-code.md](./configs/zoo-code.md).

## Smoke test (any tool)

```bash
./examples/curl-smoke.sh prune_your_key
```

Or:

```bash
curl https://api.withprune.com/v1/models \
  -H "Authorization: Bearer prune_…"

curl https://api.withprune.com/v1/chat/completions \
  -H "Authorization: Bearer prune_…" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-4o-mini","messages":[{"role":"user","content":"ping"}],"max_tokens":16}'
```

Look for `prune_metadata` (and `receipt_signature` when signing is on) in the
JSON body. Verify at https://www.withprune.com/verify

## Spend brakes (optional)

Dashboard → Optimize → Shield → set a daily spend cap on the key.

Or per-run headers (if your client can set custom headers):

```
X-Prune-Run-Id: agent-smoke
X-Prune-Run-Budget-Usd: 0.01
```

Over budget → `429` with `X-Prune-Shield-Code: spend_cap` or `run_budget`.

## Manual test plan

See [TEST_PLAN.md](./TEST_PLAN.md) for a step-by-step checklist (fresh install,
key out of plaintext, spend cap, signed receipt, tool quirks).

## What this repo is not

- Not the Prune API server
- Not vault / encryption internals
- Not a fork of Cline / Kilo / OpenCode

## Links

- Product: https://www.withprune.com
- Coding agents docs: https://www.withprune.com/coding-agents
- Receipt verify: https://www.withprune.com/verify

## License

Apache License 2.0 — see [LICENSE](./LICENSE).
