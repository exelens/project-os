# Деплой / ops (live runbook)

Заполни, когда появится Public (или staging). До этого достаточно строки «deploy — later» в [stages.md](stages.md).

| Поле | Значение |
|------|----------|
| Продукт | TODO_PROJECT_NAME |
| Public URL | TODO_PUBLIC_URL |
| VPS / host | TODO_VPS_HOST (hostname предпочтительнее голого IP) |
| App user · path | TODO_APP_USER · `/opt/TODO_PROJECT_SLUG` |
| Env на сервере | `/etc/TODO_PROJECT_SLUG/env` (не в git) |
| Lab | localhost · см. корневой README |
| Public stack | [../deploy/README.md](../deploy/README.md) |
| Чеклист VPS | [checklists/public-vps.md](checklists/public-vps.md) |
| CI vs CD | [checklists/ci-cd.md](checklists/ci-cd.md) |

## Lab vs Public

| | **Lab** | **Public** |
|--|---------|------------|
| Где | Mac / localhost | TODO_PUBLIC_URL |
| Meta / state | TODO_LAB_DB (часто SQLite / local) | TODO_PUBLIC_DB (часто Postgres) |
| Auth | можно ослабить | всегда жёстко (AUTH on) |
| Деплой | локальный run | скрипт с Mac / ops (не «каждый push = прод») |
| Цель | «хватает ли продукт» | чужой пользователь проходит happy-path |

## Повторный деплой (после кода)

```bash
# TODO: подставь свой скрипт или ручные шаги
# ./scripts/deploy_public.sh --frontend --smoke
```

DoD: `TODO_HEALTH_URL` → 200 · smoke happy-path · секреты не в логе.

## Секреты

- Шаблон имён: [`../deploy/env.public.example`](../deploy/env.public.example)
- Живые значения — только на сервере / в secret store хостинга
- CI **не** перезаписывает prod `.env` из GitHub Secrets на каждый push (риск затереть SMTP/OAuth/JWT)

## Backup · health

- Health: `scripts/healthcheck.example.sh` → скопируй в `scripts/healthcheck.sh` и поправь URL
- Backup данных: `scripts/backup_data.example.sh` → свой путь данных
- Cron на VPS: отдельный файл (не хранить пароли в crontab)

## Не делать

См. антипаттерны CI/CD в [checklists/ci-cd.md](checklists/ci-cd.md) и [../agent-rules/antipatterns.md](../agent-rules/antipatterns.md).
