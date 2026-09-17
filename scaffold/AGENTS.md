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
| Заполнить TODO_ (localize) | [docs/checklists/localize.md](docs/checklists/localize.md) |
| Соглашения | этот файл |
| Тесты | [tests/README.md](tests/README.md) |
| Этапы / долг | [docs/stages.md](docs/stages.md) · [docs/accepted-debt.md](docs/accepted-debt.md) |
| Вес workflow (L0–L3) | [docs/workflow-weight.md](docs/workflow-weight.md) |
| Prism | [prism/README.md](prism/README.md) · [prism/layers.md](prism/layers.md) |
| Evidence волны (08) | [prism/evidence.md](prism/evidence.md) |
| Стой (межцикл triage) | [prism/pisdetscheck.md](prism/pisdetscheck.md) — не слой; scratch в корне |
| Canon-owners (SSOT) | [docs/canon-owners.md](docs/canon-owners.md) |
| Голос UI (tone / словарь) | [docs/voice.md](docs/voice.md) — optional без витрины |
| Деплой / ops | `docs/deployment.md` — создать, когда появится деплой |
| Агент в существующем репо | [docs/checklists/agent-workflow.md](docs/checklists/agent-workflow.md) |
| Другие агенты | `CLAUDE.md` · `.github/copilot-instructions.md` → этот файл |

---

## КАНОН-OWNERS (кратко)

Числа, лейблы, лимиты, error strings — **только** через таблицу в [docs/canon-owners.md](docs/canon-owners.md).  
Не дублировать константы «для удобства». FE≡BE — parity-тест, не копипаста без гейта.  
Тон и словарь пользовательского UI — [docs/voice.md](docs/voice.md) (не второй vision в чате).

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
- ❌ Claim / copy без `docs/voice.md` (если UI есть) и без evidence
- ❌ Полный Prism без нужды — см. `docs/workflow-weight.md`
- ❌ Green волны 08 без evidence (`prism/evidence.md`)

См. [agent-rules/antipatterns.md](agent-rules/antipatterns.md).

---

## РАБОЧИЙ ПРОЦЕСС

```bash
# TODO: команда быстрого теста
# TODO: полный suite

# TODO: lint / policy gates
```

Перед крупным изменением в «зоне риска» — второй проход / явный инвариант (`prism/layers.md`).

Сколько церемонии: [docs/workflow-weight.md](docs/workflow-weight.md) (L0 post-code → L3 full Prism). Не открывай `reviews/` на L0.

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

- Когда: уровень L2/L3 по [docs/workflow-weight.md](docs/workflow-weight.md) (не на каждый commit)
- Не вместо CI: зелёный пайплайн ≠ «можно безопасно менять всё»
- Ритуал: [prism/README.md](prism/README.md)
- Закрытие волны: [prism/evidence.md](prism/evidence.md) — без evidence нет green в 08

---

## CHANGELOG (проектный)

Краткие dated-блоки — по желанию здесь или в `CHANGELOG.md`.
