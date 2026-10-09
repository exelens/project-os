# Гигиена тестов

Дополни этот файл командами и маркерами своего стека. Цель набора — **не хуже практики зрелого продукта**: быстрый CI + свойства логики + живой API-fuzz + точечные мутации + изоляция.

Ориентир идей (без копипасты продукта): Hypothesis · Schemathesis · mutmut · twins · parity · env wipe.

## Запуск

```bash
# TODO_FAST: быстрый suite (default CI)
# TODO_FULL: полный suite (integration / e2e отдельно)
# TODO_FE: фронт unit/component (если есть UI) — в гейте наравне с бэком, не «потом»
# TODO_E2E_API: product API journey (без живых внешних OAuth, если можно)
# TODO_BROWSER: browser e2e (Playwright/Cypress) — host/CI; не agent sandbox как sole gate
# TODO_COV: branch coverage → html report
# TODO_SCHEMA: Schemathesis / OpenAPI live (см. ниже; обычно НЕ в TODO_FAST)
# TODO_MUTATE: mutation testing точечно (см. ниже; не весь src/)
```

| Команда | Когда | В default CI? |
|---------|-------|----------------|
| TODO_FAST | каждый PR / post-code | да |
| TODO_FE | фича в UI | да, если UI есть |
| TODO_SCHEMA | перед freeze API / после крупных ручек | нет (отдельный job/make) |
| TODO_MUTATE | механизмы с тихой ложью цифр | нет (по боли / Lab) |
| TODO_BROWSER | витрина / auth / кабинет click-through | отдельный job; claim только после host/CI |

---

## Достаточность

- Тесты проверяют **контракты поведения**, не частную реализацию.
- Запрещены `assert True`, пустые тесты, «тест ради зелёной галочки».
- Маркеры отделяют медленное/хрупкое: e2e · integration · load · network · schema · mutate.
- Быстрый suite = default CI; медленное — явно.
- Coverage = **карта дыр** (branch), не самоцель 100%. После разумного порога (TODO_COV_FLOOR, часто ~80% business) — усиливать assert’ы / Hypothesis / mutmut, не «вызвали функцию».
- Внешние API — **моки** в CI; live-smoke — вручную / отдельный opt-in. Секреты и токены не в фикстурах.

---

## Изоляция

- Общие фикстуры клиента / БД — **одно** место, без локальных дублей.
- Shared test DB + rollback **или** ephemeral schema/DB на тест — выбери один канон и зафиксируй здесь.
- Сброс process-global state (rate limit, caches, app singleton, queue) — autouse или явные маркеры.
- **Env wipe:** autouse снимает локальные `.env` knobs, которые ломают assert (OAuth, CORS, SMTP, feature flags). Иначе green только на «чистой» машине.
- Data/root override = helper (setenv + reset ready-flags), не голый `setenv` в каждом файле.
- Фоновые писатели / SWR / worker threads — дождаться drain или падать, если очередь жива при смене data-root.
- Не писать в prod DB / live data dir; guard по имени БД / URL / path.
- Ошибки наружу — проверять `detail` / статус / allowlist MSG, не сырой traceback.

---

## Hypothesis — свойства логики (property-based)

**Зачем:** ловить дыры в **чистых** функциях (формулы, нормализация ключей, полосы TOP, фильтры зерна, sanitize ошибок), которые example-тесты не перечисляют.

