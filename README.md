# zigcodec

`zigcodec` is a Zig project in blockchain tooling. Its focus is to encode and decode Base58Check payloads with checksum diagnostics.

## Use Case

This is intentionally local and self-contained so it can be inspected without credentials, services, or seeded history.

## Zigcodec Review Notes

The first comparison I would make is `event finality` against `nonce pressure` because it shows where the rule is most opinionated.

## Highlights

- `fixtures/domain_review.csv` adds cases for event finality and nonce pressure.
- `metadata/domain-review.json` records the same cases in structured form.
- `config/review-profile.json` captures the read order and the two review questions.
- `examples/zigcodec-walkthrough.md` walks through the case spread.
- The Zig code includes a review path for `event finality` and `nonce pressure`.
- `docs/field-notes.md` explains the strongest and weakest cases.

## Code Layout

The implementation keeps the scoring rule plain: reward signal and confidence, preserve slack, penalize drag, then classify the result into a review lane.

The Zig implementation avoids hidden state so fixture changes are easy to reason about.

## Run The Check

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/verify.ps1
```

## Regression Path

The verifier is intentionally local. It should fail if the fixture score math, lane assignment, or language-specific test drifts.

## Future Work

The fixture set is small enough to audit by hand. The next useful expansion is malformed input coverage, not extra surface area.
