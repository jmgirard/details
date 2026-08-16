# Decisions

_Append-only. Never renumber; supersede with a new entry. D-entries record
choices with rationale — including genuine rejections ("considered X, rejected
because…"). They never record deferrals: "not now" is a ROADMAP fact
(candidate row or future milestone), not a decision._

### D-001 (2026-08-16): Adopt cairn with the generic toolchain profile

**Context:** The repo is a Quarto extension (Lua shortcodes + `_extension.yml`)
with no `DESCRIPTION`, `pyproject.toml`, or `Dockerfile` — none of cairn's
recognized toolchain markers.
**Decision:** Adopt cairn on the `generic` profile, declaring `quarto render` as
the `verify` command and `CHANGELOG.md` as the changelog file.
**Consequences:** No toolchain-specific consistency gate; the tag is the release
(no package-registry step). `verify` rests on the demo render until a real Lua
test harness exists (banked as a ROADMAP candidate).
