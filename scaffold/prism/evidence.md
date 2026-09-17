# Evidence волны (для 08)

Машиночитаемый гейт не обязателен: достаточно таблицы в `reviews/08-post-verify.md`.  
Без evidence ID нельзя ставить wave RAG **green**.

## Правила

1. Каждый `B-*` (или domain ID) в scope волны → одна строка evidence.
2. `Kind`: `cmd` (команда + exit) | `artifact` (путь к файлу/логу) | `diff` (commit/PR ref) | `manual` (только с явным why).
3. `Verdict`: `supports` | `partial` | `rejects` | `ACCEPTED`.
4. Wave green ↔ все in-scope ID имеют `supports` **или** `ACCEPTED` (ACCEPTED → строка в `docs/accepted-debt.md`).
5. `partial` / `rejects` / пустой Evidence → `false-done` или `open`, не green.
6. Не принимай «тесты зелёные» без привязки к ID (какой тест закрывает какой `B-*`).

## Шаблон строк (в 08)

| ID | Criterion (из 07) | Evidence | Kind | Verdict | Notes |
|----|-------------------|----------|------|---------|-------|
| B-01 | … | `pytest tests/… -q` → exit 0 | cmd | supports | |
| B-02 | … | `reviews/…` или path в коде | artifact | supports | |
| B-03 | … | accepted-debt#… | manual | ACCEPTED | residual ok |

## Минимальный чеклист reviewer

- [ ] Scope волны = список ID из 07 / чата
- [ ] У каждого ID есть Evidence ≠ «кажется ок»
- [ ] Gates раздела 5 из 07 прогнаны или ACCEPTED
- [ ] Do-not-touch spot-check
- [ ] Вердикт волны честный

Слой: [prompts/08-verify.md](./prompts/08-verify.md) · ритуал: [README.md](./README.md).
