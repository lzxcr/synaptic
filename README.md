<p align="center">
  <a href="https://www.latex-project.org/"><img src="https://img.shields.io/badge/LaTeX-3-008080?style=flat-square&logo=latex" alt="LaTeX3"></a>
  <a href="https://www.luatex.org/"><img src="https://img.shields.io/badge/engine-LuaLaTeX-2c5aa0?style=flat-square" alt="LuaLaTeX"></a>
  <a href="https://www.latex-project.org/lppl/"><img src="https://img.shields.io/badge/license-LPPL%201.3c-lightgrey?style=flat-square" alt="LPPL 1.3c"></a>
</p>

<h1 align="center">synaptic</h1>

<p align="center">A modular LaTeX3 design system for academic articles, books, lectures, notes, and presentations.</p>

`synaptic` provides mode-aware layouts, Unicode mathematics, bilingual labels,
semantic colour tokens, and a fully namespaced public API. It requires
LuaLaTeX and a recent LaTeX format. Print-oriented modes use KOMA-Script;
presentation mode uses the `beamer` class.

## Quick start

Install the package from the repository root:

```bash
l3build install
```

Then compile a KOMA-Script document with LuaLaTeX:

```latex
\documentclass[11pt]{scrartcl}
\usepackage[mode=journal,theme=ocean]{synaptic}

\SynapticTitle{A Clear Academic Article}
\SynapticAuthor[1]{Ada Author}
\SynapticAffiliation[1]{Department of Typesetting}
\SynapticEmail{ada@example.org}
\SynapticSubject{A short article example}
\SynapticKeywords{LaTeX, typography}
\begin{synabstract}A concise abstract.\end{synabstract}

\begin{document}
\SynapticMakeTitle
\section{Introduction}
\begin{syntheorem}A readable theorem.\end{syntheorem}
\end{document}
```

Ready-to-compile documents for every mode live in [`examples/`](examples/).

## Requirements

- LuaLaTeX; pdfLaTeX and XeLaTeX are rejected.
- A KOMA-Script class for `journal`, `book`, `lecture`, and `notes`. Use
  `scrbook` for `mode=book`; the shorter print modes normally use `scrartcl`
  or `scrreprt`.
- The `beamer` class for `mode=beamer`; `aspectratio=169` is recommended.
- The Libertinus Serif, Sans, Mono, and Math system fonts.
- A recent TeX distribution containing `expl3`, `fontspec`, `unicode-math`,
  `geometry`, `microtype`, `thmtools`, `tcolorbox`, and PGF.
- For `lang=zh`: `ctex`, Source Han Serif/Sans CN, and LXGW WenKai.

The package respects the paper size selected by the class and never forces A4.

## Configuration

| Key | Default | Values | Runtime? |
|---|---:|---|:---:|
| `mode` | `journal` | `journal`, `book`, `lecture`, `notes`, `beamer` | No |
| `theme` | `ocean` | `ocean`, `graphite`, `forest`, `midnight`, `paper` | Yes |
| `background` | `white` | Any xcolor expression | Yes |
| `lang` | `en` | `en`, `zh` | No |
| `toc` | `false` | Boolean | Yes |
| `toc-layout` | `top` | `top`, `inline`, `page` | Yes |
| `title-layout` | `auto` | `auto`, `inline`, `compact`, `page`, `sequence` | No |
| `numbering` | `auto` | `auto`, `section`, `chapter`, `continuous`, `none` | No |
| `color-mode` | `screen` | `screen`, `print`, `mono` | No |
| `density` | `balanced` | `compact`, `balanced`, `airy` | No |
| `measure` | `auto` | `auto`, `narrow`, `standard`, `wide` | No |
| `theorem-style` | `boxed` | `boxed`, `plain` | No |
| `binding-offset` | `0pt` | Any dimension | No |

Only `theme`, `background`, `toc`, and `toc-layout` change after loading:

```latex
\SynapticSetup{theme=paper,background=blue!10,toc=false,toc-layout=page}
```

`background` accepts any xcolor expression and re-derives every semantic
colour role against the selected page colour. Surfaces, borders, and hairlines
blend with the background; when the background is dark, body and muted text
flip to light inks automatically. In Beamer mode the per-frame background
canvas follows the same setting.

Unknown package options and attempts to mutate load-time settings are errors;
configuration mistakes are never silently ignored.

### Modes

| Mode | Recommended class | Main behaviour |
|---|---|---|
| `journal` | `scrartcl` | Inline article title, publication metadata, running heads |
| `book` | `scrbook` | Book title sequence, mirrored navigation, matter helpers |
| `lecture` | `scrartcl` / `scrreprt` | Course masthead and teaching cards |
| `notes` | `scrartcl` | Compact masthead and knowledge cards |
| `beamer` | `beamer` | Projection-first frames, agenda and section slides, progress navigation |

Beamer mode uses the same metadata, themes, mathematics, and namespaced
statements as the print modes:

