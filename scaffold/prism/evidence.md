# Evidence волны (для 08)

Машиночитаемый гейт не обязателен: достаточно таблицы в `reviews/08-post-verify.md`.  
Без evidence ID нельзя ставить wave RAG **green**.

Слой: [prompts/08-verify.md](./prompts/08-verify.md) · правила: [layers.md](./layers.md) · [README.md](./README.md).

---

## Правила

1. Каждый **`B-*`** в scope волны → одна строка evidence. **Только `B-*`.**
2. `Kind`: `cmd` (команда + exit) | `artifact` (путь к файлу/логу) | `diff` (commit/PR ref) | `manual` (только с явным why).
3. `Verdict`: `supports` | `partial` | `rejects` | `ACCEPTED`.
4. Wave green ↔ все in-scope ID имеют `supports` **или** `ACCEPTED` (`ACCEPTED` → строка в `docs/accepted-debt.md`).
5. `partial` / `rejects` / пустой Evidence → `false-done` или `open`, не green.
6. Не принимай «тесты зелёные» / «CI green» без привязки к ID (какой тест / артефакт закрывает какой `B-*`).
7. Spot-check do-not-touch из **02** / **07** — отдельной строкой или Notes, не «кажется ок».

### Где evidence (не мешать)

| Префикс | Где evidence | Кто verify |
|---------|--------------|------------|
| `B-*` | таблица в `reviews/08-…` (или `08-waveN-…`) | слой **08** |
| domain (`C`/`A`/`R`/…) | `reviews/0N-….md` или короткий domain-verify в чате | domain-style; **не** таблица 08 |
| optional `S-*`/`X-*`/`I-*`/`T-*` | `reviews/optional-….md` | domain-style |
| межцикл `PC-*`/`D-*`/`L-*`/`LC-*`/`AC-*`/`DS-*`/`DF-*` | корневой scratch | свой FIX-чат; **не** таблица 08 |

Не подмешивай domain / optional / межцикл ID в таблицу волны **08** как будто это `B-*`.

---

## Шаблон строк (в 08)

| ID | Criterion (из 07) | Evidence | Kind | Verdict | Notes |
|----|-------------------|----------|------|---------|-------|
| B-01 | … | `TODO_TEST_CMD` → exit 0 | cmd | supports | |
| B-02 | … | path в коде / лог | artifact | supports | |
| B-03 | … | `docs/accepted-debt.md#…` | manual | ACCEPTED | residual ok |

Имя файла verify: `reviews/08-post-verify.md` или `reviews/08-waveK-….md` при нескольких волнах.

---

## Минимальный чеклист reviewer

- [ ] Scope волны = список **`B-*`** из **07** / чата
- [ ] У каждого ID есть Evidence ≠ «кажется ок»
- [ ] Gates из **07** прогнаны или ACCEPTED
- [ ] Do-not-touch spot-check
- [ ] Вердикт волны честный
- [ ] Domain / optional / межцикл, если запускались — закрыты **отдельно**, не silent green через 08

---

## Антипаттерны

- «CI green» без строк на ID
- Перенос domain/optional в `B-*` через **07**/**08**
- Межцикл (`D-*`/`DS-*`/…) в таблице волны 08
- Wipe `reviews/` агентом после «green»
