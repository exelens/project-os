# Ручная разкладка (без скрипта)

Предпочтительно: [QUICKSTART.md](./QUICKSTART.md) → `scripts/apply_to_repo.sh`.

Если вручную:

1. Скопируй **содержимое** [`scaffold/`](./scaffold/) в корень продукта.
2. `scaffold/cursor-rules/project-os.mdc` → `.cursor/rules/project-os.mdc`.
3. **Не** копируй kit `README.md` / `LIFT.md` / `SOURCE.md` / `APPLY.md` в корень продукта.
4. Заполни `TODO_` (`rg 'TODO_' -n`).
5. Пройди `docs/checklists/new-repo.md`.
