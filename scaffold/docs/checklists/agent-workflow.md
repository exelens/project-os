# Чеклист: агент в уже существующем репо

Перед крупной задачей:

1. Прочитай `AGENTS.md` + `docs/canon-owners.md` (если есть).
2. Выбери вес: [../workflow-weight.md](../workflow-weight.md) (L0–L3) — не открывай Prism на L0.
3. Трогаешь copy / CTA / empty на витрине или first screen → сверь `docs/voice.md` (если есть).
4. Найди owner понятия, которое трогаешь — не invent const.
5. Найди существующие тесты/parity рядом — расширь их, не плоди twin класса A.
6. Зона риска? — явный инвариант или второй проход (`prism/layers.md`).
7. Ошибки наружу — только sanitize/allowlist.
8. После кода: тесты на затронутый контур + обновление короткого doc, если менялся канон.
9. Не commit / не wipe `reviews/` без просьбы владельца.

Если просят «аудит всего» — предложи уровень из workflow-weight (часто L2, не сразу L3), не один гигантский чат.  
Закрытие волны Prism — только с evidence ([../../prism/evidence.md](../../prism/evidence.md)).

Между циклами Prism / перед короткой FIX-волной — стой [prism/pisdetscheck.md](../../prism/pisdetscheck.md) (scratch в корне; не слой, не merge в `B-*`). Не путать с generic «senior audit + улучши промпт».
