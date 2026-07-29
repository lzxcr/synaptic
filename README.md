<p align="center">
  <a href="https://www.latex-project.org/"><img src="https://img.shields.io/badge/LaTeX-3-008080?style=for-the-badge&logo=latex" alt="LaTeX3"></a>
  <a href="https://www.luatex.org/"><img src="https://img.shields.io/badge/Engine-LuaLaTeX-blue?style=for-the-badge&logo=lua" alt="LuaLaTeX"></a>
  <a href="https://ctan.org/pkg/koma-script"><img src="https://img.shields.io/badge/Class-KOMA--Script-orange?style=for-the-badge" alt="KOMA-Script"></a>
  <a href="https://www.latex-project.org/lppl/"><img src="https://img.shields.io/badge/License-LPPL%201.3c-lightgrey?style=for-the-badge" alt="License"></a>
</p>

<h1 align="center">
  synaptic<br>
  <sup><i>Modern Academic Typesetting Framework</i></sup>
</h1>

**synaptic** is a modular LaTeX3 design system for academic articles, books,
lecture notes, and technical reports. It requires **LuaLaTeX** with a
**KOMA‑Script** document class.

> _Like a biological synapse, this framework connects your ideas, formulas, and
> layout into a seamless, beautiful network._

---

## Installation

### Quick start (no install)

```bash
git clone https://github.com/lzxcr/synaptic
export TEXINPUTS=/path/to/synaptic/tex/latex/synaptic//:$TEXINPUTS
```

### l3build install

```bash
cd synaptic
lualatex tex/latex/synaptic/synaptic.ins   # extract .sty files
l3build install                             # install to TEXMFHOME
```

### User document

```latex
\documentclass{scrartcl}
\usepackage[mode=journal, theme=ocean]{synaptic}

\SynapticTitle{A Note on Algebraic Geometry}
\SynapticAuthor{Alice Smith}
\SynapticAffiliation{University of Example}
\SynapticEmail{alice@example.com}
\SynapticKeywords{algebraic geometry}

\begin{abstract}This paper discusses...\end{abstract}

\begin{document}
\SynapticMakeTitle
\section{Introduction}
\begin{theorem}[Main Result] ... \end{theorem}
\end{document}
```

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
| `ocean` | Blue (0,106,176) | Dark blue-grey (46,64,83) |
| `graphite` | Grey (75,86,99) | Dark grey (45,52,62) |
| `forest` | Green (30,115,80) | Dark green (56,68,60) |
| `midnight` | Navy (25,55,109) | Deep dark (30,35,50) |
| `paper` | Dark grey (55,58,62) | Near-black (45,48,52) |

### Font sets

| fontset | Roman | Sans | Math |
|---------|-------|------|------|
| `auto` | Auto-detect | Auto-detect | Auto-detect |
| `xcharter` | XCharter | Cabin | XCharter Math |
| `libertinus` | Libertinus Serif | Libertinus Sans | Libertinus Math |
| `stix2` | STIX Two Text | STIX Two Text | STIX Two Math |
| `lm` | Latin Modern | Latin Modern Sans | Latin Modern Math |

---

## user API

### Metadata commands

| Command | Purpose |
|---------|---------|
| `\SynapticTitle{...}` | Document title |
| `\SynapticAuthor[mark]{name}` | Author with optional affil mark |
| `\SynapticAffiliation[mark]{...}` | Affiliation |
| `\SynapticEmail{...}` | Email address |
| `\SynapticKeywords{...}` | Keywords |
| `\SynapticArxiv{ID}` | arXiv link |
| `\SynapticMakeTitle` | Render title page |
| `\SynapticSetup{key=val}` | Runtime option changes |

### Customisation

| Command | Purpose |
|---------|---------|
| `\SynapticNewTheorem{env}{Name}` | Declare theorem environment |
| `\SynapticDefineTheme{primary}{secondary}` | Custom colour theme |
| `\SynapticHeader{...}` | Custom submission header |
| `\SynapticSubHeader{...}` | Sub-header |
| `\SynapticPreprint{...}` | Preprint ID |
| `\SynapticDedicated{...}` | Dedication |

### Environments

`abstract`, `theorem`, `lemma`, `proposition`, `definition`, `proof` (always available).

`example`, `remark`, `warning`, `exercise`, `synbox` (lecture mode).

---

## Project structure

```
synaptic/
├── synaptic.dtx                    Single-file DocStrip source
├── CHANGELOG.md
├── README.md
├── LICENSE
├── .gitignore
│
├── tex/latex/synaptic/             Installed package files
│   ├── synaptic.sty                Thin shell (RequirePackageWithOptions → base)
│   ├── synaptic-base.sty           Engine check, options, dispatching
│   ├── synaptic-color.sty          Theme colour system
│   ├── synaptic-fonts.sty          Fontset + CJK support
│   │   └── synaptic-fonts.lua      Lua auto-detection
│   ├── synaptic-layout.sty         Geometry, microtype, headings
│   ├── synaptic-title.sty          Title page (journal)
│   ├── synaptic-theorem.sty        Theorem/proof environments
│   ├── synaptic-book.sty           Book mode
│   ├── synaptic-lecture.sty        Lecture mode
│   ├── synaptic-boxes.sty          tcolorbox environments
│   ├── synaptic-lang-en.def        English labels
│   ├── synaptic-lang-zh.def        Chinese labels
│   ├── synaptic.ins                DocStrip installation
│   └── l3build.lua                 Build script
│
├── srcs/                           Manual source files
│   ├── synaptic-user-en.tex
│   ├── synaptic-user-zh.tex
│   ├── synaptic-tech-en.tex
│   └── synaptic-tech-zh.tex
│
├── docs/                           Compiled manuals
│   ├── synaptic-user-en.pdf
│   ├── synaptic-user-zh.pdf
│   ├── synaptic-tech-en.pdf
│   └── synaptic-tech-zh.pdf
│
└── openspec/                       Specifications
    └── changes/
        ├── refactor-v2/
        └── cleanup-v2/
```

---

## Documentation

- [User Manual (English)](docs/synaptic-user-en.pdf)
- [User Manual (Chinese)](docs/synaptic-user-zh.pdf)
- [Technical Reference (English)](docs/synaptic-tech-en.pdf)
- [Technical Reference (Chinese)](docs/synaptic-tech-zh.pdf)
- [DTX compiled doc](synaptic.dtx) — Run `lualatex synaptic.dtx`

---

## License

LPPL 1.3c or later. See [LICENSE](LICENSE).

---

## Links

- [GitHub](https://github.com/lzxcr/synaptic)
