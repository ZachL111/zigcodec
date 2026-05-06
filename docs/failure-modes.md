# Failure Modes

For `zigcodec`, I would look first for these mistakes:

- `event finality` cases moving lanes without a matching threshold change.
- `settlement risk` scoring higher after drag increases.
- Duplicate fixture ids hiding a stale golden row.
- README examples drifting away from the verifier.

The local checks are intentionally strict about these cases.
