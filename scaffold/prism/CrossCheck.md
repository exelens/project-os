# CrossCheck — Анти-дубли и логические рассинхроны

Не слой Prism. Нет номера `0N`, нет префикса ID, нет `reviews/NN-…`. Это не код-ревью, это поиск аномалий в структуре и логике.

**Когда:** перед крупным Feature или рефактором модуля; когда «код раздулся» или старые паттерны мешают новым.

**Не когда:** вместо полного Prism (01–08); не для опечаток; не для «лучших практик» без боли.

**Артефакт:** `crosscheck.md` (или `cc.md`) в корне — **scratch**. После FIX wipe (как `reviews/`); close — строка в [docs/prism_errors.md](../docs/prism_errors.md).

**В чат:** `@prism/CrossCheck.md`. После аудита — отдельный чат FIX по Disposition. На audit код не менять.

Последний цикл: **2026-09-24 FIX closed** (scratch wiped) → [prism_errors.md](../docs/prism_errors.md) · baseline **917**/**609**.

Заполни `TODO_` под продукт. Поиск: `rg 'TODO_' prism/CrossCheck.md`.

---

## Промпт (копировать в чат)

```
Ты в репозитории Seoporka. Режим: READ-ONLY аудит. Код, тесты, docs канона продукта и каноны НЕ менять.

Цель: найти дублирование логики, противоречия в реализации и ошибки изоляции, которые тормозят разработку или вызывают баги. Записать ТОЛЬКО в crosscheck.md в корне продукта (или cc.md).

Скоуп (читай код + тесты; codegraph — ок, если есть):

- seoporka/ (все модули, особенно те, что часто меняются вместе)
- web/composables + shared UI кабинета (components/ · pages/projects)
- tests/ (покрытие именно той логики, что в коде, не выдуманной)

Вне скоупа (не предлагать «починить», максимум одна строка ACCEPTED):

- SEO Quest / Celery / SERP / Google / GSC / Wordstat
- стиль кода, имена, форматирование
- «переписать на X», если текущий код работает
- дубли, уже задокументированные в docs/заглушки.md (не docs/accepted-debt.md — файла нет)

Ищи по классам (каждый finding — один класс):

- Logic Duplication (SSOT Break)
- Logic Contradiction
- Isolation Error (Test/Env)
- Logic Error (Edge Case)
- Ghost Code / Dead Branch

НЕ делать: рефактор / PoC / раздувать мелкий копипаст / новую архитектуру без evidence.

Формат артефакта — шаблон ниже. Максимум 20 findings.
Хвост: код не меняй. Чужие reviews/* не трогай.
После FIX — wipe crosscheck.md; close в docs/prism_errors.md.
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
