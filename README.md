<p align="center">
  <a href="https://www.latex-project.org/"><img src="https://img.shields.io/badge/LaTeX-3-008080?style=for-the-badge&logo=latex" alt="LaTeX3"></a>
  <a href="https://www.luatex.org/"><img src="https://img.shields.io/badge/Engine-LuaLaTeX-blue?style=for-the-badge&logo=lua" alt="LuaLaTeX"></a>
  <a href="https://ctan.org/pkg/koma-script"><img src="https://img.shields.io/badge/Class-KOMA--Script-orange?style=for-the-badge" alt="KOMA-Script"></a>
  <a href="https://www.latex-project.org/lppl/"><img src="https://img.shields.io/badge/License-LPPL%201.3c-lightgrey?style=for-the-badge" alt="License"></a>
</p>

<h1 align="center">
  synaptic — Modern Academic Typesetting Framework
</h1>

<p align="center">
  <i>Like a biological synapse, this framework connects your ideas, formulas, and
  layout into a seamless, beautiful network.</i>
</p>

**synaptic** is a modular LaTeX3 design system for academic articles, books,
lecture notes, and technical reports. It requires **LuaLaTeX** with a
**KOMA‑Script** document class.

---

## Installation

### Quick start (no install, TEXINPUTS)

```bash
git clone https://github.com/lzxcr/synaptic
export TEXINPUTS=/path/to/synaptic/tex/latex/synaptic//:$TEXINPUTS
lualatex your-document.tex
```

### l3build (system-wide install)

```bash
cd synaptic
lualatex synaptic.ins        # extract .sty files from .dtx
l3build install               # install to TEXMFHOME
```

### Verification

```latex
% minimal.tex — test your installation
\documentclass{scrartcl}
\usepackage[mode=journal, theme=ocean]{synaptic}
\SynapticTitle{Test}
\SynapticAuthor{You}
\begin{document}
\SynapticMakeTitle
\section{Hello}
\begin{theorem} It works! \end{theorem}
\end{document}
```

Compile with `lualatex minimal.tex`.

---

## Options

| Key | Type | Default | Choices |
|-----|------|---------|---------|
| `mode` | choice | `journal` | `journal`, `book`, `lecture`, `notes` |
| `theme` | choice | `ocean` | `ocean`, `graphite`, `forest`, `midnight`, `paper` |
| `lang` | choice | `en` | `en`, `zh` |
| `fontset` | choice | `auto` | `auto`, `xcharter`, `libertinus`, `stix2`, `lm` |
| `toc` | bool | `true` | — |
| `toc-layout` | choice | `top` | `top`, `inline`, `page` |
| `extra-math` | bool | `false` | — |
| `fine-breaking` | bool | `true` | — |

### Mode descriptions

| mode | Document class | Features |
|------|---------------|----------|
| `journal` | scrartcl | Submission header, abstract, keywords, arXiv |
| `book` | scrbook | Chapter headings, running headers, front/back matter |
| `lecture` | scrartcl / scrreprt | Wide margins, large headings, tcolorbox environments |
| `notes` | scrartcl | Compact layout, minimal extras |

### Theme colours

| Theme | Primary | Secondary |
|-------|---------|-----------|
| `ocean` | `RGB(0,106,176)` blue | `RGB(46,64,83)` dark blue-grey |
| `graphite` | `RGB(75,86,99)` grey | `RGB(45,52,62)` dark grey |
| `forest` | `RGB(30,115,80)` green | `RGB(56,68,60)` dark green |
| `midnight` | `RGB(25,55,109)` navy | `RGB(30,35,50)` deep dark |
| `paper` | `RGB(55,58,62)` dark grey | `RGB(45,48,52)` near-black |

Custom themes: `\SynapticDefineTheme{name}{primary}{secondary}`.

### Font sets

| fontset | Roman | Sans | Monospace | Math |
|---------|-------|------|-----------|------|
| `auto` | Auto-detect | Auto-detect | Auto-detect | Auto-detect |
| `xcharter` | XCharter | Cabin | Inconsolata | XCharter Math |
| `libertinus` | Libertinus Serif | Libertinus Sans | Libertinus Mono | Libertinus Math |
| `stix2` | STIX Two Text | STIX Two Text | STIX Two Text | STIX Two Math |
| `lm` | Latin Modern | Latin Modern Sans | Latin Modern Mono | Latin Modern Math |

---

## User API

### Metadata

