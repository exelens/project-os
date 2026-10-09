# ArchitectureCheck — God / smear / границы (peel)

**Не слой Prism.** Нет номера `0N`, нет префикса ID в таблице слоёв, нет `reviews/NN-…`. Не идёт в **07** merge и не в `B-*`.

Межцикловый ритуал рядом с [CrossCheck](./CrossCheck.md), [LatencyCheck](./LatencyCheck.md) и [pisdetscheck](./pisdetscheck.md).

**Когда:** перед крупным peel / «код раздулся» / после серии extract.  
**Не когда:** вместо Prism 01–08; вместе с CrossCheck / LatencyCheck / pisdetscheck в одном чате; «ради CQRS» / microservices без боли.

**Артефакт:** `architecturecheck.md` (или `ac.md`) в **корне продукта** — scratch. После FIX — wipe. Close — одна строка в [docs/prism-cycle-summary.md](../docs/prism-cycle-summary.md). Residual → [docs/accepted-debt.md](../docs/accepted-debt.md).

**В чат:** `@prism/ArchitectureCheck.md` → audit READ-ONLY → отдельный чат FIX. На audit код не менять.

Локальные ID в scratch: `AC-1…` (не путать с domain `A-*` / ядро `B-*`).

Заполни `TODO_` под продукт. Поиск: `rg 'TODO_' prism/ArchitectureCheck.md`.

---

## Что это

Охота на **структурный долг peel**: god-файлы, размазанные политики, плохие границы модулей.

Не senior-ревью запахов внутри файла (**03**). Не назначение owner-модуля без таблицы (**04**). Не «два модуля расходятся на одном входе» без god (**CrossCheck**). Не GET секунды+ (**LatencyCheck**). Не путаница зерна/источников цифр (trust contours).

Вопрос: **что мешает селективному peel с минимальным риском — и где уже можно резать.**

---

## Зачем

1. **03** тонет в local smell; **04** назначает SSOT, но не считает LOC/fan-in таблицей.
2. **CrossCheck** ловит логический dup; здесь — размер, смешение ответственностей, импортный fan-in, циклы, «тянем весь модуль ради 1–2 функций».
3. После волны peel — чтобы не вернуть god и не предложить rewrite.

---

## Соседи (не конфликтуют)

| Ритуал / слой | Вопрос | ArchitectureCheck |
|---------------|--------|-------------------|
| **03** | local dirty / cyclomatic / OOM-shape | сюда — god LOC+смешение+fan-in; local без fan-in → **03** |
| **04** | куда SSOT / seam | сюда — таблица peel-кандидатов; назначение owner без LOC → **04** |
| **CrossCheck** | два модуля расходятся / dup правды | сюда не как Logic Duplication; → CrossCheck |
| **LatencyCheck** | GET секунды+ | чистый latency → туда |
| Trust contours | зерно / list≠detail / источники в одной цифре | honesty → `T-*`; сюда только «helper снова вне owner» как god/smear |
| **pisdetscheck** | смешанная dogfood-боль | смесь классов → туда |

Один finding — один дом. Не гонять ArchitectureCheck в том же чате, что другие межцикловые ритуалы.

---

## Промпт (копировать в чат)

