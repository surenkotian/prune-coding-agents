#!/usr/bin/env bash
# Smoke-test Prune OpenAI-compatible endpoints.
# Usage: ./examples/curl-smoke.sh prune_your_key [model_id]
#
# Windows: run from Git Bash, or WSL. For native PowerShell, use the
# curl.exe examples in the README instead of this script.
set -euo pipefail

KEY="${1:-}"
MODEL="${2:-gpt-4o-mini}"
BASE="${PRUNE_BASE_URL:-https://api.withprune.com/v1}"

if [[ -z "$KEY" ]]; then
  echo "Usage: $0 prune_your_key [model_id]" >&2
  exit 1
fi

echo "== GET $BASE/models =="
curl -sS "$BASE/models" \
  -H "Authorization: Bearer $KEY" | head -c 2000
echo
echo

echo "== POST $BASE/chat/completions (model=$MODEL) =="
curl -sS "$BASE/chat/completions" \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\":\"$MODEL\",\"messages\":[{\"role\":\"user\",\"content\":\"ping\"}],\"max_tokens\":16}"
echo
