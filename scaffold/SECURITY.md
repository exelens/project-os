# Security — TODO_PROJECT_NAME

**Owner:** этот файл.  
**Актуализировано:** TODO_DATE  
**Не здесь:** волны Prism · как выкатывать хост — только ссылки на [docs/deployment.md](docs/deployment.md) и [docs/checklists/public-vps.md](docs/checklists/public-vps.md).

Канон: **куда слать находку** · **граница Lab/Public** · **controls с evidence**. Не пентест-отчёт, не SOC2, не bug bounty.

Заполни `TODO_` из кода и тестов. Чего нет — «нет» или строка в [docs/stages.md](docs/stages.md). Не выдумывай стек, лимиты и гарантию «утечек нет». Поиск: `rg 'TODO_' SECURITY.md`.

---

## Репорт

**TODO_SECURITY_CONTACT** · тема `TODO_PROJECT_NAME security`.

| Нужно | Не нужно |
|-------|----------|
| impact (чужой tenant / токен / PII) | живые секреты и чужие данные |
| шаги (URL · метод · без токена в тексте) | массовый скан / DoS |
| Public URL или своя Lab | issue с эксплойтом до «ok to disclose» |

**Вне скоупа репорта:** Lab с auth выключенным **by design** (если так записано в [docs/accepted-debt.md](docs/accepted-debt.md)) · «экран тормозит» → [prism/LatencyCheck.md](prism/LatencyCheck.md) · чужой хост без нашего деплоя.

---

## Граница

Ops-таблица Lab/Public — [docs/deployment.md](docs/deployment.md). Здесь только то, что меняет угрозу.

| | Lab | Public |
|--|-----|--------|
| Цель | TODO_LAB_GOAL (часто один оператор на машине) | TODO_PUBLIC_GOAL (чужой пользователь) |
| Auth | TODO_LAB_AUTH (можно ослабить) | TODO_PUBLIC_AUTH (всегда включён) |
| Изоляция | TODO_LAB_ISOLATION | TODO_PUBLIC_ISOLATION (deny чужому) |
| Секреты / meta | TODO_LAB_SECRETS | TODO_PUBLIC_SECRETS |
| Край сети | TODO_LAB_EDGE | TODO_PUBLIC_EDGE (HTTPS · доверие к proxy только за своим reverse proxy) |

Ослабления Lab **не** долг Public и **не** уезжают на Public.

### Активы

Строку без актива удали. Не добавляй «на будущее».

| Актив | Если сломается |
|-------|----------------|
| TODO_ASSET_ACCOUNT | TODO_IMPACT_ACCOUNT |
| TODO_ASSET_TENANT | TODO_IMPACT_TENANT (чужие данные) |
| TODO_ASSET_SECRETS | TODO_IMPACT_SECRETS (plaintext на диске / в логах) |
| TODO_ASSET_ADMIN | TODO_IMPACT_ADMIN (обход изоляции) |

---

## Controls

Каждая строка — факт из кода. Evidence = путь к модулю или тесту, не пересказ.

| Слой | Что | Evidence |
|------|-----|----------|
| **Auth** | TODO_CONTROL_AUTH | TODO_EVIDENCE_AUTH |
| **Tenant** | TODO_CONTROL_TENANT | TODO_EVIDENCE_TENANT |
| **Rate / abuse** | TODO_CONTROL_RATE | TODO_EVIDENCE_RATE |
| **At-rest** | TODO_CONTROL_AT_REST | TODO_EVIDENCE_AT_REST |
| **HTTP** | TODO_CONTROL_HTTP (ошибки наружу без сырого exception · health без внутренностей) | TODO_EVIDENCE_HTTP |
| **Edge** | TODO_CONTROL_EDGE | TODO_EVIDENCE_EDGE |
| **UI** | TODO_CONTROL_UI | TODO_EVIDENCE_UI |

Слоя нет — напиши «нет» в «Что» и не заполняй Evidence выдумкой.

---

## Public fence

Подъём машины — [docs/checklists/public-vps.md](docs/checklists/public-vps.md). Здесь проверка, что Public не остался Lab.

1. Auth включён · секрет сессии достаточной длины (fail-fast, если так сделано в коде)
2. Rate-limit и доверие к proxy — только если есть в коде; proxy доверяем лишь за своим edge
3. CORS = origin Public, не Lab
4. HTTPS и заголовки edge на vhost
5. В git нет `.env`, выгрузок клиентов, живых токенов
6. Allowlist оператора / админа — только свои адреса

Шаблон имён env: [deploy/env.public.example](deploy/env.public.example).

---

## Locks

| Лок | Что |
|-----|-----|
| TODO_SECURITY_LOCK_TEST | Контроли выше не откатываются молча |

Фича, которая трогает auth / tenant / секреты → этот лок зелёный · строка здесь, если сменился control.

**Не мы:** общий auth с соседним продуктом · гарантия «утечек нет» · публичный bounty, которого нет.
