## ADDED Requirements

### Requirement: Page Geometry
The system SHALL set page geometry via `geometry` based on the active `mode`, not a single hardcoded layout.

#### Scenario: Journal mode geometry
- **WHEN** `mode=journal` is active
- **THEN** margins are set to `textwidth=0.74\paperwidth, textheight=0.76\paperheight, top=0.11\paperheight, left=0.13\paperwidth`

#### Scenario: Lecture mode geometry
- **WHEN** `mode=lecture` is active
- **THEN** margins are wider (`textwidth` ≈ 0.70–0.72 paperwidth) with larger head/foot separation

#### Scenario: Book mode geometry
- **WHEN** `mode=book` is active
- **THEN** geometry uses `BCOR`-aware binding correction and `DIV=calc` from KOMA-Script

---

### Requirement: Paragraph Typography
The system SHALL apply micro-typographic settings for academic text.

#### Scenario: Default paragraph settings
- **WHEN** the package is loaded
- **THEN** `\parindent` is 2em, `\parskip` is `0pt plus 1pt`
- **AND** `\widowpenalty` and `\clubpenalty` are set to 10000

#### Scenario: Fine-breaking enabled
- **WHEN** `fine-breaking=true`
- **THEN** `\emergencystretch=4em`, `\tolerance=4000`, `\raggedbottom` is active

#### Scenario: Fine-breaking disabled
- **WHEN** `fine-breaking=false`
- **THEN** the above overrides are not applied, using document defaults

---

### Requirement: Line Spacing
The system SHALL set `\setstretch{1.25}` as the default baseline stretch.

---

## MODIFIED Requirements

### Requirement: microtype Configuration
The system SHALL load `microtype` with protrusion enabled for English text and disabled for CJK text.

#### Scenario: English mode
- **WHEN** `lang=en` (default)
- **THEN** microtype is loaded with `protrusion=true, expansion=false`

#### Scenario: Chinese mode
- **WHEN** `lang=zh`
- **THEN** microtype is loaded with `protrusion=false, expansion=false` to avoid CJK rendering issues
