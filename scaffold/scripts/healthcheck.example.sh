#!/usr/bin/env bash
# Public health probe — copy to scripts/healthcheck.sh and adjust URL.
# Usage: ./scripts/healthcheck.sh [URL]
# Default: http://127.0.0.1:8000/health
set -euo pipefail

URL="${1:-http://127.0.0.1:8000/health}"
TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

code="$(curl -sS -o "$TMP" -w '%{http_code}' --max-time 10 "$URL" || true)"
if [[ "$code" != "200" ]]; then
  echo "health FAIL url=$URL http=$code body=$(head -c 200 "$TMP" 2>/dev/null || true)" >&2
  exit 1
fi
echo "health ok url=$URL"
exit 0
