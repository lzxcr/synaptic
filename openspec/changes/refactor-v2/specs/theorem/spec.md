## MODIFIED Requirements

### Requirement: Theorem Environments
The system SHALL provide pre-defined theorem environments (theorem, lemma, proposition, definition) with `thmtools` and `amsthm`, using the active theme's styling.

#### Scenario: Theorem with optional name
- **WHEN** `\begin{theorem}[Main Result] ... \end{theorem}` is written
- **THEN** the theorem is numbered by section, with head styled per active theme
- **AND** the optional name appears as a parenthetical note

#### Scenario: Shared counter
- **WHEN** `lemma` and `proposition` environments are used
- **THEN** they share the same counter as `theorem`

#### Scenario: Theme-aware styling
- **WHEN** `theme=ocean` is active
- **THEN** theorem heads are colored with the theme primary color
- **WHEN** `theme=forest` is active
- **THEN** theorem heads use the forest primary color

---

### Requirement: Proof Environment
The system SHALL provide a `proof` environment with a configurable QED symbol and localized heading.

#### Scenario: English proof
- **WHEN** `lang=en` and `\begin{proof}...\end{proof}` is written
- **THEN** "Proof." is displayed as the heading, followed by the proof body
- **AND** a small black square `\rule[0.05em]{0.5em}{0.5em}` appears at the end

#### Scenario: Chinese proof
- **WHEN** `lang=zh` and `\begin{proof}...\end{proof}` is written
- **THEN** "证明." is displayed as the heading

#### Scenario: Custom proof name
- **WHEN** `\begin{proof}[Sketch]...\end{proof}` is written
- **THEN** "Sketch." is displayed as the heading

---

### Requirement: Custom Theorem Declaration
The system SHALL allow users to declare additional theorem-like environments sharing the same styling.

#### Scenario: Custom theorem
- **WHEN** `\SynapticNewTheorem{corollary}{Corollary}` is called
- **THEN** a new `corollary` environment is created, sharing the theorem counter and theme style

---

## ADDED Requirements

### Requirement: Theorem Style Variants
The system SHALL support multiple theorem presentation styles selectable by mode or explicit option.

#### Scenario: Academic style (journal mode)
- **WHEN** `mode=journal`
- **THEN** theorems use italic body text with bold colored heading

#### Scenario: Lecture style
- **WHEN** `mode=lecture`
- **THEN** theorems are rendered in `tcolorbox` frames with colored left border

#### Scenario: Book style
- **WHEN** `mode=book`
- **THEN** theorems use a horizontal rule above the heading for visual separation
