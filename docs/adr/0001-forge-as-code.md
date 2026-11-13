# ADR-0001 — Forge as code

**Status:** Accepted (M0)

## Decision
The forge's configuration, policies, agent contracts, project profiles, bootstrap procedures and tests are versioned in Git. Reproduction must not depend on undocumented manual steps.

## Consequences
Automated verification and reviewable changes are required; runtime components will be introduced incrementally.
