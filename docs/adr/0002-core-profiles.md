# ADR-0002 — Portable core and project profiles

**Status:** Accepted (M0)

## Decision
Separate engine-agnostic governance/orchestration from project adapters. Godot is the first target profile, not a hardcoded dependency of Golden Thread.

## Consequences
Profiles may extend but cannot weaken global policy.
