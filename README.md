<p align="center">
  <a href="https://www.latex-project.org/"><img src="https://img.shields.io/badge/LaTeX-3-008080?style=flat-square&logo=latex" alt="LaTeX3"></a>
  <a href="https://www.luatex.org/"><img src="https://img.shields.io/badge/engine-LuaLaTeX-2c5aa0?style=flat-square" alt="LuaLaTeX"></a>
  <a href="https://www.latex-project.org/lppl/"><img src="https://img.shields.io/badge/license-LPPL%201.3c-lightgrey?style=flat-square" alt="LPPL 1.3c"></a>
</p>

<h1 align="center">synaptic</h1>

<p align="center">A modular LaTeX3 design system for academic articles, books, lectures, and notes.</p>

`synaptic` provides mode-aware layouts, Unicode mathematics, bilingual labels,
semantic colour tokens, and a fully namespaced public API. It requires
LuaLaTeX, a recent LaTeX format, and a KOMA-Script document class.

## Quick start

Install the package from the repository root:

```bash
l3build install
```

Then compile a KOMA-Script document with LuaLaTeX:

```latex
\documentclass[11pt]{scrartcl}
\usepackage[mode=journal,theme=ocean,fontset=auto]{synaptic}

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
- A KOMA-Script class. Use `scrbook` for `mode=book`; the other modes
  normally use `scrartcl` or `scrreprt`.
- A recent TeX distribution containing `expl3`, `fontspec`, `unicode-math`,
  `geometry`, `microtype`, `thmtools`, `tcolorbox`, and PGF.
- `ctex` and either Noto CJK SC or Fandol for `lang=zh`.

The package respects the paper size selected by the class and never forces A4.

## Configuration

| Key | Default | Values | Runtime? |
|---|---:|---|:---:|
| `mode` | `journal` | `journal`, `book`, `lecture`, `notes` | No |
| `theme` | `ocean` | `ocean`, `graphite`, `forest`, `midnight`, `paper` | Yes |
| `lang` | `en` | `en`, `zh` | No |
| `fontset` | `auto` | `auto`, `xcharter`, `libertinus`, `stix2`, `lm` | No |
| `toc` | `false` | Boolean | Yes |
| `toc-layout` | `top` | `top`, `inline`, `page` | Yes |
| `title-layout` | `auto` | `auto`, `inline`, `compact`, `page`, `sequence` | No |
| `numbering` | `auto` | `auto`, `section`, `chapter`, `continuous`, `none` | No |
| `color-mode` | `screen` | `screen`, `print`, `mono` | No |
| `density` | `balanced` | `compact`, `balanced`, `airy` | No |
| `measure` | `auto` | `auto`, `narrow`, `standard`, `wide` | No |
| `theorem-style` | `boxed` | `boxed`, `plain` | No |
| `binding-offset` | `0pt` | Any dimension | No |

Only `theme`, `toc`, and `toc-layout` change after loading:

```latex
\SynapticSetup{theme=paper,toc=false,toc-layout=page}
```

Unknown package options and attempts to mutate load-time settings are errors;
configuration mistakes are never silently ignored.

### Modes

| Mode | Recommended class | Main behaviour |
|---|---|---|
| `journal` | `scrartcl` | Inline article title, publication metadata, running heads |
| `book` | `scrbook` | Book title sequence, mirrored navigation, matter helpers |
| `lecture` | `scrartcl` / `scrreprt` | Course masthead and teaching cards |
| `notes` | `scrartcl` | Compact masthead and knowledge cards |

### Font sets

`auto` selects the first complete installed bundle in this order: XCharter,
Libertinus, STIX Two, then Latin Modern. Explicit font-set requests fail when
any required companion is missing.

| Set | Roman | Sans | Mono | Math |
|---|---|---|---|---|
| `xcharter` | XCharter | Cabin | Inconsolatazi4 | XCharter Math |
| `libertinus` | Libertinus Serif | Libertinus Sans | Libertinus Mono | Libertinus Math |
| `stix2` | STIX Two Text | TeX Gyre Heros | Latin Modern Mono | STIX Two Math |
| `lm` | Latin Modern Roman | Latin Modern Sans | Latin Modern Mono | Latin Modern Math |

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
`\SynapticStatement`. Book, lecture, and notes metadata are demonstrated in
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
