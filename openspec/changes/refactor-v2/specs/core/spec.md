## ADDED Requirements

### Requirement: Engine Check
The system SHALL require LuaLaTeX as the sole supported engine and emit a fatal error otherwise.

#### Scenario: LuaLaTeX detected
- **WHEN** the package is loaded under LuaLaTeX
- **THEN** no error is emitted and loading proceeds normally

#### Scenario: Non-LuaLaTeX engine
- **WHEN** the package is loaded under pdfLaTeX, XeLaTeX, or any non-Lua engine
- **THEN** a fatal `PackageError` is raised with message "LuaLaTeX required"

---

### Requirement: KOMA-Script Detection
The system SHALL detect the presence of a KOMA-Script document class and emit a fatal error if absent.

#### Scenario: scrartcl loaded
- **WHEN** `\documentclass{scrartcl}` (or `scrreprt`/`scrbook`) is used
- **THEN** `\KOMAoptions` is defined and loading proceeds normally

#### Scenario: Standard class loaded
- **WHEN** `\documentclass{article}` or `\documentclass{book}` (standard classes) is used
- **THEN** a fatal `PackageError` is raised with message "KOMA-Script document class required"

---

### Requirement: Key-Value Option Parsing
The system SHALL accept all user options via `\usepackage[key=value]{synaptic}` using LaTeX kernel's `\ProcessKeyOptions`.

#### Scenario: Valid option passed
- **WHEN** the user writes `\usepackage[mode=journal, theme=ocean, lang=en]{synaptic}`
- **THEN** each option is parsed and stored in its corresponding internal variable

#### Scenario: Unknown option passed
- **WHEN** the user passes an unrecognized key
- **THEN** the option is silently ignored (no error)

---

### Requirement: Module Auto-Loading
The system SHALL automatically load sub-modules based on the `mode=` option value.

#### Scenario: journal mode
- **WHEN** `mode=journal` is set
- **THEN** `synaptic-base`, `synaptic-fonts`, `synaptic-color`, `synaptic-layout`, `synaptic-title`, `synaptic-theorem` are loaded

#### Scenario: book mode
- **WHEN** `mode=book` is set
- **THEN** `synaptic-base`, `synaptic-fonts`, `synaptic-color`, `synaptic-layout`, `synaptic-book`, `synaptic-theorem` are loaded

#### Scenario: lecture mode
- **WHEN** `mode=lecture` is set
- **THEN** `synaptic-base`, `synaptic-fonts`, `synaptic-color`, `synaptic-layout`, `synaptic-lecture`, `synaptic-theorem`, `synaptic-boxes` are loaded

---

### Requirement: Namespace Discipline
The system SHALL strictly separate public API from internal implementation using LaTeX3 naming conventions.

#### Scenario: Public command
- **WHEN** a user-facing command is defined
- **THEN** its name SHALL follow `\Synaptic<Name>` pattern (e.g., `\SynapticTitle`, `\SynapticSetup`)

#### Scenario: Internal command
- **WHEN** an internal implementation function is defined
- **THEN** its name SHALL use `\__synaptic_<module>_<name>:<argspec>` pattern

#### Scenario: Internal variable
- **WHEN** an internal variable is declared
- **THEN** its name SHALL use `\(l|g)__synaptic_<module>_<name>_<type>` pattern

---

### MODIFIED Requirements

### Requirement: Options Loading (was "Options")
The system SHALL parse options via `\ProcessKeyOptions` and support the following keys:

| Key | Type | Default | Choices |
|-----|------|---------|---------|
| `mode` | tl | `journal` | `journal`, `book`, `lecture`, `notes` |
| `theme` | tl | `ocean` | `ocean`, `graphite`, `forest`, `midnight`, `paper` |
| `lang` | tl | `en` | `en`, `zh`, `ja`, `fr`, `de` |
| `fontset` | tl | `auto` | `auto`, `xcharter`, `libertinus`, `stix2`, `lm` |
| `toc` | bool | `true` | `true`, `false` |
| `toc-layout` | tl | `top` | `top`, `inline`, `page` |
| `extra-math` | bool | `false` | `true`, `false` |
| `fine-breaking` | bool | `true` | `true`, `false` |

The keys `color` and `style` are REMOVED (replaced by `theme` and `mode` respectively).

---

## REMOVED Requirements

### Requirement: color option
The `color=ocean/teal/carbon` option is removed. Replaced by `theme=` which encompasses color + style.

### Requirement: style option
The `style=modern/minimal` option is removed. Replaced by `mode=` which controls page geometry and module loading.
