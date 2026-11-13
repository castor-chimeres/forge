# Product requirements — Castor & Chimères Forge (M0)

**Status:** Draft for review. **Product:** independent agentic development forge. **First use:** Godot/GameDev; reusable beyond games.

## Problem
We want to delegate useful development work to AI agents without losing reproducibility, engineering discipline, security, human control or the ability to improve the process. A prompt collection or a hard-coded six-agent swarm is not sufficient.

## Goals
- G1: Rebuild the forge from versioned configuration and documented prerequisites (as code).
- G2: Use Golden Thread as a governance *control plane* for all execution modes.
- G3: Enable a minimal end-to-end task on a Godot project with readiness, implementation, tests, review and human gate.
- G4: Measure and improve the *agentic practice* via PDCA.
- G5: Curate skills through provenance, security review, experiments and evidence-based promotion.

## Non-goals for M0
- Full swarm implementation, autonomous deployment, production game development, universal orchestration, unbounded internet access.
- Treating any external collection of skills as ready-to-use.
- Making Spec-Driven Development the sole workflow.

## Stakeholders
Studio owner (approver/operator); agents (workers/reviewers); future collaborators (contributors). Human retains decision authority for risky or irreversible actions.

## Functional requirements
| ID | Requirement | Acceptance evidence |
|---|---|---|
| F-01 | Versioned documented bootstrap | Fresh-environment reproduction procedure and smoke test |
| F-02 | Canonical agent instructions | AGENTS.md, Claude adapter, discoverability check |
| F-03 | Task contracts | Versioned TaskSpec schema and validation |
| F-04 | Readiness | DoR + Spec-Readiness rule set and failure examples |
| F-05 | Controlled execution | Policy-enforced tool/capability boundaries |
| F-06 | Test + review | Independent verifiable EvidenceManifest |
| F-07 | Human gates | Explicit approval before privileged or irreversible actions |
| F-08 | Operational visibility | Traceable runs, failures, cost/context metrics |
| F-09 | Golden Thread control plane | Controls mapped to enforcement points |
| F-10 | Multiple execution modes | Workflow-neutral contracts; Agentic Scrum compatible |
| F-11 | Context governance | Minimal context, budget/trim/prune/compact with traceability |
| F-12 | Governed skills lifecycle | Provenance, review, sandbox eval, promotion/rollback |
| F-13 | PDCA loop | Recorded hypotheses, observations, decisions and improvements |

## Key constraints
- Everything feasible as code, including environment, contracts, profiles, policies and tests.
- Least privilege by default; external skills treated as untrusted.
- Unknown unknowns: require explicit discovery/review checkpoints when justified by risk.
- No gate can be bypassed silently; break-glass is human-controlled and auditable.
- Metrics include test success, intervention frequency, cycle time, context consumption, rework and downstream quality. DORA may be added when applicable.

## M0 deliverables
PRD, ADRs, agent instruction files, Golden Thread architecture, documentation checks. **Documentation is not enforcement.**

## M1 candidate vertical slice
Run one low-risk Godot change through: TaskSpec -> Spec-Readiness -> scoped execution -> tests -> review -> EvidenceManifest -> human approval -> retrospective. Define schemas and enforcement before adding more agent roles.

## Acceptance of M0
All documents readable and internally linked; decisions classified as Accepted or Proposed; no claim that runtime controls exist before implementation; PR reviewed by a human.
