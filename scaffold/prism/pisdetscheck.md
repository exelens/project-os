# Pisdetscheck — стой (межцикловый triage)

**Не слой Prism.** Нет номера `0N`, нет префикса ID, нет `reviews/NN-…`, не идёт в **07** merge и не переоткрывает закрытые `B-*` / domain ID без **новой** evidence.

**Когда:** между закрытыми циклами Prism, перед короткой FIX-волной по боли dogfood / Public.  
**Не когда:** вместо полного Prism (01–08); не после только что закрытого цикла «ради третьей сети»; не вместе с generic «senior audit + улучши промпт».

**Артефакт:** только `pisdetscheck.md` в **корне продукта** (scratch; не канон, не DoD, не локи тестов на сам файл). Имя файла в корне можно оставить `pi.md`, если так принято в репо — тогда в чате явно: «пиши в pi.md по контракту pisdetscheck».

В чат: `@prism/pisdetscheck.md` (или путь к этому файлу). После аудита — **отдельный** чат FIX по Disposition; на audit код не менять.

Заполни `TODO_` под продукт. Поиск: `rg 'TODO_' prism/pisdetscheck.md`.

---

## Промпт (копировать в чат)

Ты в репозитории **TODO_PROJECT_NAME**. Режим: READ-ONLY аудит. Код, тесты, docs канона продукта и каноны **НЕ** менять.

Цель: найти реальные проблемы и записать **ТОЛЬКО** в `pisdetscheck.md` в корне продукта (или `pi.md`, если так договорились) — scratch; не канон, не DoD, не локи тестов.

Скоуп (читай код + тесты; codegraph/graphify — ок, если есть):
- TODO_SRC (persist / store, loader/services, api/http, ingest/adapters, domain groups, slice/query, insights, alerts, catalog/operator, external sync)
- TODO_UI composables + критичные pages кабинета / app shell
- tests/ на изоляцию (conftest, auth IDOR, env wipe / process globals)

Вне скоупа (не предлагать «починить», максимум одна строка ACCEPTED если уже в `docs/accepted-debt.md`):
- TODO_OUT_OF_SCOPE (пример: чужой стек / Celery must / соседний продукт / SERP / guest / SMTP monetize)
- mass reformat, full codegen типов, god-UI split «на будущее»
- повтор закрытого Prism `B-*` / domain / optional ID / mechanisms H* без **новой** evidence — см. `docs/prism-cycle-summary.md` · `docs/accepted-debt.md`

Ищи по классам (каждый finding — **один** класс):
1. Логика / honesty (двойной счёт, смешение слоёв источников, ложный Δ, soft-signal ≠ alert threshold)
2. Дубли / SSOT (две правды одной функции, proxy вместо реального API)
3. Ошибки / узкие места (N+1, FD leak, sync в HTTP request, race periods, OOM upload)
4. Изоляция (IDOR, owner_id / tenant, env leak между тестами, process globals)
5. Противоречия код↔канон (только если код врёт доке или наоборот; цитировать оба)

НЕ делать:
- не рефакторить и не «набросать фикс»
- не писать PoC эксплойтов
- не раздувать style/nits без продукта
- не предлагать новую архитектуру без боли dogfood / прод

Формат артефакта в корне:

```markdown
# pisdetscheck — audit YYYY-MM-DD (scratch)

## Summary
- P0: N · P1: N · P2: N · ACCEPTED: N
- 3–5 главных рисков одной строкой каждый

## Findings
### P0-1 · <короткий title>
- Class: logic|dup|bug|perf|isolation|canon
- Where: path:symbol (или path ±lines)
- Evidence: что именно сломано / как воспроизвести (тест или сценарий)
- Impact: кому больно (tenant / KPI / dogfood)
- Disposition: FIX | ACCEPTED | DEFER — одно слово + почему
- Not: что НЕ предлагаешь чинить рядом

(дальше P0…, затем P1, P2; ACCEPTED — отдельной секцией без «надо срочно»)

## Out of scope / already closed
- список тем, которые сознательно пропущены + ссылка на accepted-debt / prism-cycle-summary
```

Правила triage:
- P0 = ломает изоляцию, врёт KPI/алертам, data loss, forgeable secret
- P1 = дубль SSOT / реальный баг без потери данных
- P2 = узкое место / maintainability с evidence
- ACCEPTED = уже residual или сознательный долг
- Максимум 25 findings. Лучше 12 точных, чем 60 «возможно».
- Каждый finding обязан иметь Where + Evidence. Без evidence — не писать.

Хвост: код не меняй. Чужие `reviews/*` не трогай. Не создавай слой Prism из этих находок.