```
Ты в репозитории TODO_PROJECT_NAME. Режим: READ-ONLY архитектурный audit. Код, тесты, docs канона НЕ менять.

Роль: старший разработчик — peel-аудит структуры (не rewrite).

Цель: найти проблемные места трёх типов и записать ТОЛЬКО в architecturecheck.md (или ac.md) в корне продукта.

Скоуп:
- TODO_SRC (пакеты / модули, особенно routes · persist/store · services · adapters)
- TODO_UI (composables · shared UI · критичные pages)
- tests/ только как замки peel / fan-in evidence
- codegraph / wc -l / rg «from X import» — ок

Вне скоупа (макс. 1 строка ACCEPTED):
- TODO_OUT_OF_SCOPE
- полный rewrite · CQRS · microservices · aggregates без боли
- стиль / имена / форматирование
- чистый logic dup / contradiction без god → CrossCheck
- GET секунды+ → LatencyCheck
- trust-grain / list≠detail / смешение источников в KPI → trust contours (T-*)
- local cyclomatic без fan-in / без смешения зон → слой 03
- «куда SSOT» без таблицы LOC/импортов → слой 04
- уже закрытый peel без новой evidence (LOC↑ · fan-in↑ · снова 3+ копий правила · цикл импортов) — см. docs/prism-cycle-summary.md · docs/accepted-debt.md

Ищи ровно три класса (каждый finding — один класс):

1. god — файл/класс >~500–700 LOC ИЛИ смешение 3+ зон (HTTP · DB · бизнес · конфиг · утилиты) ИЛИ >10 публичных методов разных зон ИЛИ импорт из 10+ модулей
2. smear — одно бизнес-правило / магическое число / валидация / формула в 3+ местах без SSOT; отметить противоречия реализаций
3. boundary — цикл импортов · from X import * · модуль тянет 1–2 символа из толстого соседа · логика не в своей папке · знание внутренностей чужого модуля

Ограничения:
- Не предлагай полный rewrite — только селективный peel по боли
- Не предлагай CQRS / микросервисы / aggregates без явной необходимости
- Фокус: максимальный выигрыш в поддерживаемости при минимальном риске
- Максимум ~15 findings (лучше ≤10). Топ-5 обязателен.

Формат артефакта — шаблон ниже.
Хвост: код не меняй. Чужие reviews/* не трогай.
После FIX — wipe architecturecheck.md; close — строка в docs/prism-cycle-summary.md; residual — docs/accepted-debt.md.
```

---

## Шаблон артефакта (корень `architecturecheck.md`)

```markdown
# architecturecheck — audit YYYY-MM-DD (scratch)

## Summary
- God: N · Smear: N · Boundary: N
- 3–5 главных рисков одной строкой каждый

## 1. God-файлы / God-классы

| Проблема | Файл(ы) | LOC / частота | Что смешано / где дублируется | Приоритет |
|----------|---------|---------------|-------------------------------|-----------|
| AC-1 · … | path | ~LOC · imports≈N | зоны 1–5 | высокий/средний/низкий |

Для каждого god (в Findings или под таблицей): путь · LOC · 3–5 ответственностей · сколько модулей импортируют.

## 2. Размазанные политики

| Проблема | Файл(ы) | LOC / частота | Что смешано / где дублируется | Приоритет |
|----------|---------|---------------|-------------------------------|-----------|
| AC-… | path:line · path:line · … | 3+ места | правило · противоречие? | … |

## 3. Плохое разделение модулей

| Проблема | Файл(ы) | LOC / частота | Что смешано / где дублируется | Приоритет |
|----------|---------|---------------|-------------------------------|-----------|
| AC-… | A ↔ B | … | нарушение · пример import/call | … |

## Findings
### AC-1 · <title>
- Class: god|smear|boundary
- Where: path[:symbol] …
- Evidence: LOC / import count / цитата условия …
- Impact: …
- Disposition: FIX (peel) | ACCEPTED | DEFER — почему
- Peel sketch: 1–3 leaf’а или «не peel — rethink» одной строкой
- Not: что НЕ чинить

## Top-5 для рефакторинга
1. … — почему
2. …

## Peel vs rethink
- Точечный peel: …
- Глубже (не в этом цикле): …

## Out of scope / already closed
- …
```

## Правила triage

- **God:** размер + смешение зон + fan-in. Один большой файл с одной зоной и низким fan-in — низкий приоритет или Hand-off в **03**.
- **Smear:** смена правила требует >2 файлов **и** нет owner в каноне; иначе → CrossCheck / **04**.
- **Boundary:** цикл, `import *`, wrong folder, leak internals. «Нужны 1–2 функции» без боли — низкий, не extract ради extract.
- **Peel:** новый leaf + thin facade/alias + замок. Не rewrite.
- **Rethink:** только если peel ломает контракт HTTP/фактов без ясного owner — DEFER, не rewrite.

## Якоря

- Канон границ — `docs/` продукта + [canon-owners.md](../docs/canon-owners.md) (не этот промпт)
- TODO_SRC · TODO_UI
- Уже закрытое без **новой** evidence не открывать: см. [prism-cycle-summary.md](../docs/prism-cycle-summary.md) · [accepted-debt.md](../docs/accepted-debt.md)
