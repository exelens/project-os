# Чеклист: новый репозиторий (день 0)

## 0. Репо

- [ ] Имя папки = ожидаемое имя пакета/импортов (если важно)
- [ ] Private remote · ветка `main`
- [ ] Kit `.gitignore` + `.env.example` из `scaffold/` применены (или свои) — секреты не в git
- [ ] Реальный `.env` не коммитить; значения читать из окружения

## 1. Project OS

- [ ] Разложено через `scripts/apply_to_repo.sh` **или** копией `scaffold/`
- [ ] Есть `AGENTS.md`, `docs/`, `prism/`, `tests/README.md`, `reviews/`, `.cursor/rules/project-os.mdc` (или `cursor-rules/project-os.mdc` для ручного переноса)
- [ ] Kit `README.md` / `APPLY` / `LIFT` **не** лежат как корневой README продукта
- [ ] Маркеры `TODO_` заполнены или явно отложены в `docs/stages.md`
- [ ] Пройден [localize.md](localize.md) (агент или вручную)
- [ ] Есть thin shims: `CLAUDE.md`, `.github/copilot-instructions.md` → `AGENTS.md`
- [ ] `lint_agents_md.sh AGENTS.md` зелёный (скрипт из kit `scripts/`)

## 2. Минимальный контур качества

- [ ] Одна команда быстрого теста
- [ ] Один lint/format (или «пока нет» в stages)
- [ ] README: как запустить локально
- [ ] Вес workflow понятен: [../workflow-weight.md](../workflow-weight.md)

## 3. Canon seed

- [ ] 2–3 строки в canon-owners (даже TBD owner)
- [ ] Этап в stages.md честный (Spike ≠ Open Beta)
- [ ] UI/витрина есть → заполни `docs/voice.md` (аудитории · словарь · зоны); иначе «voice — later» в stages

## DoD

Агент по `@AGENTS.md` понимает: где SSOT, как тестить, что нельзя, как Prism — без истории другого проекта.

## Ссылки

- Агент в существующем репо: [agent-workflow.md](agent-workflow.md)
