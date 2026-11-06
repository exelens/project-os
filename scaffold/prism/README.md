# Prism

**Prism** — послойный preflight-аудит: сначала смотрим, потом правим, потом проверяем, что правка закрыла находку.

> **Авторская методология (know-how).** Prism — собственная наработка [Aleksej Lazutin](https://github.com/exelens): ритуал слоёв, ID-схема (`B-*` / domain / optional), partial merge, wave verify и правила `reviews/`. Это не форк чужого фреймворка и не «общий industry standard под другим именем». При цитировании или переносе — указывай авторство.

Зелёный CI сам по себе **не** значит «можно безопасно менять».

| Файл | Зачем |
|------|--------|
| **Этот README** | Цикл и карта слоёв |
| [layers.md](./layers.md) | Изоляция, параллель, merge, verify, anti-overlap, горячие швы, префиксы ID |
| [../docs/voice.md](../docs/voice.md) | Тон / словарь UI (если витрина); слои 05 и domain сверяют сюда |
| `prompts/0N-*.md` | Роль слоя — в чат как `@prism/prompts/0N-…` |
| [evidence.md](./evidence.md) | Evidence волны для **08** (без строки — нет green) |
| [pisdetscheck.md](./pisdetscheck.md) | **Стой** — межцикловый triage (`PC-*`; не слой) |
| [CrossCheck.md](./CrossCheck.md) | Дубли / противоречия логики (`D-*`; не слой) |
| [LatencyCheck.md](./LatencyCheck.md) | Медленные критические пути (`L-*`/`LC-*`; не слой) |
| [ArchitectureCheck.md](./ArchitectureCheck.md) | God / smear / peel (`AC-*`; не слой) |
| [DeepScan.md](./DeepScan.md) | Сквозная целостность (`DS-*`; тяжёлый межцикл; не слой) |
| [dogfood.md](./dogfood.md) | Live pass аудиторией → domain ID (не слой) |
| [prompts/OPTIONAL-trust-contours.md](./prompts/OPTIONAL-trust-contours.md) | Контуры доверия к цифрам (`T-*`); канон [../docs/trust-contours.md](../docs/trust-contours.md) |
| [../docs/workflow-weight.md](../docs/workflow-weight.md) | Когда L2/L3 vs post-code / стой |
| [../docs/prism-cycle-summary.md](../docs/prism-cycle-summary.md) | Сводка последнего цикла |
| [../docs/accepted-debt.md](../docs/accepted-debt.md) | ACCEPTED residual |
| `../reviews/` | Scratch цикла; wipe — только владелец |

Канон продукта — `docs/` и код. Промпты Prism — не второй SSOT.

---

## Цикл (ядро)

```
  01–06  аудиты → 07 merge (B-*) → правки волнами → 08 verify волны
  → ACCEPTED в docs/accepted-debt.md; reviews/ оставить
```

Домены продукта и optional (IDOR / security / infra) — свои ID, **не** в `B-*` через 07.

---

## Карта слоёв

| # | Тип | Вопрос | Артефакт |
|---|-----|--------|-----------|
| 01 | audit | Верить ли CI? | `reviews/01-tests-review.md` |
| 02 | audit | Стабильный HTTP/API контракт? | `reviews/02-api-contract-freeze.md` |
| 03 | audit | Грязь / perf / smell? | `reviews/03-static-refactoring-audit.md` |
| 04 | audit | Границы / SSOT? | `reviews/04-module-boundaries-ssot.md` |
| 05 | audit | Hydrated UX врёт? | `reviews/05-ux-consistency.md` |
| 06 | audit | Бот видит верный публичный HTML? | `reviews/06-public-html-render.md` |
| 07 | синтез | Что чинить без дублей? | `reviews/07-merged-backlog.md` |
| 08 | closure | Волна `B-*` закрыта? | `reviews/08-post-verify.md` |
| 09+ | домен | свой канон | `reviews/0N-….md` |
| опц. | audit | IDOR / security / infra | свои префиксы |

Новый домен: [DOMAIN.md](./DOMAIN.md) — **только ничейная зона**; не дублировать 03/04 «слоем механизмов». Шаблон: voice · Acceptance Q · Smoke · optional [dogfood](./dogfood.md).

Ложные дубли — [layers.md](./layers.md) § Горячие швы. Orphan-поверхность — чеклист внутри существующего + Hand-off; таблицу orphan заведи здесь при появлении.

### Межцикл (не слои)

Один ритуал = один чат. Не после только что закрытого цикла «ради третьей сети». Карта ID — [layers.md](./layers.md) § Префиксы · § Gaps.

| Ритуал | Когда | ID |
|--------|-------|-----|
| [pisdetscheck](./pisdetscheck.md) | смешанная боль dogfood | `PC-*` |
| [CrossCheck](./CrossCheck.md) | дубли / противоречия логики | `D-*` |
| [LatencyCheck](./LatencyCheck.md) | GET/await секунды+ | `L-*` / `LC-*` |
| [ArchitectureCheck](./ArchitectureCheck.md) | god / smear / peel | `AC-*` |
| [DeepScan](./DeepScan.md) | сквозная целостность (дорого; до 5 потоков) | `DS-*` |
| [dogfood](./dogfood.md) | live pass аудиторией → domain | domain / `DF-*` |

### Trust contours (optional / domain)

Несколько зёрен / list≠detail / 2+ источника: [../docs/trust-contours.md](../docs/trust-contours.md) + `@prism/prompts/OPTIONAL-trust-contours.md`. ID `T-*`.

---

## Как запускать

1. Пустой `reviews/`.
2. Параллельные аудиты по [layers.md](./layers.md).
3. Partial **07** при наличии **02** (+ желательно **01**).
4. Wave fixes → **08** со scope = Wave K + evidence **только `B-*`** ([evidence.md](./evidence.md)).
5. Domains/optional — свои ID; verify в том же чате (не таблица 08).
6. Close по формуле в `layers.md`; агент не удаляет `reviews/`.
7. Между циклами — один межцикл из таблицы выше → отдельный FIX.
8. Путаница зерна — trust-contours (`T-*`).

Не уверен, нужен ли полный цикл? → [../docs/workflow-weight.md](../docs/workflow-weight.md).
