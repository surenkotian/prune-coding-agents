# Manual test plan — Prune coding-agent integration

Run this yourself after a fresh install of each tool. Approximate times below
are **setup only** (install + config). Cap / receipt checks add a few minutes
per tool. If you are far over the estimate, you are hitting real friction —
note where and open an issue.

## Shared prep (once) — ~5 min

- [ ] Fresh Prune account / unused `prune_…` key
- [ ] Vault only a cheap model (e.g. `gpt-4o-mini`) under Connect → Providers
- [ ] Confirm **no** `sk-` / `sk-ant-` / OpenRouter key will be pasted into agents
- [ ] Baseline smoke succeeds:
      - Bash / Git Bash: `./examples/curl-smoke.sh prune_…`
      - PowerShell: the two `curl.exe` requests documented in the README
- [ ] Note dashboard: usage empty → expect first receipt after tool tests
- [ ] Plan spend-cap test: Shield daily cap near `$0.05`, **or** run-budget
      headers (`X-Prune-Run-Budget-Usd`)

---

## A. Cline — expected ~5–10 min setup

**Install**
- [ ] VS Code (or compatible) with Cline installed fresh; clear prior Cline secrets if reusing a machine
- [ ] Open empty folder; no `.env` with provider keys

**Configure** — follow [configs/cline.md](./configs/cline.md)
- [ ] API Provider = OpenAI Compatible
- [ ] Base URL = `https://api.withprune.com/v1`
- [ ] API Key = `prune_…` only
- [ ] Model ID = vaulted id

**Success looks like**
- [ ] Short chat returns a model reply
- [ ] Prune dashboard shows a new request / receipt
- [ ] Response includes `prune_metadata` (network tab, logs, or curl twin)
- [ ] If signing enabled: paste receipt into https://www.withprune.com/verify → valid
- [ ] Cline settings / export contain `prune_…`, **not** provider `sk-…`

**Spend cap**
- [ ] Cap near zero (or run budget `$0` / `$0.001` if headers possible)
- [ ] Next call fails: `429`, `X-Prune-Shield-Code` = `spend_cap` or `run_budget`
- [ ] Raise/remove cap → next call succeeds

**Failure modes**
- Base URL missing `/v1` or doubled `/v1/v1` → 404
- Model not vaulted → upstream/auth error, no clean receipt
- Real OpenAI key instead of `prune_…` → bypasses Prune (no dashboard row)
- Streaming: receipt may appear after stream completes

**Friction signal:** still configuring after ~15 min without a successful reply.

---

## B. Kilo Code — expected ~5–10 min setup

Same checklist as Cline (OpenAI Compatible path). See [configs/kilo-code.md](./configs/kilo-code.md).

**Extra quirks**
- [ ] Using **BYOK / OpenAI Compatible**, not Kilo Gateway subscription-only
- [ ] If both “OpenAI” and “OpenAI Compatible” exist, use Compatible + custom base URL
- [ ] After Roo-style import: wipe inherited `sk-` keys
- [ ] Success = reply + Prune receipt + only `prune_…` in secrets
- [ ] Fail = no Prune usage row, or 401 from wrong base URL

**Friction signal:** still configuring after ~15 min, or traffic never appears in Prune.

---

## C. OpenCode — expected ~10–15 min setup

**Install**
- [ ] Fresh `opencode` install; rename aside any prior `~/.config/opencode`

**Configure** — [configs/opencode/](./configs/opencode/)
- [ ] Copy `opencode.json.example` → `~/.config/opencode/opencode.json`
- [ ] `opencode auth login` → Other → id `prune` → paste `prune_…`
- [ ] JSON has `baseURL`, **no** plaintext `apiKey`

**Success looks like**
- [ ] Chat with `prune/<model>` returns a reply
- [ ] Dashboard receipt appears
- [ ] `prune_metadata` visible; `/verify` passes if signed

**Spend cap** — same as Cline; use `options.headers` for run budgets if needed

**Failure modes**
- Wrong npm package (`@ai-sdk/openai` vs `openai-compatible`) → path mismatch
- Model not under `models` → missing from picker
- Auth skipped / wrong provider id → calls miss Prune

**Friction signal:** still stuck after ~20–25 min (config + auth is the usual slow path).

---

## D. Zoo Code (optional) — expected ~5–10 min setup

Same as Cline. See [configs/zoo-code.md](./configs/zoo-code.md).

- [ ] Watch for Roo-imported settings reintroducing old keys

**Friction signal:** same as Cline (~15 min).

---

## Cross-tool “broken integration” signals

| Signal | Meaning |
|--------|---------|
| Agent works, **zero** Prune usage | Key/base URL bypassed Prune |
| `401` / invalid key | Wrong `prune_…` or key revoked |
| `404` on chat | Bad base URL path |
| `429` + `spend_cap` / `run_budget` | Cap working (expected in block test) |
| Reply OK but no `receipt_signature` | Signing off on server — OK if `prune_metadata` present |
| Provider `sk-` in exported settings | Failed “key out of plaintext” goal |

## Time budget summary

| Step | Expect |
|------|--------|
| Shared Prune prep | ~5 min |
| Cline | ~5–10 min |
| Kilo Code | ~5–10 min |
| OpenCode | ~10–15 min |
| Zoo Code (optional) | ~5–10 min |
| Cap + verify per tool | ~3–5 min each |

Total for Cline + Kilo + OpenCode (no Zoo): roughly **40–60 minutes** including cap/receipt checks.
