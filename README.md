# Project OS

Переносимый стиль работы: канон, доки, тесты, Prism. **Не** starter-код приложения.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

**Для любого продукта и любого агента.** Один и тот же kit кладётся в репо на любом стеке; агент читает файлы (`AGENTS.md`, `docs/`, `prism/`), а не «плагин IDE». Работает с **Cursor**, **Crush**, **Claude Code** (и другими CLI/IDE-агентами) — без привязки к одному инструменту. Опциональный `.cursor/rules/` — удобство для Cursor, не зависимость.

**Готово к работе:** папка [`scaffold/`](./scaffold/) + скрипт apply.  
**Старт:** **[QUICKSTART.md](./QUICKSTART.md)**.

В корне kit **нет** продуктового `AGENTS.md` — он лежит в [`scaffold/AGENTS.md`](./scaffold/AGENTS.md) и копируется в продукт скриптом. Этот `README.md` — про kit, не про продукт.

```bash
git clone https://github.com/exelens/project-os.git
cd project-os
chmod +x scripts/apply_to_repo.sh
./scripts/apply_to_repo.sh /path/to/your-product-repo
cd /path/to/your-product-repo && rg 'TODO_' -n
```

---

## Структура kit

| Путь | Назначение |
|------|------------|
| [QUICKSTART.md](./QUICKSTART.md) | Apply → TODO_ → smoke |
| [scaffold/](./scaffold/) | Готовые файлы продукта (AGENTS, shims, docs, `voice.md`, prism, tests, `.gitignore` / `.env.example`, cursor rule) |
| [scripts/apply_to_repo.sh](./scripts/apply_to_repo.sh) | Разложить scaffold в репо (не затирает README продукта) |
| [scripts/lint_agents_md.sh](./scripts/lint_agents_md.sh) | Lint `AGENTS.md` (секции, pointers, TODO_) |
| [CHANGELOG.md](./CHANGELOG.md) | Версии kit |
| [LIFT.md](./LIFT.md) | Как публиковать / версионировать kit |
| [SOURCE.md](./SOURCE.md) | Откуда извлечено |
| [APPLY.md](./APPLY.md) | Ручная карта (если без скрипта) |
| [CONTRIBUTING.md](./CONTRIBUTING.md) | Правила для PR в kit |

---

## Принципы

1. Канон в коде + коротких docs, не в чате.  
2. Один SSOT на понятие (`docs/canon-owners.md`); тон UI — `docs/voice.md` (если есть витрина).  
3. Тесты = контракт поведения; нет `assert True`.  
4. Вес workflow L0–L3 (`docs/workflow-weight.md`) — не каждый запрос = Prism.  
5. Prism: audit → merge → волны → verify с evidence; новый domain-слой — только ничейная зона (`prism/DOMAIN.md`).  
6. Между циклами — **стой** [`prism/pisdetscheck.md`](./scaffold/prism/pisdetscheck.md) (не слой; scratch в корне продукта).  
7. ACCEPTED — в `docs/accepted-debt.md`.  
8. Агент не wipe’ает `reviews/`.  
9. Один `AGENTS.md`; `CLAUDE.md` / Copilot instructions — thin pointers.

---

## Prism — авторское know-how

**Prism** (слои 01–08, merge/`B-*`, waves, verify, isolation) — **собственная наработка** автора kit ([Aleksej Lazutin / @exelens](https://github.com/exelens)), не заимствование чужого audit-фреймворка. Подробнее и формулировка для цитирования: [`scaffold/prism/README.md`](./scaffold/prism/README.md).

Код и тексты kit распространяются под [MIT](./LICENSE); авторство методологии Prism при использовании/адаптации сохраняй.

---

## Чего нет (намеренно)

Обязательный стек, код исходного продукта, секреты, готовый CI под чужой Makefile.

## License

[MIT](./LICENSE)
