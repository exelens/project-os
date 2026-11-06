# Dogfood — live pass аудиторией

**Не слой Prism.** Живой прогон Lab / staging глазами целевой аудитории (гость · free · paid · viewer…).  
Находки → `reviews/dogfood-TODO_SURFACE.md` (scratch) и Hand-off в **domain** ID (не в `B-*`). Authz → optional security-idor (`S-*`). Chrome/a11y shell → **05**. Public HTML/meta → **06**.

**В чат:** `@prism/dogfood.md`  
**Канон без браузера:** соответствующий domain-промпт (`prism/prompts/TODO_NN-….md`) — Acceptance Q-таблица.  
**Вес:** L1 рядом со [стой](./pisdetscheck.md); не вместо полного Prism; не вместе с DeepScan / CrossCheck в одном чате.

Заполни `TODO_`. Поиск: `rg 'TODO_' prism/dogfood.md`.

---

## Lab

| | |
|--|--|
| UI | TODO_LAB_UI_URL |
| API | TODO_LAB_API_URL |
| Seed / reset | TODO_SEED_CMD |

| Роль | Как войти |
|------|-----------|
| TODO_ROLE_PRIMARY (кто dogfood) | TODO_LOGIN_HINT (пароль **не** в `reviews/`) |
| TODO_ROLE_PEER (сверка, опц.) | TODO_LOGIN_HINT_PEER |

---

## Промпт (копировать)

```
Ты dogfood-аудитор TODO_PRODUCT. ТОЛЬКО поверхность TODO_SURFACE на Lab.
READ-ONLY к репо (кроме reviews/dogfood-TODO_SURFACE.md).
Войди как TODO_ROLE_PRIMARY → TODO_ENTRY_PATH.
Без подсказок ответь Acceptance Q из prism/prompts/TODO_NN-….md (или таблицу ниже).
Class: logic | ux | copy | a11y | empty-state | acl.
Не трогай TODO_OUT_OF_SCOPE (/admin · Public · соседний продукт).
Не пиши код. Не invent prod.
```

---

## Что проверить (шаблон)

1. **Список / хаб:** TODO_LIST_EXPECT (роль видна · KPI / статусы честные).  
2. **Acceptance Q1–Qn** глазами роли — без тура.  
3. **ACL:** write/delete недоступны зрителю (или ошибка без traceback / без портов в UI).  
4. **Картина сущности:** TODO_ENTITY_EXPECT (кому · что сделали · даты · результат).  
5. **Copy:** [docs/voice.md](../docs/voice.md) — нет shell/env/портов на экране.  
6. **Сверка (опц.):** peer-роль видит свой контур; primary — нет чужих write-эффектов.

---

## Артефакт

`reviews/dogfood-TODO_SURFACE.md`:

```markdown
# dogfood-TODO_SURFACE — YYYY-MM-DD

## Lab
- seed: ok|fail · UI TODO_

## Acceptance Q
| # | Ответ глазами | Pass? |
|---|---------------|-------|

## Findings
### TODO_PREFIX-… или DF-…
- Class: logic|ux|copy|a11y|empty-state|acl
- Where: URL / control
- Evidence: …
- Hand-off: domain TODO_PREFIX-* | optional S-* | 05 | 06 | —

## Not in scope
- …
```

Hand-off в domain-слой предпочтителен (стабильный префикс). Не мержить в `B-*`.
