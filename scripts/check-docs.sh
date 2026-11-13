#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
for path in README.md AGENTS.md AGENT.md CLAUDE.md docs/PRD.md docs/architecture/golden-thread.md docs/adr/README.md docs/adr/0007-golden-thread-control-plane.md docs/adr/0008-skill-lifecycle.md; do
  test -s "$path" || { echo "Missing or empty: $path" >&2; exit 1; }
done
grep -q 'AGENTS.md' CLAUDE.md
grep -q 'Golden Thread' docs/PRD.md
grep -q 'Golden Thread' AGENTS.md
echo "Documentation checks passed (structure and references only; no runtime enforcement)."
