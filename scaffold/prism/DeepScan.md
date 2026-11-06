# DeepScan — сквозная структурная и логическая целостность

**Не слой Prism.** Нет номера `0N`, нет `reviews/NN-…`, не идёт в **07** merge и не reopen закрытых `B-*` / domain ID без **новой** evidence.

Межцикловый **тяжёлый** проход рядом со [стой](./pisdetscheck.md), [CrossCheck](./CrossCheck.md), [LatencyCheck](./LatencyCheck.md), [ArchitectureCheck](./ArchitectureCheck.md).

**Когда:** зелёный CI, но нет доверия к совместной работе модулей · перед крупным релизом / деньгами / auth · после серии точечных FIX, когда «всё зелёное, а продукт врёт».  
**Не когда:** вместо 01–08; не «ради третьей сети» после только что закрытого цикла; не в одном чате с другими межциклами; не для style/nits.

**Артефакт:** `deepscan.md` в **корне продукта** (scratch). Если файл уже есть — `deepscan-YYYYMMDD-HHMM.md`, не затирать. После FIX-волн по Disposition — wipe или архив по решению владельца. Close — строка в [docs/prism-cycle-summary.md](../docs/prism-cycle-summary.md). Residual → [docs/accepted-debt.md](../docs/accepted-debt.md).

**ID:** **`DS-*`** (не `D-*` CrossCheck, не `B-*`).  
**В чат:** `@prism/DeepScan.md` → AUDIT_ONLY → отдельный чат FIX только по явной команде. На audit код не менять.

Заполни `TODO_` под продукт. Поиск: `rg 'TODO_' prism/DeepScan.md`.

Вес: обычно **выше L1** (дорого по контексту); см. [docs/workflow-weight.md](../docs/workflow-weight.md). Не обязательный слой 25+.

---

## Миссия

Найти **реальные, доказуемые** системные дефекты: каждая часть выглядит ок, тесты зелёные, а совместная работа модулей неверна.

Пять классов: (1) буквальные / структурные / **семантические** дубли операций; (2) алгоритмы, FSM, транзакции, идемпотентность, recovery; (3) границы модулей и tenant isolation; (4) рассинхрон API · БД · кэш · очередь · UI; (5) скрытые ошибки (fallback, false success, mock bypass).

**Достоверность > количество.** Ноль находок — норма. Не чинить на audit.

---

## Соседи

| Ритуал | Вопрос | DeepScan |
|--------|--------|----------|
| **01–08** | контракт / UX / verify в цикле | другой календарь; не дублируй без нового evidence |
| **CrossCheck** | дубли / противоречия без deep FSM | узкий SSOT-dup → туда (`D-*`) |
| **ArchitectureCheck** | god / smear / peel LOC | peel-таблица без сквозного инварианта → туда (`AC-*`) |
| **LatencyCheck** | GET секунды+ | чистый latency → туда |
| **Стой** | смешанная dogfood-боль | смесь классов без deep proof → стой (`PC-*`) |
| Trust contours | зерно / list≠detail | honesty цифр → `T-*` |
| optional IDOR / security | object authz / controls | не дублируй без нового доказательства |

Один finding — один дом. DeepScan не обязан порождать волну `B-*`.

---

## Контракт AUDIT_ONLY

Запрещено: менять код / тесты / канон-доки / CI / infra / секреты; commit; push; deploy; миграции; prod DB/cache/queue; внешние prod-сервисы; PII.

Разрешено: читать репо и git; AST / call graph / SQL / схемы; безопасные static checks. Существующие тесты — **только** если доказана изолированная test-среда. Временные скрипты — **вне** рабочего дерева, на фикстурах, без внешних запросов. Иначе `NOT_EXECUTED` + причина.

Перед стартом: HEAD SHA · ветка · `git status` · дата · ограничения доступа. Не правь чужие локальные изменения.

**STOP** при небезопасной среде → только static. Не выдумывай недоступный репо.

---

## Этапы (кратко)

