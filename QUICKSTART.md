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

| Файл | Что |
|------|-----|
| `AGENTS.md` | имя, стек, путь юзера, команды тестов |
| `docs/stages.md` | честный этап (Spike / …) |
| `docs/canon-owners.md` | 2–3 реальных понятия |
| `tests/README.md` | как запускать тесты |
| `README.md` | как поднять локально |

Cursor: если нет `.cursor/rules/project-os.mdc` → из `cursor-rules/project-os.mdc`.  
День 0: `docs/checklists/new-repo.md`.

## 3. Smoke для агента

> Прочитай `AGENTS.md` и `docs/canon-owners.md`. Где SSOT, как тестить, когда Prism?

Ок, если отвечает по файлам, а не «придумаем процесс».

## Дальше

| Нужно | Куда |
|-------|------|
| Prism | `prism/README.md` |
| Новый домен продукта | `prism/DOMAIN.md` |
| Осознанный долг | `docs/accepted-debt.md` |
| Вынести kit в отдельный git | [LIFT.md](./LIFT.md) |