| | |
|--|--|
| Инструмент (Python) | [Hypothesis](https://hypothesis.readthedocs.io/) (`@given`, strategies) |
| Аналоги | `fast-check` (TS/JS), `proptest` / `StreamCheck` (другие стеки) |
| Где жить | обычные тесты в TODO_FAST / CI (не отдельный тяжёлый job) |
| Что брать | чистые helpers / KPI / path keys / invariants «A ≤ B» / parse+roundtrip |
| Что не брать | полный HTTP+БД+очередь в одном `@given` (медленно и flaky) |
| Артефакты | примеры Hypothesis **не коммитить** (`.hypothesis/` в `.gitignore`) |

```bash
# TODO_HYPOTHESIS: файл(ы) property-тестов входят в TODO_FAST
# пример Python: pytest tests/test_hypothesis_properties.py
```

**DoD:** для каждой критичной чистой оси (CTR/доля/ключ/sanitize/…) есть ≥1 property или честный Gap в stages.  
Prism **01** смотрит: нет Hypothesis на горячей логике при зелёном CI → false-coverage risk.

---

## Schemathesis — живой API по OpenAPI

**Зачем:** генерировать запросы по OpenAPI и ловить **5xx / падения** на странных входах. Это не замена characterization freeze (**02**) и не Hypothesis на чистых функциях.

| | |
|--|--|
| Инструмент | [Schemathesis](https://schemathesis.readthedocs.io/) (или аналог OpenAPI fuzzer) |
| Источник схемы | предпочтительно **живое** ASGI/app (не устаревший disk `openapi.json`), если стек позволяет |
| Default CI | **нет** — отдельная команда TODO_SCHEMA; плагин не должен ломать teardown обычного pytest |
| Что включать | coverage phase + небольшой fuzz на ручку (max-examples скромный) |
| Что выключать | stateful (пока больно); side-effect ручки (sync/connect/pay/live fetch) — denylist в конфиге |
| Env | временный data-root; снять live токены / SMTP / prod DB URL на время прогона |
| Checks | минимум `not_a_server_error`; строгий schema-conformance — только когда тела ошибок описаны честно |

```bash
# TODO_SCHEMA: e.g. make test-schema / schemathesis run …
# конфиг: TODO_SCHEMATHESIS_TOML (workers, max-examples, operations denylist)
# короткий проход: MAX=1 или max-examples=1 для smoke
```

Wiring-тест (опционально): «команда + конфиг + plugin disabled in fast suite» — чтобы schema-gate не исчез молча.

**DoD:** публичный HTTP API → TODO_SCHEMA существует или Gap в stages с датой.  
Prism **01** → Hand-off **02**, если нет freeze/characterization; schema-fuzz gap — finding или ACCEPTED с причиной.

---

## Мутационные тесты (отдельно от Schema / Hypothesis)

Мутации = ломают **код** и проверяют, что тесты **падают**. Не путать со Schemathesis (ломает/фуззит **вход API**).

Если стек поддерживает (`mutmut` / `mutant` / `stryker` …):

```bash
# TODO_MUTATE
# TODO_MUTATE_SHOW  # survivors
```

| Делать | Не делать |
|--------|-----------|
| Точечно: KPI, Δ, пороги, rollup, authz helpers | Весь `src/` / UI / HTTP-клиенты внешних API |
| Kill-wave: файл honesty-тестов на выживших операторах | Гнаться за % kill как vanity metric |
| Equivalent mutants → ACCEPTED / ignore | Считать equivalent багом продукта |

Цель Lab: survivors по таблице критичных модулей → усилить assert или Hypothesis, не «ещё coverage».

---

## Twins / слои похожести

| Класс | Смысл | Действие |
|-------|--------|----------|
| **A · True twin** | Один SUT, один слой, почти тот же assert | Один owner; twin удалить или 1-path smoke |
| **B · Layer** | Похожий исход, разные слои (unit ≠ HTTP ≠ UI) | **Не удалять**; зафиксировать роли |
| **C · False green** | Зелёный из-за кривого контура | Сначала контур, потом assert |

1. Owner + leftover в twin-файле.  
2. Один кластер cleanup = один шаг; красный гейт → стоп.  
3. Дыру после сноса twin закрывать **thin-тестом**.

---

## FE ↔ BE parity

Если один смысл на двух сторонах: SSOT → mirror → **parity-тест** как gate (pytest + vitest/jest — оба в CI, если UI есть).

UI: устойчивые якоря (`role`, `data-*`) — «блок есть»; точный текст — только где формулировка = требование (voice / copy-lock).

---

## Policy gates (рекомендуется)

CI валит job при: сырой `str(e)` клиенту · запрещённые datetime/event-loop паттерны · session anti-pattern · (опц.) baseline count lock, если продукт так ведёт канон.

Mutation / Schemathesis / полный browser — **не** обязаны быть merge-gate день 0; обязаны быть **командой и каноном** здесь, иначе набор деградирует.

---

## Карта набора (заполни)

| Слой | Команда / файлы | В CI? |
|------|-----------------|-------|
| Unit / pure + Hypothesis | TODO_ | да |
| HTTP contract / freeze | TODO_ | да (примерные) |
| Schemathesis | TODO_SCHEMA | отдельный |
| FE unit | TODO_FE | да если UI |
| Mutation | TODO_MUTATE | по боли |
| Browser e2e | TODO_BROWSER | отдельный job |

Когда добавляешь фичу: зелёный затронутый тест (или новый thin) + при смене канона чисел — parity / Hypothesis.
