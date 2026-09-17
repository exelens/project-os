# Quickstart

Разложить Project OS в новый (или пустой) репозиторий и начать работу.

Агент-агностично: после apply достаточно `@AGENTS.md` / чтения файлов — в **Cursor**, **Crush**, **Claude Code** или другом агенте.

## 1. Apply

```bash
cd /path/to/project-os          # эта папка kit
chmod +x scripts/apply_to_repo.sh
./scripts/apply_to_repo.sh /path/to/your-product-repo
```

Повторно с перезаписью файлов OS (`README.md` продукта не затирается):

```bash
./scripts/apply_to_repo.sh /path/to/your-product-repo --force
```

Вручную: скопируй содержимое `scaffold/` в корень продукта;  
`scaffold/cursor-rules/project-os.mdc` → `.cursor/rules/project-os.mdc`.  
Не копируй kit `README.md` поверх продукта. Карта: [APPLY.md](./APPLY.md).

## 2. Fill

```bash
cd /path/to/your-product-repo
rg 'TODO_' -n
```

Или отдай агенту чеклист [scaffold → `docs/checklists/localize.md`](./scaffold/docs/checklists/localize.md) (после apply лежит в продукте).

| Файл | Что |
|------|-----|
| `AGENTS.md` | имя, стек, путь юзера, команды тестов |
| `docs/stages.md` | честный этап (Spike / …) |
| `docs/workflow-weight.md` | ориентир L0–L3 (обычно не правят) |
| `docs/canon-owners.md` | 2–3 реальных понятия |
| `docs/voice.md` | тон UI (если витрина/кабинет; иначе «voice — later» в stages) |
| `.env.example` | имена переменных без секретов |
| `tests/README.md` | как запускать тесты |
| `README.md` | как поднять локально |

Cursor: `scripts/apply_to_repo.sh` сам ставит `.cursor/rules/project-os.mdc` (и portable-копию в `cursor-rules/`); при ручном переносе — из `cursor-rules/project-os.mdc`.  
Shims: `CLAUDE.md`, `.github/copilot-instructions.md` → `AGENTS.md`.  
День 0: `docs/checklists/new-repo.md`.

Проверка канона агента:

```bash
/path/to/project-os/scripts/lint_agents_md.sh AGENTS.md
```

## 3. Smoke для агента

> Прочитай `AGENTS.md` и `docs/canon-owners.md`. Где SSOT, как тестить, какой вес workflow (L0–L3), когда Prism?

Ок, если отвечает по файлам, а не «придумаем процесс».

## Дальше

| Нужно | Куда |
|-------|------|
| Вес workflow | `docs/workflow-weight.md` |
| Localize TODO_ | `docs/checklists/localize.md` |
| Prism | `prism/README.md` |
| Evidence волны | `prism/evidence.md` |
| Стой (межцикл triage) | `prism/pisdetscheck.md` — не слой |
| Новый домен продукта | `prism/DOMAIN.md` (только ничейная зона — не дубль 03/04) |
| Тон / словарь UI | `docs/voice.md` |
| Осознанный долг | `docs/accepted-debt.md` |
| Lint AGENTS.md | `scripts/lint_agents_md.sh` (в kit) |
| Вынести kit в отдельный git | [LIFT.md](./LIFT.md) |