0. **Карта системы** из кода (не из имён папок): entry → authz → validate → service → write → queue/event → read → UI. До **пяти** критичных потоков по риску (деньги · доступ · потеря данных · необратимость · blast). Покрытие: `DEEP` / `SCREENED` / `NOT_REVIEWED`. Частичное ≠ полный аудит.
1. **Дубли** — карта операций `операция → реализации → callers → эффект → SSOT`. Классы: `HARMFUL_DUPLICATION` · `INTENTIONAL_DUPLICATION` · `SIMILAR_ONLY` · `UNVERIFIED`. Не merge ради LOC.
2. **Логика / FSM / race** — реальные входы в ветви; `успех → повтор → partial → retry → cancel → restart`. Race только с двумя последовательностями + точкой конфликта + отсутствующим барьером.
3. **Изоляция** — граф импортов/данных; tenant ownership; обход публичного сервиса. Допустимая интеграция ≠ нарушение.
4. **SSOT** — создание / store / writers / readers / derived; цепочки write→event→projection→cache→API→UI; eventual vs permanent wrong.
5. **БД** — уникальность, FK, tx boundaries, upsert, rolling migrate. `processed` flag ≠ unique key.
6. **Скрытые ошибки** — broad except, false success, stale as fresh, mock in prod path. `KNOWN_ACCEPTED` / `REGRESSION` / `NEW_DEFECT` / `UNVERIFIED`.
7. **Сквозные цепочки** — до 5 потоков; static trace ≠ claimed e2e run.
8. **Доказательства** — `CONFIRMED` только с (a) безопасным тестом, (b) полной трассировкой entry→defect, (c) state/effects sequence, или (d) нарушением контракта API/БД. Иначе `PROBABLE` / `UNVERIFIED`. «Прочитал функцию» ≠ CONFIRMED.
9. **Adversarial self-review** — у каждой P0/P1: `counter-evidence`. Лучше 3 доказанных, чем 30 подозрений.
10. **Приоритет** — P0 доказанный data/access/money; P1 важный поток; P2 ограниченный; P3 не в обязательный план.

---

## Промпт (копировать в чат)

```
Прочитай prism/DeepScan.md. Репозиторий TODO_PROJECT_NAME.
Режим AUDIT_ONLY / NO_FIX. Код, тесты, канон-доки НЕ менять.

1) Зафиксируй SHA / ветку / status.
2) Карта системы из кода; выбери до 5 критичных потоков (обоснование).
3) Deep по ним: семантические дубли, FSM/идемпотентность, изоляция, SSOT, БД, скрытые ошибки.
4) Пиши ТОЛЬКО deepscan.md (или deepscan-YYYYMMDD-HHMM.md) в корне.
5) ID = DS-NN. Не мержи в B-*. Не дублируй закрытый Prism без новой evidence.
6) Явно укажи NOT_REVIEWED. Остановись без FIX / commit / push.
```

---

## Шаблон `deepscan.md`

```markdown
# deepscan — YYYY-MM-DD (scratch)

## A. Паспорт
- SHA · branch · dirty? · methods · NOT_EXECUTED

## B. Карта
- модули / владельцы · DEEP|SCREENED|NOT_REVIEWED · выбранные потоки (почему)

## C. Summary
- CONFIRMED P0/P1/P2 · PROBABLE · UNVERIFIED · вердикт: ACTION_REQUIRED | TARGETED_VERIFICATION_REQUIRED | NO_ACTION

## D. Findings
### DS-01 · title
- Severity · Evidence status · Category
- Invariant (источник)
- Path: entry → … → effect
- Evidence (paths/lines/SHA/cmds)
- Expected vs Actual
- Impact / likelihood / blast / reversibility
- Counter-evidence
- Why tests missed (или UNKNOWN)
- Minimal fix + verify (не делать в этом чате)
- Prism link: new | known | reopen-with-new-evidence | n/a

## E–G. (по нужде) дубли · изоляция · сквозные сценарии
## H. Тест-gaps только под конкретные риски
## I. Waves: P0/P1 → P2 → optional; PROBABLE → verify first; UNVERIFIED не в backlog
## J. Что НЕ менять
## K. Вердикт (один)
```

Хвост: код не меняй. Чужие `reviews/*` не трогай. Не создавай слой Prism из этих находок.
