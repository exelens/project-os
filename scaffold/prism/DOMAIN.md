# Добавление product-domain слоя

Домен = поверхность продукта со **своим** канон-доком и префиксом ID.

## Gate: сначала ничейная зона

**Не** добавляй слой «потому что хочется отдельный проход» (механизмы, рефакторинг ядра, качество кода, изоляция слоёв пакета). Это почти всегда уже **03** (грязь/DRY) · **04** (SSOT/границы) · optional IDOR · или существующий domain.

Новый доменный слой — **только** если выполнены все условия:

1. **Ничейная зона.** Находки нельзя честно отдать одной строкой «см. слой N» в anti-overlap ядра (`layers.md`) и уже заведённых доменов.
2. **Свой канон.** Есть или появится `docs/{{domain}}.md` (или строка в canon-owners) — не второй vision в промпте.
3. **Узкий scope.** Одна продуктовая поверхность (кабинет, админка, отчёт, маркетинг honesty…), не «весь `src/`».
4. **Свой префикс ID.** Не `B-*`; не пересекается с optional (`S`/`X`/`I`/`T` и т.п., если заняты) и с межциклом (`L`/`LC` latency, `AC` ArchitectureCheck, `PC` стой).

Если сомневаешься — **сначала расширь промпт существующего слоя** одной секцией или запусти скоуп-цикл («только ядро: 03+04»), а не плоди 09+.

### Типичные ложные кандидаты (не заводить слой)

| Хочется слой… | Куда на самом деле |
|---------------|-------------------|
| Механизмы / рефакторинг ядра | **03** + **04** (+ durable карта в `docs/`, если нужна) |
| Дубли фильтров / SSOT хелперов | **04** (owner) · **03** (локальный extract) |
| Врут цифры / honesty домена X | domain honesty **или** расширить уже существующий honesty-слой |
| Изоляция tenant / IDOR | optional security-idor |
| Слабые тесты механизмов | **01** |
| God-файл / толстый facade (local) | **04** · **03** |
| God LOC/fan-in · smear-таблица · peel | **не слой** — [ArchitectureCheck.md](./ArchitectureCheck.md) |
| Межцикловый triage / «стой» / pi.md | **не слой** — [pisdetscheck.md](./pisdetscheck.md) |
| Медленные GET / latency-хвосты | **не слой** — [LatencyCheck.md](./LatencyCheck.md) |
| Путаница зерна / list≠detail / 2+ источника в KPI | optional/domain — [prompts/OPTIONAL-trust-contours.md](./prompts/OPTIONAL-trust-contours.md) + [../docs/trust-contours.md](../docs/trust-contours.md); **не** «слой механизмов» |
| Тон / словарь UI без своей поверхности | [docs/voice.md](../docs/voice.md) + **05** / existing domain; не слой «voice» |
| Generic senior-audit + «улучши промпт» | **не брать** в kit / не плодить слой |

Durable карта механизмов (M*/H*) — **док продукта**, не слой Prism. После цикла findings → статус в доке; промпт Prism не дублирует карту.

Горячие швы (multi-surface, map≠display, chrome≠DoD…) — [layers.md](./layers.md) § Горячие швы; при добавлении домена допиши свою строку туда.

---

## Шаги (после gate)

1. Выбери свободный номер слоя (≥ 09) и **уникальный** префикс ID (одна буква + `-`; см. таблицу префиксов в `layers.md`).
2. Создай `prism/prompts/TODO_NN-{{slug}}.md` по структуре ниже.
3. Добавь строку в `prism/README.md` (карта) и anti-overlap + hot-seam Hand-off в `layers.md`.
4. Укажи SSOT-док: `docs/{{domain}}.md`.
5. Артефакт цикла: `reviews/TODO_NN-{{slug}}.md`.
6. Verify — domain-style в том же чате (не через слой 08).

## Шаблон промпта

```markdown
Ты — reviewer домена TODO_DOMAIN_NAME. Сверяй продукт с каноном docs/{{canon}}.md.
Не хвали без evidence. Не пиши код.

Владение:
- Ты владеешь TODO_SCOPE (IA / поверхности / copy зоны).
- Тон и словарь owner-facing UI → сверяй с docs/voice.md (если файл есть); не invent copy-канон в reviews/.
- Claim «гарантируем X» без evidence → Hand-off honesty-док / accepted-debt, не чинить только тоном.
- Чужие темы → одна строка «см. слой N», без таблицы. Горячие швы — prism/layers.md.

Изоляция:
- Пиши только reviews/TODO_NN-{{slug}}.md
- Код не меняй.
- Чужие reviews/* не трогай.

Структура MD:
1. Verdict
2. Sync — дата / что сверила с прошлым циклом (не reopen без новой evidence)
3. Findings — Priority | ID TODO_PREFIX-NN | Evidence | Action
4. Acceptance — строка канона / DoD ↔ status (pass | gap | ACCEPTED)
5. Smoke — 3–7 ручных или тест-путей по тирам аудитории (guest / free / paid), если применимо
6. Do-not-change-yet — сознательно вне волны (ссылка на stages / accepted-debt)
7. Hand-off — куда отдать (02/04/05/06/optional/другие domain)
8. Top tasks

ID: только TODO_PREFIX-*. Не мержить в B-* через 07.
Verify (в том же чате): для каждого ID → done | ACCEPTED | open | false-done + evidence.
```

## Примеры доменов (идеи, не копипаста)

| Домен | Префикс | Канон-док | Voice |
|-------|---------|-----------|-------|
| Кабинет / account area | `C-*` | `docs/cabinet.md` | nav / empty / тариф display |
| Админка | `A-*` | `docs/admin.md` | ops-язык только здесь |
| Публичные поверхности отчёта | `R-*` | `docs/report-surfaces.md` | triad labels / teaser |
| Маркетинг honesty | `H-*` | `docs/marketing-honesty.md` | claims; тон — voice |
| Гостевая воронка | `G-*` | `docs/guest-funnel.md` | guest depth honesty |
| Tools / catalog DoD | `T-*`* | `docs/tools.md` | CTA без ops-жаргона |
| Контуры доверия к цифрам | `T-*`* | `docs/trust-contours.md` · [OPTIONAL-trust-contours](./prompts/OPTIONAL-trust-contours.md) | подписи зерна |

\* Одна буква `T` на репо: либо tools, либо trust — второе переименуй (`U-*` / оставь trust как optional без конфликта). См. `layers.md` § Префиксы.

Префиксы — договорённость репо; главное — **не смешивать** с `B-*`, optional и межциклом.  
Findings trust — всё равно через выбранный префикс; инварианты внутри `docs/trust-contours.md` нумеруй как угодно (`I1…`).
