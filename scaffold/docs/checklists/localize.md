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
2. **Режим** — блок «Текущий режим»: `BUILD` | `FINISH, NOT EXPAND` | `AUDIT ONLY`; кратко «сделано / later / нужен GO». Не копируй летопись другого продукта.
3. **Команды** — быстрый тест / полный suite / lint из реальных скриптов; иначе «пока нет» в stages. Заполни в `tests/README.md`: TODO_FAST · TODO_FE · TODO_SCHEMA (Schemathesis) · TODO_HYPOTHESIS · TODO_MUTATE — или Gap.
4. **Контур** — `.env.example` имена; БД / очередь — да/нет по коду.
5. **Canon seed** — 2–3 понятия в `docs/canon-owners.md` (даже TBD owner).
6. **Light DDD** — заполни `docs/light-ddd.md` (контексты · словарь · куда писать). Нет соседей → сократи, не invent. Pipeline аналитики — только если он есть в коде.
7. **Этап** — `docs/stages.md` честный (Spike ≠ Open Beta).
8. **Voice** — UI есть → заполни `docs/voice.md` (тиры аудиторий · словарь · баны · эталон first screen · FOUC/emoji если уместно); иначе «voice — later» в stages.
9. **Trust contours** — мультизерно / list≠detail / 2+ источника в KPI → заполни `docs/trust-contours.md`; иначе «trust contours — later» в stages (не плоди пустой SSOT).
10. **README продукта** — как поднять локально (не kit README).
11. **Вес** — глянь [workflow-weight.md](../workflow-weight.md): для Spike чаще L0.
12. **Deploy** — если уже есть VPS/compose: заполни [deployment.md](../deployment.md) и [public-vps.md](public-vps.md); иначе «deploy — later» в stages. Не выдумывай хост/секреты.
13. **Lint** — из корня продукта:  
   `path/to/project-os/scripts/lint_agents_md.sh AGENTS.md`  
   (или скопированный скрипт). Цель — exit 0 без `--allow-todo`.

## DoD

- `rg 'TODO_' -n` пуст **или** остатки явно отложены в `stages.md`
- Агент по `@AGENTS.md` отвечает: где SSOT, как тестить, какой вес workflow, когда Prism
- `lint_agents_md.sh AGENTS.md` зелёный

## Не делать

- Не копировать историю другого продукта
- Не переносить чужой `AGENTS` changelog / Prism ID-дамп
- Не invent product claims / метрики
- Не запускать полный Prism на localize
- Не объявлять `FINISH, NOT EXPAND`, если этап ещё Spike и цель — строить
