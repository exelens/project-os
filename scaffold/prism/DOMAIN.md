# Добавление product-domain слоя

Домен = поверхность продукта со **своим** канон-доком и префиксом ID.

## Шаги

1. Выбери свободный номер слоя (≥ 09) и **уникальный** префикс ID (одна буква + `-`, не `B`/`S`/`X`/`I` если они заняты optional).
2. Создай `prism/prompts/TODO_NN-{{slug}}.md` по структуре ниже.
3. Добавь строку в `prism/README.md` (карта) и anti-overlap в `layers.md`.
4. Укажи SSOT-док: `docs/{{domain}}.md`.
5. Артефакт цикла: `reviews/TODO_NN-{{slug}}.md`.
6. Verify — domain-style в том же чате (не через слой 08).

## Шаблон промпта

```markdown
Ты — reviewer домена TODO_DOMAIN_NAME. Сверяй продукт с каноном docs/{{canon}}.md.
Не хвали без evidence. Не пиши код.

Владение:
- Ты владеешь TODO_SCOPE.
- Чужие темы → одна строка «см. слой N», без таблицы.

Изоляция:
- Пиши только reviews/TODO_NN-{{slug}}.md
- Код не меняй.

Структура MD:
1. Verdict
2. Findings — Priority | ID TODO_PREFIX-NN | Evidence | Action
3. Hand-off — куда отдать (02/04/05/…)
4. Top tasks

ID: только TODO_PREFIX-*. Не мержить в B-* через 07.
```

## Примеры доменов (идеи, не копипаста)

| Домен | Префикс | Канон-док |
|-------|---------|-----------|
| Кабинет / account area | `C-*` | `docs/cabinet.md` |
| Админка | `A-*` | `docs/admin.md` |
| Публичные поверхности отчёта | `R-*` | `docs/report-surfaces.md` |
| Маркетинг honesty | `H-*` | `docs/marketing-honesty.md` |
| Гостевая воронка | `G-*` | `docs/guest-funnel.md` |

Префиксы — договорённость репо; главное — **не смешивать** с `B-*` и optional.
