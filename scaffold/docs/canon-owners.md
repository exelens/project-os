# Canon-owners (SSOT)

Одно понятие → один owner в коде (+ опционально FE mirror + parity-тест).

| Concept | Owner (код) | FE / docs mirror | Parity / gate |
|---------|-------------|------------------|---------------|
| TODO_CONCEPT_A (TODO_описание) | TODO_MODULE | — | TODO_TEST |
| TODO_CONCEPT_B (TODO_описание) | TODO_MODULE | — | TODO_TEST |
| TODO_CONCEPT_C (TODO_описание) | TODO_MODULE | — | TODO_TEST |
| UI tone / словарь витрины (если есть UI) | — | [voice.md](voice.md) | TODO_COPY_LOCK_TEST |

Строки — замени на понятия своего продукта. Поиск: `TODO_`.  
Строка voice — заполни или удали, если продукта без пользовательского UI.

## Правила

1. Новый публичный лимит / лейбл / клиентская ошибка → сначала строка здесь, потом код.
2. «Временно захардкодить в UI» = долг → `accepted-debt.md`, не молчаливый второй SSOT.
3. Rename ключей / смена owner → обновить таблицу.
4. Агент: перед правкой числа сначала эта таблица, не invent const в роуте.
5. Правка тона / словаря UI → [voice.md](voice.md); новые *продуктовые* лейблы всё равно заведи здесь.
