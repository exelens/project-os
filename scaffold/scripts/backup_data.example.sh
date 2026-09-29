#!/usr/bin/env bash
# Backup data dir — copy to scripts/backup_data.sh and set DATA_DIR / DEST.
# Usage: ./scripts/backup_data.sh [DEST_DIR]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

DATA_DIR="${DATA_DIR:-.data}"
DEST="${1:-$HOME/Backups/TODO_PROJECT_SLUG}"
STAMP="$(date +%Y%m%d-%H%M)"

if [[ ! -d "$DATA_DIR" ]]; then
  echo "нет каталога данных: $DATA_DIR (DATA_DIR?)" >&2
  exit 1
fi

mkdir -p "$DEST"
OUT="$DEST/data-$STAMP.tgz"
tar -czf "$OUT" -C "$(dirname "$DATA_DIR")" "$(basename "$DATA_DIR")"
echo "ok: $OUT ($(du -h "$OUT" | awk '{print $1}'))"
echo "restore: stop API → mv $DATA_DIR ${DATA_DIR}.broken-\$STAMP → tar -xzf $OUT"
