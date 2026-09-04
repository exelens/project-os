#!/usr/bin/env bash
# Apply Project OS scaffold into a product repository.
# Usage:
#   ./scripts/apply_to_repo.sh /path/to/product-repo
#   ./scripts/apply_to_repo.sh /path/to/product-repo --force
set -euo pipefail

FORCE=0
TARGET=""
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    -h|--help)
      sed -n '2,6p' "$0"
      exit 0
      ;;
    *)
      if [[ -z "$TARGET" ]]; then
        TARGET=$arg
      else
        echo "Unexpected arg: $arg" >&2
        exit 2
      fi
      ;;
  esac
done

if [[ -z "${TARGET}" ]]; then
  echo "Usage: $0 /path/to/product-repo [--force]" >&2
  exit 2
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KIT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SCAFFOLD="$KIT_ROOT/scaffold"

if [[ ! -d "$SCAFFOLD" ]]; then
  echo "Missing scaffold at $SCAFFOLD" >&2
  exit 1
fi

if [[ "$TARGET" == "/" ]]; then
  echo "Error: TARGET is / — refusing to scaffold." >&2
  exit 2
fi

mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"

# Safety: never scaffold into the kit itself or a path under it
if [[ "$TARGET" == "$KIT_ROOT" || "$TARGET" == "$KIT_ROOT"/* ]]; then
  echo "Error: TARGET is the kit itself (or inside it) — refusing to scaffold." >&2
  echo "  kit:    $KIT_ROOT" >&2
  echo "  target: $TARGET" >&2
  exit 2
fi

copy_file() {
  local src=$1
  local dest=$2
  mkdir -p "$(dirname "$dest")"
  if [[ -e "$dest" && "$FORCE" -ne 1 ]]; then
    echo "skip (exists): ${dest#"$TARGET"/}"
    return 0
  fi
  cp "$src" "$dest"
  echo "wrote: ${dest#"$TARGET"/}"
}

CURSOR_OK=1
if ! mkdir -p "$TARGET/.cursor/rules" 2>/dev/null; then
  CURSOR_OK=0
  echo "warn: cannot create .cursor/rules — will keep cursor-rules/ for manual move"
fi

while IFS= read -r -d '' src; do
  rel=${src#"$SCAFFOLD"/}

  if [[ "$rel" == cursor-rules/* ]]; then
    # Always keep portable copy
    copy_file "$src" "$TARGET/cursor-rules/${rel#cursor-rules/}"
    if [[ "$CURSOR_OK" -eq 1 ]]; then
      copy_file "$src" "$TARGET/.cursor/rules/${rel#cursor-rules/}"
    fi
    continue
  fi

  copy_file "$src" "$TARGET/$rel"
done < <(find "$SCAFFOLD" -type f -print0)

if [[ ! -f "$TARGET/README.md" ]]; then
  cat > "$TARGET/README.md" << 'EOF'
# TODO_PROJECT_NAME

Кратко: что это за продукт.

## Старт

1. Заполни маркеры `TODO_` (`rg 'TODO_' -n`).
2. Пройди `docs/checklists/new-repo.md`.
3. Методология: `AGENTS.md` · `prism/README.md` · `QUICKSTART.md`.

EOF
  echo "wrote: README.md (stub)"
else
  echo "skip (exists): README.md (product kept)"
fi

echo
echo "Done → $TARGET"
echo "Next: open QUICKSTART.md and fill TODO_ markers (rg 'TODO_' -n)."
if [[ "$CURSOR_OK" -ne 1 ]]; then
  echo "Cursor rule: move cursor-rules/project-os.mdc → .cursor/rules/project-os.mdc"
fi
