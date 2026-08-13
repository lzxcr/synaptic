# Changelog

## [2.2.0] — 2026-08-13

### Added

- Added dedicated `synaptic-journal` and `synaptic-notes` modules so all four
  modes now have an explicit design and navigation layer.
- Added mode-aware title renderers: inline journal headings, a book half-title
  and formal title/verso sequence, a course masthead, and a compact notes
  masthead. Standard `\title`, `\author`, and `\date` metadata can be imported.
- Added subtitle, short-title, publication, correspondence, book-production,
  course, lecture, semester, tag, and author-note metadata.
- Added `title-layout`, `numbering`, `box-numbering`, `color-mode`, `density`,
  `measure`, and `binding-offset` configuration keys.
- Added book contents/list/appendix helpers, chapter subtitles, and epigraphs;
  teaching learning-goal/summary cards; and notes key-idea, question, to-do,
  and summary cards.
- Added notes, structural-option, Chinese book, and Chinese lecture regression
  files, expanding the suite to nine test groups.

### Changed

- Automatic tables of contents are now opt-in. This avoids inappropriate TOCs
  in articles and leaves book front-matter ordering under author control.
- Journal titles are inline by default and no longer reset page numbering or
  force a title-page break.
- Book theorem/equation numbering defaults to chapter scope, while shorter
  modes retain section scope. Lecture examples and exercises share the theorem
  counter by default; warnings and remarks are unnumbered.
- Reworked book title matter, part pages, chapter subtitles, front/back matter,
  outer running heads, chapter folios, blank pages, and binding correction.
- Separated readable muted text from decorative pale colours and added print
  and monochrome delivery modes.
- Improved Chinese labels, punctuation, leading, and theorem typography; CJK
  theorem bodies no longer rely on simulated italics.
- Rebalanced line measure, density profiles, caption punctuation, lecture
  cards, and compact notes typography.

### Fixed

- Fixed doubled punctuation such as `Table 2.1..` in chapter-based documents.
- Prevented duplicate PDF page destinations when book main matter resets page
  numbering after unnumbered title matter.
- Prevented short lecture theorems from leaving their proof isolated at the
  top of the next page.
- Fixed unset standard LaTeX title metadata producing spurious author warnings
  when only Synaptic metadata is used.
- Made `numbering=none` safely suppress AMS equation, alignment, gather, and
  multiline numbers without capturing or corrupting alignment bodies.

## [2.1.0] — 2026-08-13

### Fixed
- Repaired the LuaLaTeX startup path: removed invalid unconditional
  `\directlua` code and replaced fragile Lua/font-file probing with complete
  `fontspec` bundle checks and deterministic fallbacks.
- Made `mode=book` work with `scrbook`, including the previously missing
  `abstract` definition, correct chapter acknowledgments, mirrored geometry,
  and stable running heads.
- Corrected lecture-mode `tcolorbox` library ordering, theorem wrapping, key
  syntax, and broken box declarations.
- Fixed custom theme declaration/activation and Unicode PDF metadata encoding.
- Stopped forcing A4 paper and removed blanket bad-box suppression.

### Changed
- Refined line length, vertical rhythm, paragraph indentation, list spacing,
  theorem styles, semantic colours, title composition, book folios, and lecture
  boxes across all four modes.
- Font bundles now use lining proportional figures; STIX Two uses dedicated
  sans and mono companions.
- `\SynapticSetup` now applies only safe runtime keys. Structural keys emit an
  explicit frozen-option warning.
- Added collision-resistant `synexample`, `synremark`, `synwarning`, and
  `synexercise` environments. Generic v2.0 aliases are installed only if free.
- Added `\SynapticSubject`, `\SynapticUseTheme`, styled custom theorems, public
  book matter commands, and starred acknowledgments.

### Tooling and documentation
- Added examples for journal, book, lecture, and notes modes.
- Added five LuaLaTeX regression tests, `l3build` documentation configuration,
  and GitHub Actions CI.
- Reworked the README and bilingual manuals for the v2.1 API; regenerated all
  committed package files and PDF manuals.

## [2.0.0] — 2026-06-05

### Major restructuring
- Complete modular refactoring: single `synaptic.sty` → 10+ modules
- Introduced `mode=` system: `journal`, `book`, `lecture`, `notes`
- Introduced `theme=` system: `ocean`, `graphite`, `forest`, `midnight`, `paper`
- Introduced `fontset=` system: `xcharter`, `libertinus`, `stix2`, `lm`, `auto`
- Introduced font-set auto selection.

### Breaking changes (v1 → v2, no compatibility layer)
- `color=ocean` → `theme=ocean`
- `style=modern/minimal` → `mode=journal/notes`
- `\title{...}` → `\SynapticTitle{...}`
- `\author{...}` → `\SynapticAuthor{...}`
- `\maketitle` → `\SynapticMakeTitle`
- New user API: `\SynapticAffiliation`, `\SynapticEmail`, `\SynapticKeywords`,
  `\SynapticArxiv`, `\SynapticSetup`, `\SynapticNewTheorem`,
  `\SynapticDefineTheme`

### Added
- Lecture mode with tcolorbox `{example}`, `{remark}`, `{warning}`, `{exercise}`,
  `{synbox}` environments
- Book mode with chapter styling, running headers, front/back matter
- Language definition files (`synaptic-lang-en.def`, `synaptic-lang-zh.def`)
- Automatic font-bundle selection

### Fixed
- No longer redefines `\title`/`\author`/`\maketitle` (avoids conflicts)
- `lang=zh` loads CJK fonts only when explicitly requested
- Module separation prevents cross-contamination of settings
