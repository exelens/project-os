# Public VPS — чеклист (день 0 → live)

Статус: TODO_ (Spike / Lab / Public). Канон ops: [../deployment.md](../deployment.md) · [../../deploy/README.md](../../deploy/README.md).

Перед регрессией Public: локальный lint + test (+ browser при UI) зелёные.

## Lab vs Public

См. таблицу в [deployment.md](../deployment.md). Не путать: Lab-ослабления auth **не** уезжают на Public.

## Чеклист подъёма

| # | Шаг | DoD | Статус |
|---|-----|-----|--------|
| 1 | VPS + DNS + HTTPS | apex открывается · TLS ок | TODO_ |
| 2 | Bootstrap: user · docker · ufw · fail2ban | SSH по ключу под app-user | TODO_ |
| 3 | Env `/etc/TODO_SLUG/env` из `deploy/env.public.example` | нет секретов в git | TODO_ |
| 4 | Compose: db + api (+ web/nginx) | API только `127.0.0.1:PORT` | TODO_ |
| 5 | Host nginx / edge proxy → api | `TRUST_PROXY` согласован с заголовками | TODO_ |
| 6 | Auth on · JWT/secret ≥ 32 | register/login smoke | TODO_ |
| 7 | CORS = Public origin only | нет Lab-origins | TODO_ |
| 8 | Cron: sync / jobs | лог + fail видно ops | TODO_ |
| 9 | Backup данных + healthcheck | cron exit ≠ 0 при down | TODO_ |
| 10 | Smoke с Mac | health 200 · happy-path | TODO_ |

## Env на прод

Скопировать [`../../deploy/env.public.example`](../../deploy/env.public.example) → `/etc/TODO_SLUG/env`.  
Заполнить `TODO_` / `replace-with-…`. **Не** коммитить заполненный файл.

## Повторный деплой

```bash
# TODO: ./scripts/deploy_public.sh --smoke
```

## После live

- [ ] Строка в [stages.md](../stages.md): Public URL + дата
- [ ] [deployment.md](../deployment.md) без `TODO_` по host/path/smoke
- [ ] Backup проверен restore-ом хотя бы раз (или ACCEPTED + критерий пересмотра)
