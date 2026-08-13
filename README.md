<p align="center">
  <a href="https://www.latex-project.org/"><img src="https://img.shields.io/badge/LaTeX-3-008080?style=flat-square&logo=latex" alt="LaTeX3"></a>
  <a href="https://www.luatex.org/"><img src="https://img.shields.io/badge/engine-LuaLaTeX-2c5aa0?style=flat-square" alt="LuaLaTeX"></a>
  <a href="https://www.latex-project.org/lppl/"><img src="https://img.shields.io/badge/license-LPPL%201.3c-lightgrey?style=flat-square" alt="LPPL 1.3c"></a>
</p>

<h1 align="center">synaptic</h1>

<p align="center">A modular LaTeX3 design system for academic articles, books, lectures, and notes.</p>

`synaptic` combines a consistent typographic system with mode-aware layouts,
Unicode mathematics, bilingual labels, semantic colour tokens, and a
collision-resistant public API. It requires LuaLaTeX, a recent LaTeX format,
and a KOMA-Script document class.

## Quick start

Point `TEXINPUTS` at the pre-generated package directory:

```bash
export TEXINPUTS=/path/to/synaptic/tex/latex/synaptic//:$TEXINPUTS
lualatex document.tex
```

Then use a KOMA-Script class:

```latex
\documentclass[11pt]{scrartcl}
\usepackage[mode=journal,theme=ocean,fontset=auto]{synaptic}

\SynapticTitle{A Clear Academic Article}
\SynapticAuthor[1]{Ada Author}
\SynapticAffiliation[1]{Department of Typesetting}
\SynapticEmail{ada@example.org}
\SynapticSubject{A short article example}
\SynapticKeywords{LaTeX, typography}
\begin{abstract}A concise abstract.\end{abstract}

\begin{document}
\SynapticMakeTitle
\section{Introduction}
\begin{theorem}A readable theorem.\end{theorem}
\end{document}
```

Ready-to-compile documents for every mode live in [`examples/`](examples/).

## Requirements

- LuaLaTeX; pdfLaTeX and XeLaTeX are rejected with an explicit error.
- A KOMA-Script class. Use `scrbook` for `mode=book`; the other modes normally
  use `scrartcl` or `scrreprt`.
- A recent TeX distribution containing `expl3`, `fontspec`, `unicode-math`,
  `geometry`, `microtype`, `thmtools`, and the other standard dependencies.
- `tcolorbox` and PGF for the teaching and notes cards; `ctex` and a supported
  CJK font for `lang=zh`.

The package respects the paper size selected by the class. It does not force A4.

## Package options

| Key | Default | Values | Runtime? |
|---|---:|---|:---:|
| `mode` | `journal` | `journal`, `book`, `lecture`, `notes` | No |
| `theme` | `ocean` | `ocean`, `graphite`, `forest`, `midnight`, `paper` | Yes |
| `lang` | `en` | `en`, `zh` | No |
| `fontset` | `auto` | `auto`, `xcharter`, `libertinus`, `stix2`, `lm` | No |
| `toc` | `false` | Boolean | Yes |
| `toc-layout` | `top` | `top`, `inline`, `page` | Yes |
| `title-layout` | `auto` | `auto`, `inline`, `compact`, `page`, `cover` | No |
| `numbering` | `auto` | `auto`, `section`, `chapter`, `continuous`, `none` | No |
| `box-numbering` | `shared` | `shared`, `separate`, `none` | No |
| `color-mode` | `screen` | `screen`, `print`, `mono` | No |
| `density` | `balanced` | `compact`, `balanced`, `airy` | No |
| `measure` | `auto` | `auto`, `narrow`, `standard`, `wide` | No |
| `binding-offset` | `0pt` | Any dimension; primarily for books | No |
| `extra-math` | `false` | Boolean | No |
| `fine-breaking` | `true` | Boolean | No |

Only theme and title-page TOC settings can change safely after package loading:

```latex
\SynapticSetup{theme=paper,toc=false,toc-layout=page}
```

Structural runtime changes emit a warning instead of leaving the document in a
partially reconfigured state.

### Modes

| Mode | Recommended class | Main behaviour |
|---|---|---|
| `journal` | `scrartcl` | Inline article title, publication metadata, running heads, statements |
| `book` | `scrbook` | Book title sequence, mirrored navigation, part/chapter design, matter helpers |
| `lecture` | `scrartcl` / `scrreprt` | Course masthead, shared teaching counter, learning and summary cards |
| `notes` | `scrartcl` | Compact masthead, single/two-column support, lightweight knowledge cards |

### Font sets

`auto` selects the first complete installed bundle in this order: XCharter,
Libertinus, STIX Two, then Latin Modern. Detection is performed through
`fontspec`; there is no external Lua helper or shell command. Explicit font-set
requests fail clearly when any required font is missing.

| Set | Roman | Sans | Mono | Math |
|---|---|---|---|---|
| `xcharter` | XCharter | Cabin | Inconsolatazi4 | XCharter Math |
| `libertinus` | Libertinus Serif | Libertinus Sans | Libertinus Mono | Libertinus Math |
| `stix2` | STIX Two Text | TeX Gyre Heros | Latin Modern Mono | STIX Two Math |
| `lm` | Latin Modern Roman | Latin Modern Sans | Latin Modern Mono | Latin Modern Math |

