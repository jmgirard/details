# Toolchain profile: generic

<!-- A cairn *toolchain profile*: the language/toolchain-specific slots the
     operational skills read. cairn-init instantiates the chosen reference
     profile into the repo's `cairn/PROFILE.md`. The oracle / Validation
     doctrine is UNIVERSAL and deliberately NOT a slot here — it is the
     orthogonal domain axis (D-024/D-025), stated once in
     skills/shared/validation-doctrine.md (referenced from tracking-rules).
     Every profile defines all seven `## <slot>` sections below; a slot with no
     toolchain-specific content says so explicitly rather than being omitted
     (cairn_validate FAILs on a missing or empty slot). -->

The language-agnostic default: cairn's core with no toolchain-specific gates.
Selected by `cairn-init` when no `DESCRIPTION` (or other recognized toolchain
marker) is present. A repo replaces the placeholder in `verify` with its own
test command; the other slots stand as-is until a richer profile is authored.

## verify
The command(s) `/milestone-implement` and `/hotfix` run to check a task before
ticking it off. This repo declares:

```
quarto render
```

Rendering `index.qmd` (the demo document) exercises every shortcode
(`dtext` / `dstart` / `dstop`) end-to-end through the real Quarto pipeline —
a render that fails, or that emits no `<details>` markup, is a failed verify.
There is no unit-test harness for the Lua filter yet; until there is, the
render is the whole automated check and acceptance-criteria evidence carries
the rest.

## consistency-gate
Toolchain checks `/milestone-review` runs *in addition to* the universal
cairn-file checks (`cairn_validate`, coverage completeness, `cairn_impact`).
Generic default: **none** — the universal cairn-file checks are the whole
consistency gate.

## test-doctrine
Toolchain-specific test expectations layered on the universal "What gets a
test" rules in tracking-rules. Generic default: **none beyond the universal
rules** — every bug fix gets a regression test, every documented claim a test,
contract-not-implementation, and the oracle doctrine for any numeric result.

## release-walk
The release procedure `/cairn-release` follows. Generic default: a minimal
language-agnostic walk — no package-registry submission; the tag is the release:
- Decide the version bump (patch/minor/major) from the declared changelog
  (`## changelog` slot; "none" → derive the bump from git history).
- Consolidate the declared changelog: retitle the dev heading to the version,
  group entries, prune noise ("none" → skip this step).
- Bump the repo's version marker and commit the release prep to the default
  branch (docs/metadata only).
- Tag and push the tag at the user's approval — no registry step. **This repo's
  existing tag is `1.0.0`, with no `v` prefix**; match that convention rather
  than the `v<version>` generic default.
- Where the `origin` remote is GitHub and `gh` is available, the handoff also
  provides a `gh release create` command whose body is the new changelog
  section (provided, never run — the universal step 4).

## init-detection
How `cairn-init` recognizes this toolchain. Generic is the **fallback**: no
`DESCRIPTION` and no other recognized toolchain marker.

## greenfield-openers
Opener questions `cairn-init` asks in a new/empty repo of this type. Generic
default: **no language-specific openers** — the universal opener layer
(distribution ambition, rendered here as a **tagged public release** vs.
internal-only choice, and numeric-work-needs-oracle-verification) is the whole
greenfield flow for a generic repo; a richer profile adds its own on top.

## changelog
The repo's changelog file, read by `/hotfix`, the release-walk, and the
consistency-gate. This repo declares: **`CHANGELOG.md`** (repo root).

The version marker the release-walk bumps is `version:` in
`_extensions/details/_extension.yml`; it must match the newest `CHANGELOG.md`
heading and the `v<version>` tag.
