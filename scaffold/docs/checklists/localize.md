# Localize Project OS (заполнить TODO_)

Запускай **один раз** после `apply_to_repo.sh` (или после ручной разкладки scaffold).  
Цель: агент заполняет маркеры из **доказательств репо**, не из фантазии.

В чат агенту (Cursor / Crush / Claude Code):

> Прочитай этот чеклист и `AGENTS.md`. Обойди репо (package manifests, Makefile/just, CI, README, тесты).  
> Заполни все `TODO_` / `TODO:` в файлах Project OS фактами из репо.  
> Если факта нет — напиши честный TBD + строку в `docs/stages.md`, не выдумывай стек.  
> Не трогай продуктовый код, кроме `.env.example` (только имена переменных).  
> В конце: `rg 'TODO_' -n` и кратко перечисли, что осталось намеренно.

## Порядок

1. **Идентичность** — `AGENTS.md`: имя продукта, дата, remote, стек (1 строка).
2. **Команды** — быстрый тест / полный suite / lint из реальных скриптов; иначе «пока нет» в stages.
3. **Контур** — `.env.example` имена; БД / очередь — да/нет по коду.
4. **Canon seed** — 2–3 понятия в `docs/canon-owners.md` (даже TBD owner).
5. **Этап** — `docs/stages.md` честный (Spike ≠ Open Beta).
6. **Voice** — UI есть → заполни `docs/voice.md`; иначе «voice — later» в stages.
7. **README продукта** — как поднять локально (не kit README).
8. **Вес** — глянь [workflow-weight.md](../workflow-weight.md): для Spike чаще L0.
9. **Lint** — из корня продукта:  
   `path/to/project-os/scripts/lint_agents_md.sh AGENTS.md`  
   (или скопированный скрипт). Цель — exit 0 без `--allow-todo`.

## DoD

- `rg 'TODO_' -n` пуст **или** остатки явно отложены в `stages.md`
- Агент по `@AGENTS.md` отвечает: где SSOT, как тестить, какой вес workflow, когда Prism
- `lint_agents_md.sh AGENTS.md` зелёный

## Не делать

- Не копировать историю другого продукта
- Не invent product claims / метрики
- Не запускать полный Prism на localize
