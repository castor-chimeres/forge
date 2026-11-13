# ADR-0005 — Isolation of third-party skills

**Status:** Proposed

## Context
External skills may contain unsafe tool guidance, supply-chain risk or instructions not suited to our studio.

## Proposal
Quarantine and inspect each third-party skill (origin, version, license, behavior, permissions) before execution. Test with limited privileges and controlled inputs. Do not install or promote directly from an upstream catalog.

## Validation
Security checks, adversarial test cases, reproducible evaluation and explicit promotion.
