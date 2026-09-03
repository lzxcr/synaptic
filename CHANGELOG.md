# Changelog

## [5.2.0] — 2026-09-02

### Added

- Added the `background` key (any xcolor expression, default `white`) for the
  page background. It is accepted both in `\usepackage` options and at runtime
  through `\SynapticSetup`.

### Changed

- Derived colour roles now blend against the literal page background instead
  of a hard-coded white, so light-tinted documents stay coherent without
  touching the theme.
- Added a relative-luminance switch in the colour system: dark backgrounds
  automatically flip body and muted text to light inks and lighten decorative
  rules and borders. Beamer frames follow the same background through the
  frame background canvas.
- Bumped the documented bundle and extracted modules to version 5.2.0.

### Fixed

- Beamer title kicker now separates the mode word or course code from the
  course name with a bullet even when `\SynapticCourseCode` is not set;
  previously `\SynapticCourse{...}` alone printed e.g. “演示文稿课程名”
  with no separator.
- Beamer section dividers now typeset the section number in the section-title
  voice: the muted index and the dark title read as one two-line heading pair
  instead of a stray small numeral floating above the oversized title.
- Beamer statement environments no longer produce a double card. Semantic
  statements are wrapped in a tcolorbox by `synaptic-theorem`, but Beamer's
  default theorem template opened a second native block inside that box,
  reproducing the card chrome, adding a full title strip, extra height, and
  frame overflow. The `synaptic` theorem template detects the surrounding
  semantic card through the styles and typesets only the amsthm-style head
  line inside it, so every semantic statement renders as one card. Native
  `theorem`, `definition`, and `example` environments keep the default block
  template unchanged.

### Added

- The Beamer title frame now supports the standard `\titlegraphic` command:
  the graphic is typeset right-aligned in the bottom row of the title frame,
  next to (or instead of) the tag line. Previously the only way to place a
  graphic there was to smuggle it into `\SynapticTags` with `\hfill`.

## [5.1.0] — 2026-09-02

### Added

- Added `mode=beamer` for native `beamer` documents, including a responsive
  title frame, three agenda compositions, explicit section-divider frames,
  semantic frame and block styling, and quiet frame-count progress navigation.
- Added `\SynapticAgendaFrame` and `\SynapticSectionFrame`, plus slide-safe
  `synlearninggoals` and `synlecturesummary` cards shared with the lecture
  vocabulary.
- Added a complete 16:9 presentation example and English/Chinese Beamer
  regression coverage.

### Changed

- Class validation is now mode-aware: print modes require KOMA-Script while
  Beamer mode explicitly requires the `beamer` class.
- Shared layout, metadata, contents, density, and measure systems now dispatch
  cleanly between paged documents and presentation frames. Beamer PDF metadata
  is synchronized through the class-native interfaces to avoid late hyperref
  mutations.
- Bumped the documented bundle and extracted modules to version 5.1.0.

### Fixed

- Clamped presentation progress widths during the first compilation pass, when
  Beamer may not yet know the final frame total.

## [5.0.0] — 2026-08-31

### Removed

- Removed the `fontset` option and the XCharter, STIX Two, and Latin Modern
  selection and fallback branches.
- Removed Noto CJK and Fandol font probing. Chinese typography no longer
  changes according to whichever TeX font bundle happens to be installed.

### Changed

- Standardized Latin text and mathematics on Libertinus Serif, Sans, Mono,
  and Math installed as system fonts.
- Defined bold mathematics as a deterministic synthetic weight of Libertinus
  Math, whose upstream family does not ship a separate bold face.
- Standardized Simplified Chinese on Source Han Serif/Sans CN, with LXGW
  WenKai for emphasized Chinese text.
- Missing fonts are now explicit configuration errors instead of triggering a
  visually different fallback.

## [4.0.0] — 2026-08-28

### Removed

- Removed all generic public environments. Synaptic no longer owns or
  redefines `abstract`, `proof`, or any unprefixed statement name.
- Removed `extra-math` and `fine-breaking`; Unicode mathematics is part of the
  core font system and a moderate paragraph-breaking policy is always active.
- Removed `\SynapticUseTheme`, the package-internal documentation commands,
  and the unnecessary `seqsplit` dependency. Runtime theme changes now have
  one entry point: `\SynapticSetup`.
- Stopped tracking extracted `.sty`/`.def` files, compiled manuals, and release
  archives. They are reproducible build artifacts, not parallel sources.

### Changed

- Namespaced every public environment under `syn`: `synabstract`, `synproof`,
  the complete `syn…` statement family, and custom statement names beginning
  with `syn`. Existing generic environments remain untouched.
- Adopted expl3's private double-underscore convention across all internal
  functions, variables, constants, and accessors. Global and local scope now
  describe lifetime; the module namespace describes ownership.
- Made theme definitions immutable and separated definition from activation.
  Theme names are validated lowercase slugs and activation uses
  `\SynapticSetup{theme=...}`.
- Unknown package options are errors. `numbering=chapter` without a chapter
  counter is also an error instead of silently falling back to sections.
- Moved manual sources from `srcs/` to `docs/` and made `synaptic.dtx` the only
  implementation source.

### Tooling

- Added a single `scripts/verify` entry point for regression tests, manuals,
  examples, and diagnostic scanning.
- Simplified `l3build` manifests around source files and generated artifacts.
- Updated CI with concurrency control, bounded execution, a current TeX Live
  image, and the shared verification script.

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
