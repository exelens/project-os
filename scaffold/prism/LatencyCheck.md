# LatencyCheck — медленные критические пути

**Не слой Prism.** Нет номера `0N`, нет `reviews/NN-…`, не идёт в **07** merge и не переоткрывает закрытые `B-*` / domain ID без **новой** evidence.

Межцикловый ритуал рядом со [стой](./pisdetscheck.md), [CrossCheck](./CrossCheck.md) и [ArchitectureCheck](./ArchitectureCheck.md).

**Когда:** dogfood «тупит» · замер показал хвост · перед публичной полировкой отзывчивости · после волны кэша/прогрева (регресс).  
**Не когда:** вместо полного Prism (01–08); не «ради третьей сети»; не в одном чате со стой / CrossCheck / ArchitectureCheck / generic senior-audit.

**Артефакт:** `latencycheck.md` (или `lc.md`) в **корне продукта** — scratch. После FIX — wipe. Close — одна строка в [docs/prism-cycle-summary.md](../docs/prism-cycle-summary.md). Residual → [docs/accepted-debt.md](../docs/accepted-debt.md).

**В чат:** `@prism/LatencyCheck.md` → audit READ-ONLY → отдельный чат FIX по Disposition. На audit код не менять.

Заполни `TODO_` под продукт. Поиск: `rg 'TODO_' prism/LatencyCheck.md`.

---

## Что это

Охота на **операции в критическом пути пользователя**, из‑за которых экран или загрузка данных висят **секунды**.

Вопрос один: **какой GET / await заставляет ждать — и почему он считает заново, вместо попадания в кэш или фон.**

Пример боли: один GET главного экрана — десятки секунд, соседние экраны уже быстрые.

---

## Что делает

| Делает | Не делает |
|--------|-----------|
| Ищет синхронную работу **внутри HTTP GET** | Не открывает закрытые `B-*` без новой evidence |
| Ищет fan-out (N одинаковых тяжёлых вызовов) | Не предлагает новую инфру «на будущее» |
| Проверяет, бьёт ли default path мимо готового read-model / кэша | Не чинит honesty и дубли (→ стой / CrossCheck) |
| Смотрит вторичные куски, которые считаются на каждый hit | Не гоняет micro-nits без боли пользователя |
| Смотрит FE waterfall и отсутствие мягкого ожидания, когда бэкенд ещё готовит данные | Не пишет код на audit |
| Смотрит дыру прогрева после записи | Не заменяет Prism 01–08 |

---

## Соседи

| Ритуал | Вопрос | LatencyCheck |
|--------|--------|--------------|
| **01–08** | контракт / UX / verify | другой календарь; другие артефакты |
| **03** | грязь · smell · N+1 «вообще» | только хвост критического пути + миллисекунды |
| Домен продукта | правда цифр и экрана | «почему GET долгий», не «верный ли результат» |
| **CrossCheck** | дубли · противоречия логики | не SSOT |
| **ArchitectureCheck** | god / smear / peel | не LOC-таблица |
| Trust contours | зерно / honesty цифр | «почему GET долгий», не «верный ли результат» |
| **Стой** | смешанная боль (есть class `perf`) | **только** классы ниже |

Пересечения нормальны. Разное — **когда** гонять и **куда** писать (`L-*` в scratch, не `B-*` и не `P0-*`).

---

## Промпт (копировать в чат)

```
Ты в репозитории TODO_PROJECT_NAME. Режим: READ-ONLY аудит. Код, тесты, docs канона продукта и каноны НЕ менять.

Цель: найти пути, где экран или загрузка данных тормозит (секунды на GET или на критическом FE await).
Пиши ТОЛЬКО в latencycheck.md (или lc.md) в корне продукта.

Вопрос на каждый finding: «Пользователь ждёт — какой код крутится на этом await и почему не кэш/фон?»

Скоуп:
- TODO_HTTP (routes / handlers экранов)
- TODO_READ_PATH (materialize · cache · read-model · loader)
- TODO_UI (pages · data-fetch · цепочки await / refresh)
- TODO_PERF_PROBE (скрипт замера или заголовок/поле кэша; если нет — evidence = тест или замер в коде)
- tests, которые фиксируют cache hit / запрет тяжёлой работы внутри GET (если есть)

Вне скоупа (макс. 1 строка ACCEPTED):
- TODO_OUT_OF_SCOPE
- новая infra без evidence текущего хвоста
- style / доли секунды без боли dogfood
- ops-only smoke хоста
- дубли без latency → CrossCheck / стой (pisdetscheck)
- trust-grain / list≠detail → trust contours (T-*)
- god/peel без latency → ArchitectureCheck

Классы (ровно один на finding):
1. sync-get — пересчёт / полная сборка / разбор файла внутри GET
2. fan-out — N тяжёлых одинаковых запросов
3. rm-miss — default path считает live, хотя готовый read-model / кэш есть
4. uncached — тот же ключ снова разбирает сырьё на каждый hit
5. fe-waterfall — цепочка await; нет мягкого ожидания, пока бэкенд готовит данные
6. warm-gap — после записи первый GET холодный, без фоновой подготовки

Evidence обязателен: path:symbol · миллисекунды · TODO_CACHE_SIGNAL (hit|cold|live или эквивалент) · или тест, который зелёный при антипаттерне.
Максимум 15 findings (лучше ≤8). Не рефакторить. Не трогать reviews/*.
После FIX: wipe latencycheck.md; close — строка в docs/prism-cycle-summary.md; residual — docs/accepted-debt.md.
```

---

## Шаблон артефакта (`latencycheck.md` в корне)

```markdown
# latencycheck — audit YYYY-MM-DD (scratch)

## Summary
- sync-get: N · fan-out: N · rm-miss: N · uncached: N · fe-waterfall: N · warm-gap: N
- Топ хвостов: экран · эндпоинт · порядок величины

## Findings
### L-1 · <title>
- Class: sync-get|fan-out|rm-miss|uncached|fe-waterfall|warm-gap
- Where: path:symbol
- Evidence: …
- Impact: экран / таймаут / dogfood
- Disposition: FIX | ACCEPTED | DEFER — почему
- Not: …

## Out of scope / already closed
- …
```

## Triage

| Class | FIX если… |
|-------|-----------|
| **sync-get** | GET ждёт пересчёт или сборку порядка секунды и дольше |
| **fan-out** | стоимость ~линейна по N без потолка или кэша |
| **rm-miss** | основной путь идёт live при готовом read-model / кэше |
| **uncached** | повтор того же ключа снова разбирает сырьё |
| **fe-waterfall** | скелет дольше, чем самый долгий один ответ API |
| **warm-gap** | после записи пользователь молча ждёт десятки секунд вместо hit или явного «готовится» |

## Якоря

- Канон чтения данных — `docs/` продукта (не этот промпт)
- TODO_PERF_PROBE · TODO_CACHE_SIGNAL
- Уже закрытое без **новой** evidence не открывать: см. [prism-cycle-summary.md](../docs/prism-cycle-summary.md) · [accepted-debt.md](../docs/accepted-debt.md)
