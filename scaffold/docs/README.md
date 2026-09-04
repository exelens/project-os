# Документация (live runbooks)

Интерфейс и контракты — в **коде** и **`tests/`**. Здесь короткие live runbook'и.

| Ссылка | Назначение |
|--------|------------|
| [../AGENTS.md](../AGENTS.md) · [../tests/README.md](../tests/README.md) | Старт / тесты |
| [stages.md](stages.md) | Этап продукта · открытый долг |
| [canon-owners.md](canon-owners.md) | SSOT: кто owner какого понятия |
| [accepted-debt.md](accepted-debt.md) | Осознанный долг (ACCEPTED), не баги ядра |
| [prism-cycle-summary.md](prism-cycle-summary.md) | Сводка последнего закрытого Prism-цикла |
| [../prism/README.md](../prism/README.md) | Ритуал Prism |
| [checklists/agent-workflow.md](checklists/agent-workflow.md) | Агент в существующем репо |

Добавляй строки по мере появления: database · deployment · monitoring · security · product domains.

## Правила

1. Док = **короткий live runbook**, не второй учебник по фреймворку.
2. Закрытая волна → одна строка + ссылка на код/тест; не раздувать историю в каждом файле.
3. Числа/лейблы — только через [canon-owners.md](canon-owners.md).
4. Идеи / планы агента: `docs/superpowers/plans/` или `docs/agent/` — не смешивать с live runbook.