For Chinese, Noto CJK is preferred and the TeX Live Fandol fonts are used as a
fallback.

## Public API

### Shared metadata and mode-aware titles

| Command | Purpose |
|---|---|
| `\SynapticTitle{...}` | Required title |
| `\SynapticSubtitle{...}` / `\SynapticShortTitle{...}` | Display and running titles |
| `\SynapticDate{...}` | Explicit document or lecture date |
| `\SynapticAuthor[mark]{...}` | Repeatable author and optional affiliation mark |
| `\SynapticAffiliation[mark]{...}` | Repeatable affiliation |
| `\SynapticEmail{...}` | Repeatable email |
| `\SynapticSubject{...}` | PDF subject metadata |
| `\SynapticKeywords{...}` | Printed keywords and PDF metadata |
| `\SynapticHeader{...}` / `\SynapticSubHeader{...}` | Title-page header text |
| `\SynapticPreprint{...}` / `\SynapticArxiv{...}` | Preprint fields |
| `\SynapticDedicated{...}` | Dedication |
| `\SynapticMakeTitle` | Validate metadata and render the title |

The same title API is available in all four modes. `journal` renders an inline
article heading by default, `book` renders a book title sequence, and `lecture`
and `notes` use compact mode-specific mastheads. Standard `\title`, `\author`,
and `\date` values are imported when the corresponding Synaptic fields are
empty and `\SynapticMakeTitle` is called.

PDF title, author, subject, and keywords use Unicode-safe conversion. The PDF
catalog language is set to `en-US` or `zh-CN`.

Journal extensions include `\SynapticCorrespondence`,
`\SynapticPublicationInfo`, repeatable `\SynapticAuthorNote`, and the generic
`\SynapticStatement{heading}{body}` for funding, data, ethics, or conflict
statements. Its starred form omits the statement from the table of contents.

### Theorems and boxes

The core environments are `theorem`, `lemma`, `proposition`, `definition`, and
`proof`. Definitions use upright body text; theorem statements use italics in
English and upright text in Chinese. Book mode numbers theorems by chapter by
default; the shorter modes use sections.

```latex
\SynapticNewTheorem[remark]{observation}{Observation}
```

The optional style is `plain`, `definition`, or `remark`.

Lecture mode adds `synexample`, `synremark`, `synwarning`, `synexercise`, and
`synbox`. The first optional argument is a title and the second is a label.
Examples and exercises share the theorem counter by default; warnings and
remarks remain unnumbered:

```latex
\begin{synexample}[Worked example][worked]
  Example content.
\end{synexample}
```

The short v2.0 environment names (`example`, `remark`, `warning`, `exercise`)
are provided only when no existing package or class has already claimed them.

### Themes

Switch a built-in theme with `\SynapticUseTheme{name}` or `\SynapticSetup`.
Define and activate a custom theme using normal xcolor expressions:

```latex
\SynapticDefineTheme{brand}{blue!70!black}{gray!80!black}[orange!80!black]
```

The semantic colours `syn-primary`, `syn-secondary`, `syn-accent`,
`syn-danger`, `syn-warning`, `syn-success`, `syn-surface`, and `syn-border`
are available for extensions.

### Book, lecture, and notes workflows

Book mode provides `\SynapticFrontMatter`, `\SynapticMainMatter`, and
`\SynapticBackMatter`, plus `\SynapticBookContents`, list-of-figures/tables and
appendix helpers. `\SynapticHalfTitle`, `\SynapticPublisher`,
`\SynapticEdition`, `\SynapticISBN`, and `\SynapticCopyright` populate the book
title sequence. `\SynapticChapterSubtitle` and `\SynapticEpigraph` extend
chapter openings.

Lecture metadata uses `\SynapticCourse`, `\SynapticCourseCode`,
`\SynapticLectureNumber`, `\SynapticInstructor`, and `\SynapticSemester`.
The `synlearninggoals` and `synlecturesummary` environments define the beginning
and end of a teaching unit.

Notes mode provides `synkeyidea`, `synquestion`, `syntodo`, and `synsummary`.
It supports class-level `twocolumn`; call `\SynapticBalanceColumns` near the end
when the final two-column page should be balanced.

`\SynapticAcknowledgments` uses a chapter heading in book mode and a section
heading elsewhere; its starred form omits the TOC entry.

## Development

```bash
l3build unpack   # regenerate package files from synaptic.dtx
l3build check    # run LuaLaTeX regression tests
l3build doc      # build documented source and four manuals
l3build ctan     # create a TDS/CTAN release archive
```

`synaptic.dtx` is the source of truth. Generated `.sty` and `.def` files under
`tex/latex/synaptic/` are committed so the repository can be used directly.
CI runs the regression suite and compiles the documentation and examples.

## Documentation

- [English user manual](docs/synaptic-user-en.pdf)
- [中文用户手册](docs/synaptic-user-zh.pdf)
- [English technical reference](docs/synaptic-tech-en.pdf)
- [中文技术参考](docs/synaptic-tech-zh.pdf)
- [`synaptic.dtx`](synaptic.dtx) for the documented implementation

## License

LPPL 1.3c or later. See [LICENSE](LICENSE).
