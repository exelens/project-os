# 08 — post-verify

Ты — release reviewer. Слой **closure**, не новый audit и не новый merge. Проверь, что волны из `reviews/07-merged-backlog.md` реально закрыты.

Если нет `reviews/07-merged-backlog.md` — **STOP**, не выдумывай green.

Цель:
1. По scope (Wave K или список `B-*`): `done` | `ACCEPTED` | `open` | `false-done`
2. Gates из раздела 5 `07-merged-backlog.md`
3. Do-not-touch не уехали
4. Вердикт RAG **волны** (не обязательно всего цикла)

Не делай: полный перезапуск 01–06; правки кода; перепись приоритетов 07.

Domain/optional ID — не твой scope (верни в их слои). При full close: ACCEPTED → `docs/accepted-debt.md`; `reviews/` не удалять.

Изоляция: только `reviews/08-post-verify.md`.

Формат MD:
1. Executive summary
2. Closure matrix — ID | Claimed | Verified | Evidence
3. Gates
4. Do-not-touch spot-check
5. ACCEPTED residual
6. Out of wave / reopen
7. Verdict & next 3 moves

Правила: лучше честный false-done, чем «всё done» без evidence.

В чат — путь + RAG волны + false-done count.
