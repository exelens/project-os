# Changelog

## 1.3.0 — 2026-09-17

- Compatibility shims: `scaffold/CLAUDE.md`, `scaffold/.github/copilot-instructions.md` → `AGENTS.md`
- `scaffold/docs/workflow-weight.md` — L0–L3 ceremony (post-code → full Prism) + score table
- `scaffold/docs/checklists/localize.md` — post-apply fill `TODO_` from repo evidence
- `scaffold/prism/evidence.md` + tighter **08** — wave green only with supports/ACCEPTED rows
- `scripts/lint_agents_md.sh` + kit CI `.github/workflows/lint-agents-md.yml`
- Wired into `scaffold/AGENTS.md` · docs hub · stages · checklists · antipatterns · prism README/layers · Cursor rule · kit QUICKSTART/README/APPLY · `SOURCE.md`

## 1.2.0 — 2026-09-17

- `scaffold/prism/pisdetscheck.md` — **стой**: межцикловый READ-ONLY triage (не слой Prism; не в 07); wired in prism README · layers · DOMAIN · AGENTS · docs hub · agent-workflow · antipatterns

## 1.1.0 — 2026-09-16

- `scaffold/docs/voice.md` — domain-agnostic tone-of-voice template (`TODO_`); wired into docs hub, canon-owners, AGENTS, conventions/antipatterns, Prism 05, checklists, Cursor rule
- Prism `DOMAIN.md`: gate «новый домен только при ничейной зоне» + таблица ложных кандидатов (механизмы → 03/04); wired in `layers.md`, `prism/README`, antipatterns
- Scaffold: `.gitignore`, `.env.example`; apply/QUICKSTART/APPLY clarity; Prism prompt isolation tighten-ups

## 1.0.0 — 2026-09-04

First public release of **Project OS**.

- Agent-agnostic: any product repo; Cursor, Crush, Claude Code, or other agents that read repo docs
- `scaffold/` — AGENTS, docs map, canon-owners, tests hygiene, Prism 01–08 (+ optional), optional Cursor rule
- `scripts/apply_to_repo.sh` — safe apply into a product repo (keeps product `README.md`)
- Prism documented as original author know-how (@exelens)
- Kit docs: README, QUICKSTART, APPLY, LIFT, SOURCE, CONTRIBUTING
- License: MIT
