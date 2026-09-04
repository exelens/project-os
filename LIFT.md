# Публикация и версионирование Project OS

Kit уже самостоятельный (эта папка). Цель: свой git remote на GitHub; продуктовые репо больше не owner.

## Выкладка на GitHub

```bash
cd /path/to/project-os   # эта папка

# если ещё нет .git:
git init
git add .
git commit -m "$(cat <<'EOF'
Initial Project OS kit (scaffold + apply script + Prism).

EOF
)"

# нужен рабочий gh auth: gh auth login   или   gh auth refresh
gh repo create project-os --public --source=. --remote=origin --push \
  --description "Portable project operating system: canon, docs, tests, Prism"
```

Private:

```bash
gh repo create project-os --private --source=. --remote=origin --push
```

После push поправь clone-URL в [README.md](./README.md) (`TODO_GITHUB_USER`).

В продуктовый репо потом:

```bash
./scripts/apply_to_repo.sh /path/to/product
```

Не сырой `cp` kit `README.md` / `LIFT.md` / `SOURCE.md` / `APPLY.md` поверх продукта.

Если kit жил внутри другого monorepo — после выноса убери копию оттуда или оставь ссылку на GitHub.

## Версионирование

- `1.0.0` = scaffold + apply + Prism 01–08 стабильны (см. [CHANGELOG.md](./CHANGELOG.md)).
- Breaking: смена ID-схемы Prism / wipe-правил / формата backlog → major bump + запись в CHANGELOG.
- Тег: `git tag v1.0.0 && git push origin v1.0.0`

## Cursor skill (опционально)

`~/.cursor/skills/project-os/SKILL.md` → триггер на START / apply / canon-owners.
