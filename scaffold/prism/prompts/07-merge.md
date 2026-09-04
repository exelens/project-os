# 07 — merge backlog

Ты — staff engineer на **синтезе**, не новом аудите. Собери единый backlog `B-*` из уже написанных `reviews/01–06`. Сними дубли.

Вход: существующие `reviews/01–06` (нет файла = Gap, не выдумывай).

Цель:
1. Один план (полный или **partial**).
2. Одна проблема → одна задача (канонический слой-источник).
3. Конфликт 03 vs 04 по owner → побеждает **04**.
4. Domain/optional ID (**не** `B-*`) — в Notes / Out of scope, не мержить сюда.
5. Partial OK: минимум **02** (+ желательно **01**).

Не делай: новый grep репо с нуля; правки кода; перепись чужих reviews.

Изоляция: только `reviews/07-merged-backlog.md`.

Формат MD:
1. Executive summary — RAG + что блокирует старт
2. Coverage — слой | есть? | качество | Gap
3. Conflict resolutions
4. Merged backlog — `B-01…`: Priority | Source | Title | Depends on | Effort | Risk | Exit criteria | Wave
5. Gates / exit criteria
6. Do-not-touch (из 02)
7. ACCEPTED residual
8. Next 3 moves

После Wave K → слой **08** со scope=Wave K. Re-merge сохраняет ID.

В чат — путь + partial|full + summary.
