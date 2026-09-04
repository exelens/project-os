# Prism

**Prism** — послойный preflight-аудит: сначала смотрим, потом правим, потом проверяем, что правка закрыла находку.

Зелёный CI сам по себе **не** значит «можно безопасно менять».

| Файл | Зачем |
|------|--------|
| **Этот README** | Цикл и карта слоёв |
| [layers.md](./layers.md) | Изоляция, параллель, merge, verify, anti-overlap |
| `prompts/0N-*.md` | Роль слоя — в чат как `@prism/prompts/0N-…` |
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

Новый домен: [DOMAIN.md](./DOMAIN.md).

---

## Как запускать

1. Пустой `reviews/`.
2. Параллельные аудиты по [layers.md](./layers.md).
3. Partial **07** при наличии **02** (+ желательно **01**).
4. Wave fixes → **08** со scope = Wave K.
5. Domains/optional — свои ID; verify в том же чате.
6. Close по формуле в `layers.md`; агент не удаляет `reviews/`.
