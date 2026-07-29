## ADDED Requirements

### Requirement: Theme Selection
The system SHALL support selecting a visual theme via the `theme=` package option.

#### Scenario: Default theme
- **WHEN** no `theme=` option is given
- **THEN** `theme=ocean` is used as default

#### Scenario: Named theme
- **WHEN** `theme=graphite` is specified
- **THEN** the graphite color palette and associated heading/theorem styles are applied

#### Scenario: Unknown theme
- **WHEN** an unrecognized theme name is given
- **THEN** a `PackageWarning` is emitted and `ocean` is used as fallback

---

### Requirement: Theme Color Palette
Each theme SHALL define at minimum `syn.primary`, `syn.secondary`, and derived tints.

#### Scenario: Ocean theme colors
- **WHEN** `theme=ocean` is active
- **THEN** `syn.primary` is RGB(0,106,176) and `syn.secondary` is RGB(46,64,83)

---

### Requirement: Theme File Architecture
Themes SHALL be defined in standalone `.def` files under `tex/latex/synaptic/themes/`.

#### Scenario: Theme file exists
- **WHEN** `theme=forest` is selected
- **THEN** the file `synaptic-theme-forest.def` is loaded

---

### Requirement: Backward Compatible color=
The old `color=` option SHALL continue to work but emit a deprecation warning.

#### Scenario: Old API
- **WHEN** `color=teal` is used instead of `theme=teal`
- **THEN** a `PackageWarning` says "color= is deprecated, use theme=" and maps to the equivalent theme

---

### Requirement: Color API via l3color
Colors SHALL be defined using the LaTeX kernel `l3color` module when available, falling back to `xcolor`.

#### Scenario: l3color available
- **WHEN** the LaTeX kernel provides `\color_set:nn`
- **THEN** colors are defined via `\color_set:nn { syn.primary } { rgb }{ 0,0.416,0.690 }`
