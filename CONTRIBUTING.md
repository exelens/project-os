# Contributing

Issues and PRs welcome for the **kit** (scaffold, apply script, Prism prompts, docs), not for product apps that consume it.

## Before a PR

1. Keep the kit **domain-agnostic** — no product code, stack lock-in, or secrets.
2. Placeholders for product fill stay as `TODO_` markers.
3. Smoke-test apply:

```bash
rm -rf /tmp/project-os-smoke
./scripts/apply_to_repo.sh /tmp/project-os-smoke
test -f /tmp/project-os-smoke/AGENTS.md
./scripts/apply_to_repo.sh "$PWD" && echo "FAIL: should refuse kit-self" || true
```

4. Breaking changes (Prism ID scheme, wipe rules, backlog format) → bump major in CHANGELOG.
