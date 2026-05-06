# zigcodec

`zigcodec` treats blockchain tooling as a local verification problem. The Zig implementation is intentionally narrow, but the fixtures and notes make the behavior explicit.

## Zigcodec Checkpoints

Treat the compact fixture as the contract and the extended examples as a scratchpad. The code should stay boring enough that a change in behavior is obvious from the test output.

## What This Is For

The goal is to capture the core behavior in code and make the surrounding assumptions obvious. A reader should be able to run the verifier, open the fixtures, and understand why each decision was made.

## Case Study

The examples are meant to be readable before they are exhaustive. They cover enough variation to show how latency and risk can pull a decision below the threshold.

## Architecture Notes

The interesting part is the boundary between accepted and reviewed scenarios. Extended examples sit near that boundary so future edits can show whether the model became more permissive or more cautious. The Zig version uses compile-time constants and native test blocks for fast local checks.

## Useful Pieces

- Models contract state with deterministic scoring and explicit review decisions.
- Uses fixture data to keep event replay changes visible in code review.
- Includes extended examples for invariant checks, including `surge` and `degraded`.
- Documents settlement rules tradeoffs in `docs/operations.md`.
- Runs locally with a single verification command and no external credentials.

## Local Workflow

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/verify.ps1
```

This runs the language-level build or test path against the compact fixture set.

## Quality Gate

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/audit.ps1
```

The audit command checks repository structure and README constraints before it delegates to the verifier.

## Project Layout

- `src`: primary implementation
- `fixtures`: compact golden scenarios
- `examples`: expanded scenario set
- `metadata`: project constants and verification metadata
- `docs`: operations and extension notes
- `scripts`: local verification and audit commands

## Expansion Ideas

- Add a loader for `examples/extended_cases.csv` and promote selected cases into the language test suite.
- Add a short report command that prints the score breakdown for a single scenario.
- Add malformed input fixtures so the failure path is as visible as the happy path.
- Add one more blockchain tooling fixture that focuses on a malformed or borderline input.

## Scope

The scoring model is simple by design. More domain-specific behavior should be added through explicit adapters or extra fixture classes rather than hidden constants.

## Tooling

Use a normal shell with Zig available on `PATH`. The verifier is written as a PowerShell script because the portfolio was assembled on Windows.
