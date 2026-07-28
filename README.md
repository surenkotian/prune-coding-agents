# Point your coding agent at Prune

If you're using Cline, Kilo Code, OpenCode, or Zoo Code with your own API
key — in the editor, the CLI, or via SDK — your provider key is sitting in
plaintext in a local config file right now. There's no spend limit
stopping a runaway session from blowing past what you meant to spend, and
no record of what any single call actually cost.

**Prune addresses those three problems with one OpenAI-compatible base URL
change** (base URL + `prune_…` key + model id), on whichever surface you use.

## What you get

- **Provider keys stay out of the agent config.** Vault your real OpenAI /
  Anthropic / OpenRouter key once in Prune. The agent only needs a
  `prune_…` key — treat that like any other secret (don’t commit it), but
  the upstream `sk-…` / `sk-ant-…` never has to live in local config, CLI
  history, or shared dotfiles.
- **Spend caps on traffic through Prune.** Set a daily or per-run budget.
  When the ceiling is reached, Prune rejects further requests with `429`
  (`X-Prune-Shield-Code: spend_cap` or `run_budget`) instead of letting
  the session run unbounded. Near-limit behavior can depend on completed
  spend vs. pending estimates — see product docs for the exact rules.
- **Lower bills on routed traffic.** Prune applies caching and compression
  on compatible traffic by default (exact and near-duplicate reuse where
  the pipeline allows). Results vary by workload; repeats and long agent
  threads benefit most.
- **A receipt on every response.** Each proxied call returns
  `prune_metadata` (cost, model, cache fields, etc.). When receipt signing
  is enabled on the server, that metadata is Ed25519-signed and verifiable
  at [withprune.com/verify](https://www.withprune.com/verify).

## Why this matters for coding agents specifically

Agents make a lot of calls, fast, often unattended while they plan, edit,
and retry — in the editor or from a terminal session. That pattern is
exactly what turns a small mistake (a loop, a bad prompt, a leaked key)
into a bill you didn't see coming. Prune is built to sit in front of that,
across whichever surface you actually use.

## Supported tools and surfaces

| Tool | Surfaces | Setup time |
|------|----------|------------|
| **Cline** | VS Code, JetBrains, standalone CLI, SDK | ~5–10 min |
| **Kilo Code** | VS Code, CLI (`@kilocode/cli`) | ~5–10 min |
| **OpenCode** | Terminal (CLI-native) | ~10–15 min |
| **Zoo Code** | VS Code | ~5–10 min |

Every surface for every tool takes the same base URL + key — configure it
once per tool, works the same whether you're in the editor or the
terminal.

Subscription IDE backends (Cursor Ultra, Claude Pro, …) do **not** route
through Prune. Use those as-is.

```
Base URL:  https://api.withprune.com/v1
API Key:   prune_••••
Model:     <any vaulted model id>
```

> This repo is **client setup only** — it does not include Prune's
> backend, vault, or Shield implementation. That code stays closed; this
> repo just gets you connected.

## Setup by tool

### Cline (VS Code / JetBrains / CLI / SDK)

1. Install [Cline](https://cline.bot)
2. Settings (or CLI config) → **API Provider** → **OpenAI Compatible**
3. Set Base URL, API Key (`prune_…`), and Model ID as above
4. Same values work whether you're using the extension, the standalone
   CLI, or the SDK directly.

Full config: [configs/cline.md](./configs/cline.md)

### Kilo Code (VS Code / CLI)

Same OpenAI Compatible fields as Cline, in either the extension or the
CLI (`npm i -g @kilocode/cli`). Do not paste `sk-…` / `sk-ant-…` directly
into Kilo — only your `prune_…` key.

Full config: [configs/kilo-code.md](./configs/kilo-code.md)

### OpenCode (terminal)

Copy [configs/opencode/opencode.json.example](./configs/opencode/opencode.json.example)
to `~/.config/opencode/opencode.json`, then:

```bash
opencode auth login
# choose Other → provider id `prune` → paste prune_…
```

Prefer auth login over putting `apiKey` in the JSON file.

### Zoo Code (VS Code, optional)

Install [Zoo Code](https://marketplace.visualstudio.com/items?itemName=zoocodeorganization.zoo-code)
from the VS Code Marketplace, then use the same OpenAI Compatible path as
Cline.

Full config: [configs/zoo-code.md](./configs/zoo-code.md)

## Try it in 2 minutes

```bash
# macOS / Linux / Git Bash
./examples/curl-smoke.sh prune_your_key

# PowerShell (Windows) — same two requests without bash:
# curl.exe https://api.withprune.com/v1/models -H "Authorization: Bearer prune_…"
# curl.exe https://api.withprune.com/v1/chat/completions `
#   -H "Authorization: Bearer prune_…" -H "Content-Type: application/json" `
#   -d '{\"model\":\"gpt-4o-mini\",\"messages\":[{\"role\":\"user\",\"content\":\"ping\"}],\"max_tokens\":16}'
```

Look for `prune_metadata` in the response (cost, model, cache fields). If
signing is enabled, you should also see `receipt_signature`.

## Setting a spend cap

Dashboard → Optimize → Shield → set a daily cap on your key. Over budget,
requests return `429` with `X-Prune-Shield-Code: spend_cap`.

## Manual test plan

See [TEST_PLAN.md](./TEST_PLAN.md) for a step-by-step checklist (fresh
install, key out of plaintext, spend cap, signed receipt, tool quirks).

## Get started

Prune is in private beta and free to join right now:
**[withprune.com](https://www.withprune.com)** — sign up, vault a
provider key, and you'll have a `prune_…` key in about 5 minutes.

Full docs: [withprune.com/coding-agents](https://www.withprune.com/coding-agents)

## What this repo is not

- Not the Prune API server
- Not the vault or encryption internals
- Not a fork of Cline / Kilo / OpenCode

## License

Apache License 2.0 — see [LICENSE](./LICENSE).
