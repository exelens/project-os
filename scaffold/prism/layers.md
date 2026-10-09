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
Wave K (K > 0) = оставшиеся P2+ из backlog + новые P0/P1, если Wave 0 закрыта.  
Волны нумеруются 0, 1, 2…; не переименовывать после создания.
- в Notes: «re-merge when remaining core audits arrive»
```

Опоздал слой → **re-merge** в тот же `07-merged-backlog.md` (stable ID). Закрытые Wave не переоткрывать без evidence регрессии.

### 08 по волне

```
Запусти 08 с scope = Wave K (или список B-xx…B-yy).
Сверь только эти ID + их gates.
На каждый ID — строка evidence (prism/evidence.md): supports | ACCEPTED.
Без evidence → false-done / open; не green волны.
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
| Зерно / list≠detail / источники в KPI | optional/domain trust contours (`T-*`) |
| God LOC/fan-in · smear · peel (межцикл) | **не слой** — ArchitectureCheck |

Домены продукта: дополни таблицу своими строками (см. [DOMAIN.md](./DOMAIN.md)). Не открывай чужой префикс ID из «удобного» слоя.

**Новый домен только при ничейной зоне** — gate и ложные кандидаты («механизмы», «рефакторинг ядра») в [DOMAIN.md](./DOMAIN.md). Иначе расширь **03**/**04**/existing domain или запусти скоуп-цикл, не плоди слой.

### Префиксы ID (не сталкивать)

| Префикс | Кто | Не путать с |
|---------|-----|-------------|
| `B-*` | ядро через **07** | domain / optional |
| domain (`C`/`A`/`R`/…) | свои слои 09+ | не в `B-*` |
| `S-*` / `X-*` / `I-*` | optional security / surface / infra | score/queue product features |
| `T-*` | trust contours (optional/domain) | tools / tickets, если займёшь другую букву |
| `L-*` | **LatencyCheck** (scratch в корне) | blog / Lighthouse — если домен блога нужен, бери другую букву **или** переименуй latency в `LC-*` |
| `AC-*` | ArchitectureCheck | не `A-*` admin без явной договорённости |
| `PC-*` / стой | pisdetscheck (рекомендуемый префикс в scratch) | crawl/parser domain `P-*`, если заведён |

Перед новым префиксом: `rg` по `prism/` и `docs/prism-cycle-summary.md`. Одна буква — одна роль в репо.

### Горячие швы (частые ложные дубли)

Шаблоны — заполни своими слоями/ID. Одна находка на одной строке UI → **один** слой по теме + «см. N».

**Один артефакт · N поверхностей** (demo / public / owner)  
- Surface-domain — согласованность display, CTA, counters, CSS-классы правды на всех поверхностях.  
- Owner-domain — IA/данные/навигация владельца на «своей» ветке, не отдельный тон ради удобства.  
- Funnel-domain — путь гостя до публичной поверхности; не аудировать product empty другого слоя.  
Находка «на demo иначе, чем в кабинете» → сначала surface-domain, не chrome **05**.

**Map ≠ display**  
- Truth/score-domain — семантика kind / map (что значит «красное»); формула метрик **не** меняется ради ярлыка.  
- Surface-domain — счётчики, CSS, copy шапки на поверхностях.  
Ярлык врёт → сначала map, потом CSS/copy.

**Chrome ≠ product DoD**  
- **05** — nav / a11y shell / loading-empty flash / plan-limit MSG UX.  
- Tools/catalog-domain — матрица slug × DoD; не общий shell.  
- **05** не строит матрицу продукта; domain не аудирует весь chrome.

**Funnel CTA ≠ surface page**  
- Funnel — secondary CTA с entry → demo/теaser, без лжи «идеальный эталон».  
- Surface — сам demo/teaser product.  
- **05** — a11y shell CTA ок; product copy demo → Hand-off funnel/surface.

**Наш public HTML ≠ чужой ingest**  
- **06** — бот видит **наш** HTML / OG / robots.  
- Ingest/crawl-domain — покрытие **чужого** сайта / парсер.  
Не открывай findings одного в артефакте другого.

**Coverage ≠ weights**  
- Ingest-domain — хватает ли данных/страниц.  
- Score/truth-domain — веса / XP / kind при уже полученных данных.

**Display money ≠ payment path**  
- Owner-domain — подписи срока/лимита/«баланса» в UI.  
- **04** — SSOT чисел плана.  
- **02** — wire keys summary.  
- Billing-domain — checkout / webhook / refund.  
- Secrets в клиенте → optional security-surface.  
- Витрина «по заявке» / claims → honesty-domain.

**UX states ≠ marketing claims**  
- **05** — empty/error/loading после гидрации; тон → [docs/voice.md](../docs/voice.md).  
- Honesty-domain — матрица claim→evidence.  
- Guest poll journey целиком → funnel-domain, не только **05**.

**Tab existence ≠ lifecycle**  
- Owner/admin chrome «есть вкладка X» → owner/admin-domain.  
- Lifecycle тикета/feedback → свой domain (если заведён).

**IDOR ≠ control matrix**  
- optional IDOR — object authz / tenant.  
- optional security-surface — SSRF / CSP / rate-limit / secrets.  
- **02** cookie/shape ≠ «user A читает ресурс B».  
- **03** «security smell» ≠ полный IDOR.

**Orphan-поверхности** (нет своего слоя) — чеклист внутри существующего слоя + Hand-off; новый 09+ только по gate [DOMAIN.md](./DOMAIN.md). Заведи таблицу в `prism/README.md` продукта: поверхность | кто смотрит | не путать с.

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

## No-findings и Gaps

Если слой ничего не нашёл — пиши коротко «no findings» с причиной (контур не запущен, нет доступа к нему или находка уже закрыта). Не заполнять разделы шаблона строками ради строки; честный Gap лучше выдуманной находки.

---

## Gaps (вне Prism)

Runtime ops, одноразовые миграции данных, ручной smoke хостинга, бизнес-решения «платим ли X» — фиксируй в `docs/stages.md` / ops runbook, не выдумывай finding в audit без evidence.

Schemathesis / полный mutation / browser e2e как **merge-gate** — политика продукта (`tests/README.md`), не слой Prism; отсутствие команды/канона при зрелом API — finding слоя **01**, не silent green.

**Стой (pisdetscheck)** — межцикловый triage вне нумерации слоёв: [pisdetscheck.md](./pisdetscheck.md). Не Gap и не слой 09+: не пишет в `reviews/`, не мержится в `B-*`, не reopen закрытых ID без новой evidence.

**LatencyCheck** — те же правила для хвостов «экран ждёт секунды»: [LatencyCheck.md](./LatencyCheck.md). `L-*` (или `LC-*` при коллизии) только в корневом scratch, не в `reviews/`.

**ArchitectureCheck** — god / smear / peel-границы: [ArchitectureCheck.md](./ArchitectureCheck.md). `AC-*` в корневом scratch. Не **03** (local smell) и не **04** (назначить SSOT без таблицы LOC/fan-in).

**03 local perf ≠ LatencyCheck** — OOM/N+1-shape в файле → **03**; GET секунды+ / sync-on-GET → LatencyCheck (не `B-*`).  
**03/04 ≠ ArchitectureCheck** — local smell без fan-in → **03**; owner без LOC-таблицы → **04**; таблица god/smear/peel → ArchitectureCheck (не `B-*`).
