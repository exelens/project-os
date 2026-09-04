# База знаний: TODO_PROJECT_NAME

**Актуализировано:** TODO_DATE  
**VCS:** TODO_GIT_REMOTE  
**Стек:** TODO_STACK  
**Статус:** Spike — см. [docs/stages.md](docs/stages.md)

> Поиск незаполненного: `TODO_`. После заполнения этот блок-цитату можно удалить.

---

## ОБЗОР

- **Продукт (1–3 предложения):** TODO: 1–3 предложения о продукте
- **Пользовательский путь (коротко):** TODO: короткий путь пользователя
- **Конфиг / env:** TODO: .env / config entrypoint — секреты не в git
- **БД:** TODO: нет | Postgres | … — SSOT-док заведи при появлении БД (`docs/database.md`)
- **Очередь / фон:** нет

---

## НАВИГАЦИЯ

| Задача | Где |
|--------|-----|
| Старт дня 0 | [QUICKSTART.md](QUICKSTART.md) · [docs/checklists/new-repo.md](docs/checklists/new-repo.md) |
| Соглашения | этот файл |
| Тесты | [tests/README.md](tests/README.md) |
| Этапы / долг | [docs/stages.md](docs/stages.md) · [docs/accepted-debt.md](docs/accepted-debt.md) |
| Prism | [prism/README.md](prism/README.md) · [prism/layers.md](prism/layers.md) |
| Canon-owners (SSOT) | [docs/canon-owners.md](docs/canon-owners.md) |
| Деплой / ops | `docs/deployment.md` — создать, когда появится деплой |
| Агент в существующем репо | [docs/checklists/agent-workflow.md](docs/checklists/agent-workflow.md) |

---

## КАНОН-OWNERS (кратко)

Числа, лейблы, лимиты, error strings — **только** через таблицу в [docs/canon-owners.md](docs/canon-owners.md).  
Не дублировать константы «для удобства». FE≡BE — parity-тест, не копипаста без гейта.

---

## СОГЛАШЕНИЯ

- **Время:** TODO: единый time helper / TZ-политика — не deprecated `utcnow` / голый `now()` без политики.
- **Лимиты / роли:** только через owner-функции из canon-owners.
- **Ошибки наружу:** sanitize / allowlist — никогда сырой `str(exception)` клиенту.
- **Логи:** `logging` (или принятый в стеке логгер), не `print` в production-путях.
- **Сессии БД** (если есть): не открывать вторую, если caller уже передал unit-of-work.
- **Тяжёлая работа** (если есть async/web): не блокировать request loop без offload.

Полный список: [agent-rules/conventions.md](agent-rules/conventions.md).

---

## АНТИПАТТЕРНЫ

- ❌ Дублировать SSOT вне owner-модуля
- ❌ Отдавать клиенту traceback / `str(e)`
- ❌ `assert True` / пустые тесты
- ❌ Дублировать общие тестовые фикстуры вне одного места
- ❌ Писать в общую БД/очередь/кэш в тестах без изоляции
- ❌ Менять код на этапе Prism audit / merge / verify
- ❌ Wipe `reviews/` агентом после close цикла

См. [agent-rules/antipatterns.md](agent-rules/antipatterns.md).

---

## РАБОЧИЙ ПРОЦЕСС

```bash
# TODO: команда быстрого теста
# TODO: полный suite

# TODO: lint / policy gates
```

Перед крупным изменением в «зоне риска» — второй проход / явный инвариант (`prism/layers.md`).

### Post-code loop (после каждой задачи)

1. **Тесты на затронутый контур** — если нет теста, агент добавляет
2. **Docs актуализация** — менялся канон/команды/SSOT → обновить docs
3. **Тесты re-run** — убедиться, что docs и код синхронны

Все три шага — один чат, не три разных сессии.

### Vibe-check (по желанию)

После задачи: «Какие вопросы/проблемы/предложения у тебя есть?»
Агент анализирует изменения и предлагает доп. шаги.

---

## PRISM

- Перед крупным релизом / сменой контракта / после «серых» мест
- Не вместо CI: зелёный пайплайн ≠ «можно безопасно менять всё»
- Ритуал: [prism/README.md](prism/README.md)

---

## CHANGELOG (проектный)

Краткие dated-блоки — по желанию здесь или в `CHANGELOG.md`.
