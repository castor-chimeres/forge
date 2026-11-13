# Golden Thread — forge control plane

**Status:** M0 reference architecture. Controls below are target behavior; documented controls are **not yet enforced** at runtime.

## Purpose
Golden Thread is the golden path for AI-agent delegation: organizational and technical governance that lets humans delegate while keeping control. It covers multiple execution modes, including Agentic Scrum, not just Spec-Driven Development.

## Separation of responsibilities

| Plane | Owns | Does not own |
|---|---|---|
| Golden Thread control plane | Policies, task contracts, readiness, permissions, context budget, evidence, HITL, exception handling, improvement loop | Specific agent topology or game engine |
| Forge execution plane | Orchestration, task runners, tools, sandboxes, tester, reviewer, telemetry | Unilateral changes to governance |
| Project profile | Godot conventions, builds/tests, assets, project-local restrictions | Override of global controls |

## Nominal lifecycle
1. **Intake:** human intent -> TaskSpec with scope, owner, risk and outcomes.
2. **Readiness:** DoR and Spec-Readiness checks; unresolved blockers stop execution.
3. **Plan:** choose mode, agent roles, capabilities and context; authorize boundaries.
4. **Execute:** isolated workspace; bounded tools, context and spending.
5. **Verify:** independent tests and review; EvidenceManifest links claims to results.
6. **Gate:** HITL for risk-bearing actions or promotion; approval is explicit.
7. **Learn:** collect observations and improve practice using PDCA.

## Contract candidates (not implemented yet)
- `TaskSpec`: id, objective, repository/ref, allowed paths, acceptance criteria, risks, approver and permissions.
- `ContextManifest`: sources, versions, relevant excerpts, context budget and compact/trim decisions.
- `ExecutionPlan`: selected mode, steps, tool boundaries, agents, checkpoints and failure paths.
- `EvidenceManifest`: commit/ref, checks, outcomes, review, artifacts, exceptions and human decision.
- `SkillManifest`: origin, version, license, fingerprint, declared permissions, tests, status and rollback path.

Schemas, serialization and compatibility rules require an ADR and executable tests.

## Invariants and enforcement intent
| Invariant | Future enforcement | M0 status |
|---|---|---|
| Task ready before run | Preflight validator | Documented |
| Explicit scope | Policy gate + workspace isolation | Documented |
| Least privilege | Tool broker / sandbox | Documented |
| Bounded context | Context gateway with trim/prune/compact logs | Documented |
| No silent policy bypass | Policy engine | Documented |
| Claims supported by evidence | Evidence validator | Documented |
| Independent review proportionate to risk | Reviewer/test harness | Documented |
| HITL + audited break-glass | Approval service and immutable event log | Documented |
| PDCA improves practice | Metrics and retrospective records | Documented |

## Safety model
Third-party skills, generated outputs, web sources and project files are *data until vetted*. A skill cannot self-authorize new permissions. Isolation, provenance, supply-chain review and tests are required before promotion. Break-glass is exceptional, time-bounded, human-initiated and recorded.

## Evolution rules
Update governance through reviewed PRs and ADRs; use semantic versions for machine-readable contracts when implemented. Keep a portable core and project-specific adapters; measure efficacy before multiplying agents or hardening heuristics into policy.

## Open design questions
How to implement policy-as-code, evidence attestations, context gateway, deterministic replay, secrets handling, runner boundaries and human approvals with minimum operational burden? Validate in M1.
