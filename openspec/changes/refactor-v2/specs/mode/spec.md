## ADDED Requirements

### Requirement: Mode Selection
The system SHALL support `mode=` as the primary user-facing option controlling document type, replacing the legacy `style=` option.

#### Scenario: Journal mode (default)
- **WHEN** `mode=journal` (or no mode specified)
- **THEN** the system loads `synaptic-title.sty` with submission header
- **AND** geometry is set for single-column A4 academic paper
- **AND** abstract/keywords/arXiv fields are available

#### Scenario: Book mode
- **WHEN** `mode=book`
- **THEN** the system requires `scrbook` document class
- **AND** loads `synaptic-book.sty` which styles `\chapter`, `\frontmatter`, `\mainmatter`, `\backmatter`
- **AND** running headers display chapter/section titles
- **AND** `\SynapticMakeTitle` produces a book title page (not a journal submission header)

#### Scenario: Lecture mode
- **WHEN** `mode=lecture`
- **THEN** the system loads `synaptic-lecture.sty`
- **AND** page margins are wider for note-taking
- **AND** section headings are larger and more prominent
- **AND** `{example}`, `{exercise}`, `{remark}` environments are enabled
- **AND** theorems use colored box styling

#### Scenario: Notes mode
- **WHEN** `mode=notes`
- **THEN** the system uses minimal styling
- **AND** geometry is compact
- **AND** no title page infrastructure is loaded
- **AND** fonts default to Latin Modern (fastest compilation)

---

### Requirement: Mode-Aware Module Loading
The system SHALL load only the modules relevant to the active mode.

#### Scenario: Journal mode module set
- **WHEN** `mode=journal`
- **THEN** loaded modules: `synaptic-base`, `synaptic-fonts`, `synaptic-color`, `synaptic-layout`, `synaptic-title`, `synaptic-theorem`

#### Scenario: Book mode module set
- **WHEN** `mode=book`
- **THEN** loaded modules: all of journal + `synaptic-book`

#### Scenario: Lecture mode module set
- **WHEN** `mode=lecture`
- **THEN** loaded modules: all of journal + `synaptic-lecture` + `synaptic-boxes`

---

### Requirement: Legacy Style Option Removal
The system SHALL remove the `style=modern/minimal` option. `style=minimal` behavior is subsumed by `mode=notes`.

#### Scenario: User specifies style option
- **WHEN** `\usepackage[style=modern]{synaptic}` is used
- **THEN** a warning is emitted: "Option `style` is deprecated; use `mode=journal` instead"
- **AND** the package loads with `mode=journal`
