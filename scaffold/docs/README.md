# Документация (live runbooks)

Интерфейс и контракты — в **коде** и **`tests/`**. Здесь короткие live runbook'и.

| Ссылка | Назначение |
|--------|------------|
| [../AGENTS.md](../AGENTS.md) · [../tests/README.md](../tests/README.md) | Старт / тесты |
| [stages.md](stages.md) | Этап продукта · открытый долг |
| [workflow-weight.md](workflow-weight.md) | L0–L3: сколько церемонии (post-code → full Prism) |
| [canon-owners.md](canon-owners.md) | SSOT: кто owner какого понятия |
| [voice.md](voice.md) | Тон и словарь UI (витрина / кабинет); optional без UI |
| [accepted-debt.md](accepted-debt.md) | Осознанный долг (ACCEPTED), не баги ядра |
| [prism-cycle-summary.md](prism-cycle-summary.md) | Сводка последнего закрытого Prism-цикла |
| [../prism/README.md](../prism/README.md) | Ритуал Prism |
| [../prism/evidence.md](../prism/evidence.md) | Evidence волны для 08 |
| [../prism/pisdetscheck.md](../prism/pisdetscheck.md) | Стой: межцикловый triage (не слой) |
| [../prism/LatencyCheck.md](../prism/LatencyCheck.md) | LatencyCheck: секунды на критическом пути (не слой) |
| [deployment.md](deployment.md) | Public / ops runbook (заполнить при деплое) |
| [checklists/localize.md](checklists/localize.md) | После apply: заполнить TODO_ |
| [checklists/agent-workflow.md](checklists/agent-workflow.md) | Агент в существующем репо |
| [checklists/ci-cd.md](checklists/ci-cd.md) | CI ≠ CD · антипаттерны туториалов |
| [checklists/public-vps.md](checklists/public-vps.md) | Подъём VPS → live |
| [../deploy/README.md](../deploy/README.md) | Болванки compose / env / health / backup |

Добавляй строки по мере появления: database · monitoring · security · product domains.

## Правила

1. Док = **короткий live runbook**, не второй учебник по фреймворку.
2. Закрытая волна → одна строка + ссылка на код/тест; не раздувать историю в каждом файле.
3. Числа/лейблы — только через [canon-owners.md](canon-owners.md).
4. Тон / словарь пользовательского UI — [voice.md](voice.md) (не дублировать PRODUCT/vision).
5. Идеи / планы агента: `docs/superpowers/plans/` или `docs/agent/` — не смешивать с live runbook.
