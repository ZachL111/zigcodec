# Zigcodec Walkthrough

I use this file as a small checklist before changing the Zig implementation.

| Case | Focus | Score | Lane |
| --- | --- | ---: | --- |
| baseline | event finality | 191 | ship |
| stress | nonce pressure | 138 | watch |
| edge | settlement risk | 156 | ship |
| recovery | proof depth | 192 | ship |
| stale | event finality | 203 | ship |

Start with `stale` and `stress`. They create the widest contrast in this repository's fixture set, which makes them better review anchors than the middle cases.

The next useful expansion would be a malformed fixture around nonce pressure and proof depth.
