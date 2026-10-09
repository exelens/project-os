# Контуры доверия к цифрам (selective DDD)

**Owner:** этот файл · код honesty-helpers: TODO_TRUST_MODULE  
**Когда нужен:** в продукте есть **несколько зёрен** (день/месяц/окно), **list ≠ detail/history**, или **2+ источника** могут попасть в одну KPI.  
**Не обязателен** для CRUD / CLI без аналитических экранов — тогда в [stages.md](stages.md) «trust contours — later» и не плоди пустой SSOT.

**Зачем:** селективный DDD вокруг цифр — чтобы список, drawer, срез и KPI не смешивали зерно, вид (фильтр/сорт) и источники. Правка смысла контура → сюда, потом код. Не второй vision в чате и не CQRS «на всякий».

**Не здесь:** UX chrome / empty states → Prism **05** · marketing claims → honesty-док · god/peel без grain → [ArchitectureCheck](../prism/ArchitectureCheck.md) · чистый SSOT-dup → [CrossCheck](../prism/CrossCheck.md) · latency → [LatencyCheck](../prism/LatencyCheck.md).

Prism-слой (optional/domain): [../prism/prompts/OPTIONAL-trust-contours.md](../prism/prompts/OPTIONAL-trust-contours.md) · ID `T-*`.

Поиск незаполненного: `rg 'TODO_' docs/trust-contours.md`.

---

## Когда заводить

Заводи файл и слой, если верно **хотя бы два**:

1. Одно и то же «число» считается из разных зёрен (месяц / daily / rolling).
2. Список сущности и history/drawer могут расходиться при «честном» KPI строки.
3. Два внешних или внутренних источника могут схлопнуться в одну цифру без явной политики.
4. Сорт/фильтр списка меняет смысл агрегата, а не только вид.

Иначе расширь existing domain honesty / **04**, не плоди контуры.

---

## Contexts (заполни)

| Context | Владеет | Код (якоря) |
|---------|---------|-------------|
| TODO_CTX_WRITE | запись / ingest / sync | TODO_PATH |
| TODO_CTX_FACTS | факты · ключ сущности · период · grain / device | TODO_PATH |
| TODO_CTX_LIST | список = каноническое зерно + membership/sort | TODO_PATH |
| TODO_CTX_HISTORY | detail / drawer / timeseries | TODO_PATH |
| TODO_CTX_SLICE | read-only наблюдение (оси × период) | TODO_PATH |

Удали лишние строки или добавь — но каждый context = одна зона владения, не «весь `src/`».

---

## Инварианты (пример → свои)

Замени на продукт. Нумерация `I1…` — **внутри этого файла**; findings Prism — префикс `T-*` (не путать с optional infra `I-*`, если занят).

| # | Инвариант | Замок (тест) |
|---|-----------|--------------|
| I1 | TODO: list не строится rollup’ом из finer grain без явной политики | TODO_TEST |
| I2 | TODO: history пустой ⇒ KPI строки в списке тоже «нет точки» (или явный note) | TODO_TEST |
| I3 | TODO: grain в API/UI совпадает с подписью; нет «день как месяц» без note | TODO_TEST |
| I4 | TODO: один ключ сущности (normalize) — нет второго рядом | TODO_TEST |
| I5 | TODO: источники A и B не в одной цифре без policy | TODO_TEST |
| I6 | TODO: slice/observation не пишет facts и не тянет drawer как SSOT списка | TODO_TEST |
| I7 | TODO: honesty helpers живут в TODO_TRUST_MODULE (+ thin aliases ok) | TODO_TEST |

Нет замка на инвариант → finding `T-*` или Gap, не silent green.

---

## Do-not

- `domain/` packages · aggregates · CQRS · event bus «для контуров»
- Унификация «сумма finer = coarser» без product policy
- Второй SSOT honesty вне TODO_TRUST_MODULE без alias + замок
- Дублировать finding в UX/dashboard domain с тем же смыслом grain

---

## Связь с каноном

- Числа / лейблы KPI — [canon-owners.md](canon-owners.md)
- Тон подписей зерна в UI — [voice.md](voice.md) (если есть)
- Residual — [accepted-debt.md](accepted-debt.md)
