# Чеклист: агент в уже существующем репо

Перед крупной задачей:

1. Прочитай `AGENTS.md` (режим GO / finish?) + `docs/canon-owners.md` + `docs/light-ddd.md` (если есть).
2. Режим `FINISH, NOT EXPAND` / `AUDIT ONLY` → не expand из туду без явного GO.
3. Выбери вес: [../workflow-weight.md](../workflow-weight.md) (L0–L3) — не открывай Prism на L0.
4. Трогаешь copy / CTA / empty на витрине или first screen → сверь `docs/voice.md` (если есть).
5. Найди owner понятия, которое трогаешь — не invent const. Чужое понятие — не тащи в свою модель (`light-ddd`).
6. Найди существующие тесты/parity рядом — расширь их, не плоди twin класса A.
7. Зона риска? — явный инвариант или второй проход (`prism/layers.md`).
8. Ошибки наружу — только sanitize/allowlist.
9. После кода: тесты на затронутый контур + обновление короткого doc, если менялся канон.
10. Не commit / не wipe `reviews/` без просьбы владельца.
11. Не дописывай в `AGENTS.md` летопись фикса — summary / CHANGELOG.

Если просят «аудит всего» — предложи уровень из workflow-weight (часто L2, не сразу L3), не один гигантский чат.  
Закрытие волны Prism — только с evidence ([../../prism/evidence.md](../../prism/evidence.md)).

Между циклами Prism — **один** межцикл на чат (не merge в `B-*`): стой · CrossCheck (`D-*`) · Latency · Architecture · dogfood · тяжёлый [DeepScan](../../prism/DeepScan.md) (`DS-*`). Не generic «senior audit + улучши промпт».
Путаница зерна / list≠detail / источников в KPI — [docs/trust-contours.md](../trust-contours.md) + [OPTIONAL-trust-contours](../../prism/prompts/OPTIONAL-trust-contours.md) (`T-*`).