```latex
\documentclass[aspectratio=169]{beamer}
\usepackage[mode=beamer,theme=midnight,numbering=none]{synaptic}
\SynapticTitle{A Clear Presentation}
\SynapticInstructor{Ada Lecturer}
\begin{document}
\SynapticMakeTitle
\section{First idea}
\SynapticSectionFrame
\begin{frame}{One claim}
  \begin{syntheorem}A focused result.\end{syntheorem}
\end{frame}
\end{document}
```

`\SynapticAgendaFrame` and `\SynapticSectionFrame` provide explicit slide
navigation. With `toc=true`, `toc-layout=inline`, `top`, and `page` select an
agenda on the title frame, a regular agenda frame, or a plain agenda frame.
The standard `\titlegraphic{...}` command is typeset right-aligned in the
bottom row of the title frame (next to or instead of the `\SynapticTags`
line). Namespaced statement environments render as semantic cards: the
theorem template typesets only the amsthm-style head line inside the
surrounding tcolorbox card, so a statement is never double-carded. Native
`theorem`, `definition`, and `example` environments keep Beamer's default
block template.

### Typography

Synaptic uses one deterministic font stack so a document cannot silently
change appearance between machines.

| Script | Roman | Sans | Mono | Math / emphasis |
|---|---|---|---|---|
| Latin | Libertinus Serif | Libertinus Sans | Libertinus Mono | Libertinus Math |
| Simplified Chinese | Source Han Serif CN | Source Han Sans CN | Source Han Sans CN | LXGW WenKai emphasis |

## Public API

Every Synaptic-owned command and environment is namespaced. The package does
not redefine `abstract`, `proof`, or generic theorem environments supplied by
the document class or another package.

### Metadata and titles

| Command or environment | Purpose |
|---|---|
| `\SynapticTitle{...}` | Required title |
| `\SynapticSubtitle{...}` / `\SynapticShortTitle{...}` | Display and running titles |
| `\SynapticDate{...}` | Explicit document or lecture date |
| `\SynapticAuthor[mark]{...}` | Repeatable author and affiliation mark |
| `\SynapticAffiliation[mark]{...}` | Repeatable affiliation |
| `\SynapticEmail{...}` | Repeatable email |
| `\SynapticSubject{...}` / `\SynapticKeywords{...}` | PDF and printed metadata |
| `synabstract` | Captured abstract rendered by the mode title |
| `\SynapticMakeTitle` | Validate metadata and render the title |

Journal mode also provides `\SynapticCorrespondence`,
`\SynapticPublicationInfo`, repeatable `\SynapticAuthorNote`, and
`\SynapticStatement`. Book, lecture, notes, and Beamer metadata are demonstrated in
the bundled examples and manuals.

### Statements and proofs

The statement family is `syntheorem`, `synlemma`, `synproposition`,
`syncorollary`, `synaxiom`, `synconjecture`, `synclaim`, `synproperty`,
`synexample`, `synexercise`, `syndefinition`, `syncriterion`, `synconvention`,
`synproblem`, `synsolution`, `synremark`, `synnote`, and `synwarning`.
`synproof` provides the matching proof presentation without changing the
standard `proof` environment.

All statements share one counter. Books use chapter scope by default; shorter
modes use section scope. Hyperlink anchors include the structural parent, so
the same displayed counter value in different sections never collides.

Declare a custom statement with a namespaced environment name:

```latex
\SynapticNewTheorem[remark]{synobservation}{Observation}
```

The style is `plain`, `definition`, or `remark`. Custom names must be lowercase
alphanumeric identifiers beginning with `syn`; duplicate names are errors.

### Themes

Define an immutable custom theme, then activate it through the one runtime
configuration interface:

```latex
\SynapticDefineTheme{brand}{blue!70!black}{gray!80!black}[orange!80!black]
\SynapticSetup{theme=brand}
```

Theme identifiers are lowercase slugs and cannot replace existing themes.
Extensions can consume `syn-primary`, `syn-secondary`, `syn-accent`,
`syn-danger`, `syn-warning`, `syn-success`, `syn-surface`, and `syn-border`.

## Development and release

```bash
./scripts/verify  # regression suite, manuals, examples, diagnostic scan
l3build unpack    # extract installable modules into build/unpacked
l3build ctan      # build tested TDS and CTAN archives
l3build install   # install into the selected texmf tree
```

[`synaptic.dtx`](synaptic.dtx) is the only implementation source. Extracted
`.sty`/`.def` modules, compiled manuals, and archives are generated artifacts
and are deliberately not tracked. This removes sync drift between source,
checkout convenience copies, and release output.

To compile directly from a checkout without installing:

```bash
l3build unpack
TEXINPUTS="$PWD/build/unpacked//:" lualatex document.tex
```

## Documentation

- [English user manual source](docs/synaptic-user-en.tex)
- [中文用户手册源码](docs/synaptic-user-zh.tex)
- [English technical reference source](docs/synaptic-tech-en.tex)
- [中文技术参考源码](docs/synaptic-tech-zh.tex)
- [`synaptic.dtx`](synaptic.dtx) for the documented implementation

Run `l3build doc`; all PDFs are written under `build/doc/` and included in
release archives.

## License

LPPL 1.3c or later. See [LICENSE](LICENSE).
