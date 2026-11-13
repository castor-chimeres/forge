# ADR-0008 — Governed skill lifecycle

**Status:** Proposed

## Context
Game-dev-design and other GameDev skill collections are useful research material, not trusted drop-in dependencies.

## Decision proposed
Operate Discover -> Qualify/Adapt -> Experiment -> Evaluate/Improve -> Promote/Retire. Every skill has origin, pinned version, license, fingerprint, declared permissions, owner, status, test evidence and rollback path.

## Consequences
A SkillManifest and isolated evaluation harness will be implemented later. No direct importing or autonomous promotion. Results feed PDCA and update the studio's curated variants, not only individual games.
