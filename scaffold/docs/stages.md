# Этапы и состояние

**Текущий этап:** Spike  
**Обновлено:** TODO_DATE

## Матрица этапов

| Этап | Что значит | Gate выхода |
|------|------------|-------------|
| Spike / Prototype | Можно ломать | README + минимальный тест пути |
| Closed Beta | Реальные юзеры, ручная выдача | Checklist перед выкладкой · бэкап · smoke |
| Open Beta | Публичный вход, долг явный | Monitoring · rate limit · honesty copy |
| Prod monetization | Деньги | Отдельный gate-док |

## Открытый долг (не ACCEPTED)

| ID | Что | Приоритет | Блокер этапа? |
|----|-----|-----------|---------------|
| | | P0/P1/P2 | да/нет |

## Режим агента (`AGENTS.md`)

| Этап | Типичный режим |
|------|----------------|
| Spike / Prototype | `BUILD` |
| Lab finish / приёмка ядра | `FINISH, NOT EXPAND` |
| Prism audit / UAT без GO на правки | `AUDIT ONLY` |

Open debt ≠ очередь на реализацию. Expand — только по GO владельца.

## Ссылки

- Вес workflow (L0–L3): [workflow-weight.md](workflow-weight.md)
- Границы доменов: [light-ddd.md](light-ddd.md)
- Осознанный residual: [accepted-debt.md](accepted-debt.md)
- Последний Prism: [prism-cycle-summary.md](prism-cycle-summary.md)
