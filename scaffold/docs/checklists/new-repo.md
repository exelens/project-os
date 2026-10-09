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

- [ ] Одна команда быстрого теста (`tests/README.md` TODO_FAST)
- [ ] Один lint/format (или «пока нет» в stages)
- [ ] README: как запустить локально
- [ ] Вес workflow понятен: [../workflow-weight.md](../workflow-weight.md)
- [ ] Есть чистые формулы / helpers → запланируй Hypothesis (или аналог) в fast suite
- [ ] Есть OpenAPI / HTTP API → запланируй Schemathesis (отдельная команда; не обязательно day-0 CI)
- [ ] Горячие KPI/пороги → mutation точечно (Gap в stages ок на Spike)

## 3. Canon seed

- [ ] 2–3 строки в canon-owners (даже TBD owner)
- [ ] Этап в stages.md честный (Spike ≠ Open Beta)
- [ ] UI/витрина есть → заполни `docs/voice.md` (тиры · словарь · баны · эталон first screen); иначе «voice — later» в stages

## 4. Public (когда появится, не день 0)

- [ ] [ci-cd.md](ci-cd.md) — развилки CI vs CD зафиксированы
- [ ] [../deployment.md](../deployment.md) + [../../deploy/](../../deploy/) — env/compose stubs адаптированы
- [ ] [public-vps.md](public-vps.md) — чеклист подъёма начат
- [ ] `ci.example.yml` → рабочий `ci.yml` **без** автодеплоя, пока ops не решил иначе

## DoD

Агент по `@AGENTS.md` понимает: где SSOT, как тестить, что нельзя, как Prism — без истории другого проекта.

## Ссылки

- Агент в существующем репо: [agent-workflow.md](agent-workflow.md)
- CI/CD: [ci-cd.md](ci-cd.md)
