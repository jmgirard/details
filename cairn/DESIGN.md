# Design

_Architecture as it **is**, not as it will be. No status, no task lists, no
future work (those live in ROADMAP.md and the milestone files)._

> **Seeded by `/cairn-init` on 2026-08-16 from a read of the source and README —
> not elicited.** Purpose & Scope and Conventions below are honest observations
> of what the code does today. The Design Principles section is deliberately
> empty: cairn never invents principles. Run `/design-interview` to elicit the
> contract boundary and the IP/GP principles the code cannot show.

## Purpose & Scope

`details` is a Quarto extension that adds collapsible `<details>` blocks to
Quarto HTML documents via shortcodes. The motivating use is instructional
material — hints, answer keys, and supplemental information a reader can reveal
on demand — filling a gap that Quarto's built-in code folding covers only for
code.

- Distributed as a Quarto extension, installed with `quarto add jmgirard/details`;
  there is no package-registry step.
- Ships three shortcodes: `dtext` (single-argument inline block), and the
  `dstart` / `dstop` pair that wraps arbitrary markdown, including executed
  code chunks.
- HTML-only by scope: on any non-`html:js` format the shortcodes emit nothing.
- `index.qmd` is both the demo and the de facto test — it is published to
  <https://jmgirard.github.io/details>.

## Function Families

- **Shortcode entry points** (`_extensions/details/details.lua`) — `dtext`,
  `dstart`, `dstop`. Each is a Quarto shortcode handler taking
  `(args, kwargs, meta)` and returning a `pandoc.RawInline('html', …)` under
  HTML or `pandoc.Null()` otherwise.
- **Markup builders** — the local `buildDetails` closures inside `dtext` and
  `dstart`, which assemble the raw HTML string.

## Conventions

- Emitted markup is a fixed nesting: `<p><details[ open]><summary>…</summary>
  <blockquote>…</blockquote></details></p>`. The `<blockquote>` is the visual
  treatment for details content; the wrapping `<p>` keeps the block inside
  Pandoc's inline flow.
- Argument surface: the first positional argument is the content (`dtext` only);
  `summary=` is a keyword argument defaulting to `"Details"`; `open` is a bare
  positional flag detected by substring search over the remaining arguments.
- Format gating goes through `quarto.doc.isFormat("html:js")`; every handler
  gates, and the non-HTML branch is always `pandoc.Null()`.
- Extension metadata (`_extensions/details/_extension.yml`) carries the version
  and `quarto-required: ">=1.6.0"`.
- Numeric results, should any arise, require oracle verification (≥2 independent
  types) before being claimed — the universal cairn validation doctrine.

## Design Principles

<!-- IP<n> = Inviolable (hard constraint) block first, then GP<n> = Guiding
     (tradeable with stated justification). Numbers are never reused or
     renumbered; retiring one takes a D-entry. -->

_None elicited yet — run `/design-interview`._

## Architecture

A single Lua filter file registered as a Quarto shortcode contributor. There is
no build step, no dependency beyond Quarto ≥ 1.6.0 and Pandoc's Lua API, and no
runtime state: each shortcode invocation is a pure string-assembly function of
its arguments.

The repo doubles as its own demo site — `_quarto.yml` declares a `website`
project with `freeze: auto`, and the rendered `_site/` and `_freeze/` outputs
are committed so GitHub Pages can serve them.

## Known issues

- On non-HTML formats the shortcodes emit nothing at all, so details content is
  **silently dropped** rather than degraded to visible text — a PDF or docx
  render loses the hint or answer key with no warning.
- `dstart` / `dstop` are unbalanced-by-construction: nothing checks that a
  `dstart` is closed, and an unmatched one emits unclosed HTML tags.
- There is no test harness for the Lua filter; `quarto render` of the demo is
  the only automated check (see `cairn/PROFILE.md` → `verify`).
