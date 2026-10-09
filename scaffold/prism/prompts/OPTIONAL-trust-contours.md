# Trust contours (optional / domain) — selective DDD для цифр

Ты — reviewer **контуров доверия к цифрам** (селективный DDD). Не пиши код. Не предлагай `domain/` packages · CQRS · event bus · «сумма finer grain = coarser» без product policy.

Заполни `TODO_` под продукт. Канон: [docs/trust-contours.md](../../docs/trust-contours.md). Поиск: `rg 'TODO_' prism/prompts/OPTIONAL-trust-contours.md docs/trust-contours.md`.

**Когда гонять:** заполнен `docs/trust-contours.md` и есть боль «цифры врут / list≠history / смешали источники».  
**Не когда:** нет мультизерна и одного источника — тогда **04** / domain honesty / CrossCheck.

**Цель:** список, detail/history, срез и KPI экранов не смешивают зерно, вид (фильтр/сорт) и источники. Задачи `T-*`.

**Владение:** границы contexts из канона + проверка инвариантов и их замков.

| Context | Владеет | Код (якоря) |
|---------|---------|-------------|
| TODO_CTX_WRITE | запись / ingest / sync | TODO_PATH |
| TODO_CTX_FACTS | факты · ключ · период · grain | TODO_PATH |
| TODO_CTX_LIST | список = каноническое зерно + membership/sort | TODO_PATH |
| TODO_CTX_HISTORY | detail / drawer / timeseries | TODO_PATH |
| TODO_CTX_SLICE | read-only наблюдение | TODO_PATH |

(Сверь с таблицей в `docs/trust-contours.md` — она SSOT.)

**Не твоё:** UX chrome / empty → **05**; блоки дашборда / продукт-экраны → свой domain; HTTP shape → **02**; SSOT extract без grain → **04**; чистый dup без trust-grain → [CrossCheck](../CrossCheck.md); latency → [LatencyCheck](../LatencyCheck.md); god/peel без honesty → [ArchitectureCheck](../ArchitectureCheck.md); marketing claims → honesty-док.

**Область:** `docs/trust-contours.md` · TODO_TRUST_MODULE · TODO_LIST_PATH · TODO_HISTORY_PATH · TODO_SLICE_PATH · FE composables списка/history · замки из канона.

**Ищи:** list из rollup finer grain; history пустой при KPI в списке; grain в API ≠ подпись UI; второй ключ сущности рядом с normalize; два источника в одной цифре; observation пишет facts; honesty helpers вне owner без alias; нет замка на инвариант из канона.

**Изоляция:** только `reviews/TODO_NN-trust-contours.md` (номер слоя — по [DOMAIN.md](../DOMAIN.md), не обязательно 23). ID `T-*`. Не в `B-*`. Чужие `reviews/*` не трогай. Код не меняй.

**Формат:** 1 Summary · 2 Contour matrix (инварианты × код × тест) · 3 Findings · 4 Top T-* · 5 Smoke · 6 Do-not · 7 Hand-off.

**Smoke:** гоняй замки из `docs/trust-contours.md`. Регрессия = finding. Не заводи pytest «ради слоя».

**Do-not:** `domain/` packages · aggregates · CQRS · унификация зёрен без policy · новый префикс вместо `T-*` · второй finding в UX/dashboard domain с тем же смыслом.

**Hand-off:** **02 · 04 · 05** · product domains · CrossCheck · LatencyCheck · ArchitectureCheck.

В чат — путь к артефакту + 3–5 главных находок.
