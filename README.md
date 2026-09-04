# Project OS

Переносимый стиль работы: канон, доки, тесты, Prism. **Не** starter-код приложения.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

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
| [scaffold/](./scaffold/) | Готовые файлы продукта (AGENTS, docs, prism, tests, cursor rule) |
| [scripts/apply_to_repo.sh](./scripts/apply_to_repo.sh) | Разложить scaffold в репо (не затирает README продукта) |
| [CHANGELOG.md](./CHANGELOG.md) | Версии kit |
| [LIFT.md](./LIFT.md) | Как публиковать / версионировать kit |
| [SOURCE.md](./SOURCE.md) | Откуда извлечено |
| [APPLY.md](./APPLY.md) | Ручная карта (если без скрипта) |
| [CONTRIBUTING.md](./CONTRIBUTING.md) | Правила для PR в kit |

---

## Принципы

1. Канон в коде + коротких docs, не в чате.  
2. Один SSOT на понятие (`docs/canon-owners.md`).  
3. Тесты = контракт поведения; нет `assert True`.  
4. Prism: audit → merge → волны → verify с evidence.  
5. ACCEPTED — в `docs/accepted-debt.md`.  
6. Агент не wipe’ает `reviews/`.

---

## Чего нет (намеренно)

Обязательный стек, код исходного продукта, секреты, готовый CI под чужой Makefile.

## License

[MIT](./LICENSE)