| Command | Purpose |
|---------|---------|
| `\SynapticTitle{...}` | Document title |
| `\SynapticAuthor[mark]{name}` | Author with optional affiliation mark |
| `\SynapticAffiliation[mark]{...}` | Affiliation |
| `\SynapticEmail{...}` | Email address |
| `\SynapticKeywords{...}` | Keywords |
| `\SynapticArxiv{ID}` | arXiv link |
| `\SynapticMakeTitle` | Render title page |
| `\SynapticSetup{key=val}` | Change options at runtime |

### Customisation

| Command | Purpose |
|---------|---------|
| `\SynapticNewTheorem{env}{Name}` | Declare theorem-like environment |
| `\SynapticDefineTheme{primary}{secondary}` | Custom colour theme |
| `\SynapticHeader{...}` | Submission header override |
| `\SynapticSubHeader{...}` | Sub-header |
| `\SynapticPreprint{...}` | Preprint identifier |
| `\SynapticDedicated{...}` | Dedication text |

### Environments

**Always available:**
`abstract`, `theorem`, `lemma`, `proposition`, `definition`, `proof`

**Lecture mode only (`mode=lecture`):**
`example`, `remark`, `warning`, `exercise`, `synbox` (tcolorbox-based)

---

## Project structure

```
synaptic/
├── synaptic.dtx              DocStrip source (all modules)
├── synaptic.ins              Extraction script
├── build.lua                 l3build configuration
├── README.md
├── CHANGELOG.md
├── LICENSE
├── .gitignore
│
├── tex/latex/synaptic/        Package files (installed)
│   ├── synaptic.sty           Thin shell: loads modules by mode
│   ├── synaptic-base.sty      Engine check, options, dispatching
│   ├── synaptic-color.sty     Theme colour system (5 themes)
│   ├── synaptic-fonts.sty     Fontset selection + CJK
│   │   └── synaptic-fonts.lua Lua font auto-detection
│   ├── synaptic-layout.sty    Page geometry, microtype, headings
│   ├── synaptic-title.sty     Title page (journal mode)
│   ├── synaptic-theorem.sty   Theorem / proof environments
│   ├── synaptic-book.sty      Book mode (chapter, headers)
│   ├── synaptic-lecture.sty   Lecture mode (wide margins)
│   ├── synaptic-boxes.sty     tcolorbox environments
│   ├── synaptic-lang-en.def   English labels
│   ├── synaptic-lang-zh.def   Chinese labels
│   └── synaptic.ins           Per-directory extraction
│
├── srcs/                      Manual source files
│   ├── synaptic-user-en.tex
│   ├── synaptic-user-zh.tex
│   ├── synaptic-tech-en.tex
│   └── synaptic-tech-zh.tex
│
└── docs/                      Compiled PDF manuals
    ├── synaptic-user-en.pdf
    ├── synaptic-user-zh.pdf
    ├── synaptic-tech-en.pdf
    └── synaptic-tech-zh.pdf
```

---

## Module architecture

```
synaptic.sty
  └── synaptic-base.sty            (RequirePackageWithOptions)
        ├── synaptic-color.sty     theme colour definitions
        ├── synaptic-fonts.sty     font loading + Lua detection
        ├── synaptic-layout.sty    geometry, microtype, KOMA headings
        ├── synaptic-theorem.sty   thmtools + amsthm
        │
        ├── synaptic-title.sty     [mode=journal]  title page
        ├── synaptic-book.sty      [mode=book]     chapter + headers
        ├── synaptic-lecture.sty   [mode=lecture]  wide margins
        └── synaptic-boxes.sty     [mode=lecture]  tcolorbox
```

Each mode loads a different subset:

| `mode=` | Loads |
|---------|-------|
| `journal` | base + color + fonts + layout + theorem + title |
| `book`    | journal + book |
| `lecture` | base + color + fonts + layout + theorem + lecture + boxes |
| `notes`   | base + color + fonts + layout + theorem |

---

## Documentation

- [User Manual (English)](docs/synaptic-user-en.pdf) — options, API, examples
- [User Manual (Chinese)](docs/synaptic-user-zh.pdf) — 同上（中文版）
- [Technical Reference (English)](docs/synaptic-tech-en.pdf) — architecture, extension
- [Technical Reference (Chinese)](docs/synaptic-tech-zh.pdf) — 同上（中文版）
- `lualatex synaptic.dtx` — compile the documented source (35-page dev doc)

---

## License

LPPL 1.3c or later. See [LICENSE](LICENSE).

---

## Links

- GitHub: <https://github.com/lzxcr/synaptic>
