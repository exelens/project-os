# Чеклист: CI / CD (решения, не чужой YAML)

Цель: зафиксировать развилки **до** копипасты туториала. Болванки: [`../../.github/workflows/ci.example.yml`](../../.github/workflows/ci.example.yml) · [`../../deploy/`](../../deploy/).

## CI (на каждый PR / push)

- [ ] Одна команда lint (или «пока нет» в stages)
- [ ] Быстрый test suite = default CI (включая Hypothesis/property на чистой логике, если есть); медленное — отдельный job / opt-in
- [ ] Frontend (если есть) — отдельный job, не блокирует бэк зря
- [ ] Schemathesis / OpenAPI fuzz — отдельный job или `make test-schema`; не в fast suite без нужды
- [ ] Mutation — не merge-gate по умолчанию; команда + точечный скоуп в `tests/README.md`
- [ ] Browser E2E — отдельный job с timeout; не в каждом «мелочном» пути без нужды; не sole gate из agent sandbox
- [ ] Concurrency: cancel-in-progress на один ref
- [ ] Секреты тестов — фикстуры / ephemeral; **не** prod JWT/DB password в CI vars «по умолчанию»

## CD (выкладка)

- [ ] **Bootstrap ≠ deploy:** первый подъём VPS (user · docker · ufw) — one-shot; повторный деплой — тонкий скрипт
- [ ] Автодеплой на каждый `main` — **осознанный выбор**, не default. Часто: CI зелёный → ops/`deploy_*.sh` с Mac
- [ ] Env на сервере живёт в `/etc/…/env` (или secret store); CI не `cat > .env` с дефолтами
- [ ] Smoke после выкладки: health + один auth/API probe
- [ ] Rollback path: предыдущий образ / rsync snapshot / compose previous tag — одной строкой в deployment.md

## Безопасность в пайплайне (optional)

- [ ] Bandit / pip-audit / npm audit — **отчёт**, не слепой gate без triage
- [ ] Не игнорировать CVE «чтобы зелено» без записи в accepted-debt
- [ ] Registry (GHCR и т.п.) — только если реально тянете образы на VPS; иначе build на сервере / rsync кода достаточно

## Антипаттерны (не копировать слепо из туториалов)

- ❌ Перезапись prod `.env` из GitHub Secrets на каждый push
- ❌ `git pull` на VPS как единственный путь, если репо на сервере нет / путь = rsync
- ❌ `--reload` Uvicorn в Public compose
- ❌ Публиковать Postgres порт наружу «для удобства»
- ❌ Alembic/ORM-миграции как must, если схема продукта — свой DDL / dual-backend
- ❌ pgAdmin в Public compose без отдельного ACL
- ❌ CI = «зелёный = можно менять всё» (см. Prism / workflow-weight)

## DoD

Агент по `@AGENTS.md` + этому файлу знает: что гоняет CI, кто жмёт деплой, где секреты, какой smoke.
