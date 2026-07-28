# Point your coding agent at Prune

If you're using Cline, Kilo Code, OpenCode, or Zoo Code with your own API
key — in the editor, the CLI, or via SDK — your provider key is sitting in
plaintext in a local config file right now. There's no spend limit
stopping a runaway session from blowing past what you meant to spend, and
no record of what any single call actually cost.

**Prune fixes all three of those in one line of code, regardless of which
surface you use.**

## What you get

- **Your key is never exposed.** Vault your real OpenAI / Anthropic /
  OpenRouter key once in Prune. Your agent only ever sees a `prune_…` key
  — the real one never touches your local config, your CLI history, or
  your dotfiles.
- **A hard spend cap, enforced before the call happens.** Set a daily or
  per-run budget. Prune blocks the request *before* it's made if you're
  over — not after you've already been billed.
- **Lower bills, automatically.** Prune caches and compresses your traffic
  by default — including near-duplicate requests, not just exact repeats.
  Nothing to configure; it's on from the moment you're routed through
  Prune.
- **A signed receipt for every call.** Every response includes a
  cryptographically verifiable record of exactly what it cost, which
  model was used, and whether it was served from cache. Verify any
  receipt at [withprune.com/verify](https://www.withprune.com/verify).

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

Same OpenAI Compatible path as Cline.

Full config: [configs/zoo-code.md](./configs/zoo-code.md)

## Try it in 2 minutes

```bash
./examples/curl-smoke.sh prune_your_key
```

Look for `prune_metadata` in the response — it includes cost, cache
status, and whether the call was served from cache and saved you money.

## Setting a spend cap

Dashboard → Optimize → Shield → set a daily cap on your key. Over budget,
requests return `429` with `X-Prune-Shield-Code: spend_cap` — blocked
before it costs you anything.

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
