#!/usr/bin/env bash
# Lint AGENTS.md for Project OS product repos (and scaffold with --allow-todo).
# Usage:
#   ./scripts/lint_agents_md.sh [path/to/AGENTS.md]
#   ./scripts/lint_agents_md.sh scaffold/AGENTS.md --allow-todo
set -euo pipefail

ALLOW_TODO=0
FILE=""
for arg in "$@"; do
  case "$arg" in
    --allow-todo) ALLOW_TODO=1 ;;
    -h|--help)
      cat <<'EOF'
Usage: lint_agents_md.sh [AGENTS.md] [--allow-todo]

Checks:
  - file exists and is non-empty
  - required section headings (RU kit)
  - pointers to canon-owners / prism / tests
  - no leftover TODO_ markers (unless --allow-todo)

Exit 0 = ok, 1 = fail.
EOF
      exit 0
      ;;
    *)
      if [[ -z "$FILE" ]]; then
        FILE=$arg
      else
        echo "Unexpected arg: $arg" >&2
        exit 2
      fi
      ;;
  esac
done

FILE=${FILE:-AGENTS.md}

if [[ ! -f "$FILE" ]]; then
  echo "FAIL: missing $FILE" >&2
  exit 1
fi

if [[ ! -s "$FILE" ]]; then
  echo "FAIL: empty $FILE" >&2
  exit 1
fi

fail=0
note() { echo "  · $*"; }
err() { echo "FAIL: $*" >&2; fail=1; }

# Required headings (Project OS RU scaffold). Accept either exact or close variants.
required_patterns=(
  'ОБЗОР'
  'НАВИГАЦИЯ'
  'КАНОН'
  'СОГЛАШЕНИЯ'
  'АНТИПАТТЕРН'
  'РАБОЧИЙ ПРОЦЕСС'
  'PRISM'
)

for pat in "${required_patterns[@]}"; do
  if ! grep -Eq "^#+ .*${pat}" "$FILE"; then
    err "missing heading matching /${pat}/"
  fi
done

# Must point agents at living docs (paths may be relative markdown links).
for needle in 'canon-owners' 'prism' 'tests'; do
  if ! grep -Eqi "$needle" "$FILE"; then
    err "no mention of '${needle}' (agent needs a pointer)"
  fi
done

# Runnable commands block: at least one fenced bash/shell or indented command hint.
if ! grep -Eq '^(```|    ).*' "$FILE"; then
  err "no code/command block — add real test/lint commands"
fi

todo_count=0
if command -v rg >/dev/null 2>&1; then
  todo_count=$(rg -c 'TODO_' "$FILE" 2>/dev/null || true)
  # rg -c prints count per file or nothing; normalize
  if [[ -z "$todo_count" ]]; then
    todo_count=0
  elif [[ "$todo_count" == *:* ]]; then
    todo_count=${todo_count##*:}
  fi
else
  todo_count=$(grep -c 'TODO_' "$FILE" || true)
fi

if [[ "$todo_count" -gt 0 ]]; then
  if [[ "$ALLOW_TODO" -eq 1 ]]; then
    note "TODO_ markers: $todo_count (allowed)"
  else
    err "found $todo_count TODO_ marker(s) — fill or use --allow-todo for scaffold"
  fi
fi

if [[ "$fail" -ne 0 ]]; then
  echo "lint_agents_md: FAILED ($FILE)" >&2
  exit 1
fi

echo "lint_agents_md: OK ($FILE)"
note "sections present; pointers ok; TODO_ policy satisfied"
exit 0
