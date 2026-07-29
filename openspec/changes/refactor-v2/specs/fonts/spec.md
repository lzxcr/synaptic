## ADDED Requirements

### Requirement: Fontset Selection
The system SHALL support a `fontset=` option with values `xcharter`, `libertinus`, `stix2`, `lm`, and `auto`.

#### Scenario: Explicit fontset
- **WHEN** the user specifies `fontset=xcharter`
- **THEN** XCharter is loaded as the main roman font, with Cabin sans and Inconsolata mono
- **AND** XCharter Math is loaded for unicode-math

#### Scenario: Auto fontset
- **WHEN** the user specifies `fontset=auto` (or omits the option, defaulting to `auto`)
- **THEN** the system SHALL detect available fonts via Lua in priority order: XCharter → Libertinus → STIX Two → Latin Modern
- **AND** the first available fontset is selected

#### Scenario: Fontset not available
- **WHEN** a specified fontset's fonts are not found on the system
- **THEN** a `PackageWarning` is emitted
- **AND** the system falls back to Latin Modern

---

### Requirement: Font Fallback Chain
For each font role (roman, sans, mono, math, CJK), the system SHALL maintain an ordered list of fallback fonts.

#### Scenario: XCharter roman not found
- **WHEN** `fontset=xcharter` is specified but XCharter is not installed
- **THEN** the system SHALL emit a warning and load Latin Modern Roman
- **AND** all other roles (sans/mono) independently fall back

#### Scenario: CJK font not found
- **WHEN** `lang=zh` but no CJK main font is found
- **THEN** the system SHALL emit a fatal `PackageError` with a message listing required CJK fonts

---

### Requirement: Lua Font Detection
The system SHALL use a Lua module (`synaptic-fonts.lua`) for font availability detection.

#### Scenario: Font exists
- **WHEN** the Lua function `synaptic.fonts.exists("XCharter-Roman.otf")` is called
- **THEN** it SHALL return `true` if the font is found in the system's font paths

#### Scenario: Font metadata
- **WHEN** the Lua function `synaptic.fonts.metadata("XCharter-Roman.otf")` is called
- **THEN** it SHALL return a Lua table with the font's family name, weight, and optical size information

---

### Requirement: No Hardcoded Filenames
Font loading SHALL use font family names (e.g. `XCharter`) rather than raw OTF filenames (e.g. `XCharter-Roman.otf`) wherever `fontspec` supports it.

#### Scenario: Loading XCharter
- **WHEN** `fontset=xcharter` is active
- **THEN** `\setmainfont{XCharter}` is used, not `\setmainfont{XCharter-Roman.otf}`

---

## MODIFIED Requirements

### Requirement: CJK Font Loading (via `lang=zh`)
CJK font loading SHALL be triggered by `lang=zh` (which also sets Chinese labels).

#### Scenario: Chinese enabled
- **WHEN** `lang=zh` is set
- **THEN** CJK fonts (Noto Serif CJK SC → FandolSong fallback) are configured
- **AND** `ctex` is loaded with `heading=false, fontset=none, scheme=plain`

#### Scenario: Chinese disabled
- **WHEN** `lang=en` (default)
- **THEN** no CJK fonts are configured and `ctex` is not loaded
