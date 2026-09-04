# Prism — слои (SSOT ритуала)

Промпты `prompts/0N-*.md` = роль и чеклист. Этот файл = правила. Канон продукта — `docs/` в **продуктовом** репо.

Ядро: audits → **partial/full 07** → правки по волнам → **08 по закрытой волне**.  
Product domains: свои номера и префиксы ID. Optional: IDOR / security / infra — не в `B-*`.

### Зоны риска (второй проход)

Правка в зоне = явный инвариант / отдельный проход, независимо от размера патча.

| Зона (пример) | Почему |
|---------------|--------|
| auth / sessions / admin flag | security blast radius |
| billing / limits / entitlements | деньги и квоты |
| migrations | схема prod |
| queue / workers / jobs | lost work / double run |
| публичный HTML / meta · OG · crawl inject | боты и шаринг |

Обычный поток без второго прохода: docs, copy, тесты без смены семантики, chrome UI.

Детерминированные антипаттерны (время, event-loop, `str(e)` в ответах) — **policy scripts** в продукте, не промпт.

---

## `reviews/` = scratch цикла

Агент после close **не удаляет** `reviews/`.  
**Wipe только вручную** владельцем. Durable = код + тесты + `docs/` + оставшийся `reviews/`. Residual → `docs/accepted-debt.md`.

---

## Параллель и partial merge

| Можно параллельно | Нельзя / осторожно |
|-------------------|-------------------|
| `01 ∥ 03` | `03` Quick wins до freeze из **02** |
| `05 ∥ 06` после Hand-off из **02** (или Gap) | `06` green без evidence |
| domain layers между собой | Мешать разные ID-префиксы в один ID |
| Wave N fix ∥ audit опоздавшего слоя | Менять do-not-touch из 02 без freeze |

### Partial 07 (early Wave 0)

Минимум: **02** обязателен; **01** желателен. Остальные — **Gap**, не выдумывать findings.

```
Partial merge OK если:
- есть reviews/02 (и желательно 01)
- в Coverage: слой | есть? | Gap
- Wave 0 = только P0/P1 из имеющихся входов + Depends on.  
Wave K (K > 0) = P2+ из Wave 0 + новые P0/P1, если Wave 0 закрыта.  
Волны нумеруются 0, 1, 2…; не переименовывать после создания.
- в Notes: «re-merge when remaining core audits arrive»
```

Опоздал слой → **re-merge** в тот же `07-merged-backlog.md` (stable ID). Закрытые Wave не переоткрывать без evidence регрессии.

### 08 по волне

```
Запусти 08 с scope = Wave K (или список B-xx…B-yy).
Сверь только эти ID + их gates.
Остальной backlog — open; не ставь RAG green на весь цикл.
```

### Полный close цикла

```
green цикла только когда:
1. все волны B-* → done/ACCEPTED (08 по каждой) И
2. каждый ЗАПУЩЕННЫЙ domain ID закрыт domain-style verify
3. если запускали optional audits — их ID закрыты
4. ACCEPTED → docs/accepted-debt.md; reviews/ оставить
```

Незапущенный domain/optional = Gap в Coverage, **не** silent green.

---

## Контракт изоляции

1. Один слой → один файл в `reviews/`.
2. Чужие `reviews/*` не трогай.
3. Не создавай legacy stubs / `STATUS.md`.
4. Код не меняй на audit / синтез / verify.
5. ID-префиксы не смешивать (`B-*` ≠ domain ≠ optional).
6. Пересечение — одна строка «см. слой N».
7. После close агент **не** удаляет `reviews/`.
8. Domains и optional **не** мержатся в `B-*` через 07.

---

## Anti-overlap (ядро)

| Тема | Канон слой |
|------|------------|
| Flaky / false coverage | **01** |
| HTTP/API JSON / freeze | **02** |
| Dead / DRY / complexity / perf | **03** |
| SSOT / boundaries | **04** |
| Hydrated UX | **05** |
| Raw public HTML / bots / OG | **06** |
| Merge `B-*` | **07** |
| Verify `B-*` | **08** |
| Object authz / IDOR | optional security-idor |
| Controls beyond IDOR | optional security-surface |
| Infra scale (cache/DB/workers) | optional infra |

Домены продукта: дополни таблицу своими строками (см. [DOMAIN.md](./DOMAIN.md)). Не открывай чужой префикс ID из «удобного» слоя.

---

## Lifecycle

| Фаза | Действие |
|------|----------|
| Старт | Пустой `reviews/`. Residual — `accepted-debt.md` + код. |
| Audits | Параллель по таблице. |
| Early 07 | Partial merge → Wave 0. |
| Re-merge | Когда пришли Gap-слои. |
| 08 | По каждой закрытой волне. |
| Domains | Свои треки; опциональны относительно ядра B-*. |
| Close | Формула выше; wipe — владелец. |

---

## Domain / optional verify

Нет отдельного «08 для доменов». Verify = короткий check в том же чате:

```
Для каждого открытого domain/optional ID:
  done | ACCEPTED | open | false-done + evidence
ACCEPTED → docs/accepted-debt.md
Не мержи в B-*.
```

---

## Gaps (вне Prism)

Runtime ops, одноразовые миграции данных, ручной smoke хостинга, бизнес-решения «платим ли X» — фиксируй в `docs/stages.md` / ops runbook, не выдумывай finding в audit без evidence.
