# Changelog

## [3.0.0] — 2026-08-28

### Removed

- Dropped every backward-compatibility shim. The `\pkg`, `\cmd`, and
  `\acknowledgments` aliases and the lowercase `\synapticfrontmatter`,
  `\synapticmainmatter`, and `\synapticbackmatter` aliases are gone; use the
  `\Synaptic…` forms. The import of standard `\title`, `\author`, and `\date`
  metadata is gone: declare metadata with `\SynapticTitle` and friends.
- Removed the obsolete `style` and `color` option-error traps and the
  `box-numbering` option. Statements now have one numbering model.
- Removed the `synaptic-boxes` module and its `synexample`, `synremark`,
  `synwarning`, `synexercise`, and `synbox` environments. Their functionality
  is provided by the theorem family (see below) and by `synlearninggoals`,
  `synlecturesummary`, and the notes cards.

### Changed

- Unified the statement environments onto the shared theorem counter. `example`
  and `exercise` are now plain-style statements, and `warning` is a
  remark-style statement, in every mode and in book/chapter or
  section numbering alike. Collision protection for *foreign* environment
  names remains, but `\SynapticNewTheorem` on an already-declared environment
  is now a hard error instead of a warning.
- Renamed `title-layout=cover` to `title-layout=sequence` after the book title
  sequence it actually produces.
- `\SynapticSetup` now errors on structural keys instead of warning and
  silently ignoring them; only `theme`, `toc`, and `toc-layout` are mutable
  after loading.

### Fixed

- Stopped the pdf backend from reporting duplicate destinations for numbered
  theorem environments. `thmtools`' `numberwithin` registers the structural
  parent for the displayed number and the counter reset, but not in
  hyperref's `cl@<counter>` list, so every environment sharing the `theorem`
  counter produced the same `\theH` anchor. Two theorems in different sections
  therefore collided (e.g. `theorem.1`), yielding the `duplicate destination`
  warning and link targets that could jump to the wrong statement. Synaptic now
  rebuilds `\theH<theorem>` and every sibling environment's anchor against the
  real parent (`section` or `chapter`), so anchors stay unique and links land
  correctly. Applies to the built-in environments and to anything declared via
  `\SynapticNewTheorem`.

## [2.6.1] — 2026-08-28

### Fixed

- Stopped the pdf backend from reporting duplicate destinations for numbered
  theorem environments (brought forward into 3.0.0).

## [2.6.0] — 2026-08-28

### Added

- Completed the heading hierarchy. The run-in `\paragraph` and `\subparagraph`
  levels now inherit the same sans heading voice as the numbered levels instead
  of falling back to the document default. Each deeper level sits in a
  monotonically lighter colour, so a heading used without its intermediate
  level no longer reads with more weight than the level above it.
- Added table-of-contents entries for `\paragraph` and `\subparagraph` with a
  matching muted gradient and deeper indentation, so deep hierarchies stay
  legible when a document opts into that `tocdepth`.

### Changed

- Unified the deeper heading sizes (`subsubsection`, `paragraph`, and
  `subparagraph`) on the same small size, with colour depth carrying the
  remaining distinction, so block and run-in headings scale predictably.

## [2.5.0] — 2026-08-28

### Added

- Introduced a shared “synaptic rail” motif—an asymmetric rule, accent node,
  and quiet continuation line—across title matter, chapter openings, running
  navigation, and intentionally blank book versos. This turns large areas of
  white space into deliberate structure without adding illustrative clutter.
- Added mode-aware title kickers and richer full-page compositions for book
  and notes documents. Book half-title and copyright versos now carry a quiet
  colophon treatment; notes title pages use a stronger editorial hierarchy and
  anchored metadata panel.
- Added bilingual contents and list names to the language layer.

### Changed

- Rebalanced the default page profiles to make better use of A4 and Letter
  paper, especially in book and lecture mode, while preserving readable line
  lengths and the existing `measure` overrides.
- Refined section numbering, folios, chapter/part rules, theorem surfaces,
  teaching cards, and notes cards around one coherent visual vocabulary.
- Reworked the four bundled examples so compiled samples exercise realistic
  hierarchy and page composition instead of looking like sparse smoke tests.
- Made `\SynapticNewTheorem` idempotent for already-defined environments so
  documents written against older built-in theorem sets continue to compile.

## [2.4.0] — 2026-08-27

### Added

- Gave the core theorem environments (`theorem`, `lemma`, `proposition`,
  `definition`) a refined boxed presentation in every mode: a subtle
  theme-tinted background, a west accent bar, and square corners that match
  the existing teaching and notes card language. Proofs remain clean and
  unboxed, and a short statement stays away from the foot of a page through
  `\Needspace` guards.
- Added a broad set of theorem environments with bilingual labels:
  `corollary`, `axiom`, `conjecture`, `claim`, `property`, `criterion`,
  `convention`, `problem`, `solution`, `example`, `remark`, and `note`.
  These share the theorem counter and honour every `numbering` profile.
- Introduced the `theorem-style` package option (`boxed` for the default
  refined presentation, `plain` for the classic unboxed look). It is a
  structural key and is frozen after package loading.
- Wrapped any theorem declared through `\SynapticNewTheorem` in the matching
  boxed style, so custom environments stay visually consistent.
- Refined the table of contents in every mode: top-level (chapter/section)
  entries echo the on-page heading colour in bold, deeper entries stay dark,
  and the number alignment and vertical rhythm are tightened through KOMA's
  `\DeclareTOCStyleEntry`.
- Unified the section-heading family so all numbered levels use the sans
  heading face; `subsubsection` is now set slightly smaller and muted to keep
  the depth hierarchy clear.
- Refined the book mode: chapter headings now set the number and title inline
  with a short primary rule beneath (echoing the title-page bar), and chapter
  table-of-contents entries repeat the primary heading colour in bold so the
  contents echo the on-page structure.

### Changed

- Coloured figure and table caption labels with the secondary theme token so
  the caption language ties into the rest of the design.
- The lecture module now reuses the shared theorem-box styling from
  `synaptic-theorem` instead of redeclaring its own; the visual result is
  unchanged.
- `\SynapticNewTheorem` now accepts the same `plain`, `definition`, and
  `remark` styles and applies the corresponding box treatment.

## [2.3.0] — 2026-08-23

### Added

- Added a hairline separator beneath running heads in every mode
  (`headsepline`, coloured through the dedicated KOMA font), giving the
  journal, book, lecture, and notes navigation a precise editorial finish.
- Added an editorial double rule (strong bar over hairline) beneath journal
  titles.
- Expanded the regression suite from nine to eighteen groups: theme cycling
  and custom themes, print colour delivery, book layout profiles
  (density/measure/binding offset), TOC layouts, standalone title pages, the
  complete book workflow, continuous+separate numbering, extra mathematics
  alphabets, and a Chinese journal test.

### Changed

- Removed the superseded monolithic `\SynapticMakeTitle` implementation from
  `synaptic-title`; the mode-aware title renderers are now the single source
  of truth.
- Unified all teaching and notes card corner radii to square, matching the
  theorem boxes for a consistent card language.

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
