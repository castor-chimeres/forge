# ADR-0007 — Golden Thread as the governance control plane

**Status:** Proposed (human review pending)

## Context
Delegating to autonomous agents creates gaps in readiness, context, permissions, evidence, review and accountability. Merely citing Golden Thread in documentation is insufficient.

## Decision proposed
Golden Thread defines organization-wide and technical contracts and enforcement points, regardless of selected execution mode. The forge implements and measures these controls; game profiles adapt them to specific engines. No implementation mode, skill or agent may silently override them.

## Implications
- TaskSpec, readiness, context gateway, controlled execution, evidence, independent verification and HITL become first-class concerns.
- Break-glass is human-controlled and audited.
- ADR-governed evolution with measured PDCA; agent topology remains replaceable.
- M0 documents intent only; executable enforcement begins in M1.

## Alternatives
Hardcode the controls into one Claude workflow (rejected: vendor lock-in); rely on agent prompts (rejected: not enforceable); adopt mandatory SDD-only workflow (rejected: too restrictive).
