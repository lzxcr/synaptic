# Changelog

## [2.0.0] — 2026-06-05

### Major restructuring
- Complete modular refactoring: single `synaptic.sty` → 10+ modules
- Introduced `mode=` system: `journal`, `book`, `lecture`, `notes`
- Introduced `theme=` system: `ocean`, `graphite`, `forest`, `midnight`, `paper`
- Introduced `fontset=` system: `xcharter`, `libertinus`, `stix2`, `lm`, `auto`
- Introduced Lua font detection (`synaptic-fonts.lua`)

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
- Lua font auto-detection engine
- `\DocumentMetadata` support (PDF/A, tagging)

### Fixed
- No longer redefines `\title`/`\author`/`\maketitle` (avoids conflicts)
- `lang=zh` loads CJK fonts only when explicitly requested
- Module separation prevents cross-contamination of settings
