# Deploy stubs (Project OS)

Болванки под Public VPS. **Не** готовый прод-стек — заполни `TODO_` / переименуй `.example` → рабочие имена.

| Файл | Назначение |
|------|------------|
| [`env.public.example`](env.public.example) | Имена переменных без секретов → на сервер `/etc/TODO_SLUG/env` |
| [`docker-compose.prod.example.yml`](docker-compose.prod.example.yml) | db + api (+ optional web); Postgres не наружу |
| [`../docs/deployment.md`](../docs/deployment.md) | Live runbook после заполнения |
| [`../docs/checklists/public-vps.md`](../docs/checklists/public-vps.md) | Чеклист подъёма |
| [`../docs/checklists/ci-cd.md`](../docs/checklists/ci-cd.md) | CI ≠ CD · антипаттерны |
| [`../.github/workflows/ci.example.yml`](../.github/workflows/ci.example.yml) | Пример CI **без** автодеплоя |
| [`../scripts/healthcheck.example.sh`](../scripts/healthcheck.example.sh) | curl health |
| [`../scripts/backup_data.example.sh`](../scripts/backup_data.example.sh) | tar данных |

## Порядок

1. Скопируй `env.public.example` → сервер, заполни.
2. Адаптируй compose (имя образа, volume path, Dockerfile).
3. Bootstrap VPS вручную или своим скриптом (user · docker · ufw) — **не** смешивай с повторным деплоем.
4. Повторный деплой: rsync/git + `compose up` + smoke — отдельный скрипт продукта.
5. CI: скопируй `ci.example.yml` → `ci.yml`, подставь команды lint/test из Makefile.

## Сознательно нет в kit

Полных `bootstrap_*.sh` / `deploy_*.sh` / SSH host defaults — они привязаны к хостеру и пути продукта. Держи их в продукте; сюда только форма.
