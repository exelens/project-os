# Чеклист: новый репозиторий (день 0)

## 0. Репо

- [ ] Имя папки = ожидаемое имя пакета/импортов (если важно)
- [ ] Private remote · ветка `main`
- [ ] `.gitignore` (env, caches, build, secrets)
- [ ] `.env.example` без секретов

## 1. Project OS

- [ ] Разложено через `scripts/apply_to_repo.sh` **или** копией `scaffold/`
- [ ] Есть `AGENTS.md`, `docs/`, `prism/`, `tests/README.md`, `reviews/`, `.cursor/rules/project-os.mdc` (или `cursor-rules/project-os.mdc` для ручного переноса)
- [ ] Kit `README.md` / `APPLY` / `LIFT` **не** лежат как корневой README продукта
- [ ] Маркеры `TODO_` заполнены или явно отложены в `docs/stages.md`

## 2. Минимальный контур качества

- [ ] Одна команда быстрого теста
- [ ] Один lint/format (или «пока нет» в stages)
- [ ] README: как запустить локально

## 3. Canon seed

- [ ] 2–3 строки в canon-owners (даже TBD owner)
- [ ] Этап в stages.md честный (Spike ≠ Open Beta)

## DoD

Агент по `@AGENTS.md` понимает: где SSOT, как тестить, что нельзя, как Prism — без истории другого проекта.

## Ссылки

- Агент в существующем репо: [agent-workflow.md](agent-workflow.md)
