# CrossCheck — Анти-дубли и логические рассинхроны

Не слой Prism. Нет номера `0N`, нет префикса ID, нет `reviews/NN-…`. Это не код-ревью, это поиск аномалий в структуре и логике.

**Когда:** перед крупным Feature или рефактором модуля; когда «код раздулся» или старые паттерны мешают новым.

**Не когда:** вместо полного Prism (01–08); не для опечаток; не для «лучших практик» без боли; не вместе с LatencyCheck / ArchitectureCheck / pisdetscheck в одном чате.

**Артефакт:** `crosscheck.md` (или `cc.md`) в корне — **scratch**. После FIX wipe (как `reviews/`); close — строка в [docs/prism-cycle-summary.md](../docs/prism-cycle-summary.md). Residual → [docs/accepted-debt.md](../docs/accepted-debt.md).

**В чат:** `@prism/CrossCheck.md`. После аудита — отдельный чат FIX по Disposition. На audit код не менять.

Заполни `TODO_` под продукт. Поиск: `rg 'TODO_' prism/CrossCheck.md`.

---

## Соседи (не конфликтуют)

| Ритуал / слой | Вопрос | CrossCheck |
|---------------|--------|------------|
| **01–08** (+ domains) | контракт / UX / домен | другой календарь; findings → свои ID |
| **04** | SSOT в цикле Prism | здесь — межцикловые дубли без `B-*` |
| **03** | dirty / local smell | не complexity ради complexity |
| **ArchitectureCheck** | god LOC/fan-in · smear · peel-границы | сюда не как god-таблица; → ArchitectureCheck |
| Trust contours | зерно / list≠detail / источники в KPI | сюда не как Logic Duplication; → `T-*` |
| **LatencyCheck** | GET секунды+ | чистый latency → туда |
| **pisdetscheck** | смешанная dogfood-боль | чистый SSOT-dup → сюда; смесь классов → pisdetscheck |

Один finding — один дом.

---

## Промпт (копировать в чат)

```
Ты в репозитории TODO_PROJECT_NAME. Режим: READ-ONLY аудит. Код, тесты, docs канона продукта и каноны НЕ менять.

Цель: найти дублирование логики, противоречия в реализации и ошибки изоляции, которые тормозят разработку или вызывают баги. Записать ТОЛЬКО в crosscheck.md в корне продукта (или cc.md).

Скоуп (читай код + тесты; codegraph — ок, если есть):

- TODO_SRC (модули, особенно те, что часто меняются вместе)
- TODO_UI (composables + shared UI)
- tests/ (покрытие именно той логики, что в коде, не выдуманной)

Вне скоупа (не предлагать «починить», максимум одна строка ACCEPTED):

- TODO_OUT_OF_SCOPE
- стиль кода, имена, форматирование
- «переписать на X», если текущий код работает
- дубли, уже в docs/accepted-debt.md
- чистый cabinet latency (секунды+ / sync-on-GET) → LatencyCheck
- god LOC/fan-in / smear-таблица / peel-границы без logic contradiction → ArchitectureCheck
- trust-grain / list≠detail / смешение источников в KPI → trust contours (T-*)

Ищи по классам (каждый finding — один класс):

- Logic Duplication (SSOT Break)
- Logic Contradiction
- Isolation Error (Test/Env)
- Logic Error (Edge Case)
- Ghost Code / Dead Branch

НЕ делать: рефактор / PoC / раздувать мелкий копипаст / новую архитектуру без evidence.

Формат артефакта — шаблон ниже. Максимум 20 findings.
Хвост: код не меняй. Чужие reviews/* не трогай.
После FIX — wipe crosscheck.md; close — строка в docs/prism-cycle-summary.md; residual — docs/accepted-debt.md.
```

---

## Шаблон артефакта (корень `crosscheck.md`)

```markdown
# crosscheck — audit YYYY-MM-DD (scratch)

## Summary
- Duplicates: N · Contradictions: N · Isolation: N · Logic Errors: N · Ghost: N
- 3–5 главных рисков одной строкой каждый

## Findings
### D-1 · <title>
- Class: duplicate|contradiction|isolation|logic|ghost
- Where: path:symbol AND path:symbol
- Evidence: …
- Impact: …
- Disposition: FIX | ACCEPTED | DEFER — почему
- Not: что НЕ чинить

## Out of scope / already closed
- …
```

## Правила triage

- **Duplicate:** смена правила требует правки >1 файла.
- **Contradiction:** два модуля делают разное при одинаковом входе.
- **Isolation:** флаттер / порядок тестов / грязный env.
- **Logic Error:** воспроизводимый edge.
- **Ghost:** ветка, которая физически не выполняется.
