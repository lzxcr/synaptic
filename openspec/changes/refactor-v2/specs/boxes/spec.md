## ADDED Requirements

### Requirement: tcolorbox-Based Environments
The system SHALL provide `tcolorbox`-powered environments for visual content: `{example}`, `{remark}`, `{warning}`, and a generic `{synbox}`.

#### Scenario: Example environment
- **WHEN** `\begin{example}[Optional Title] ... \end{example}` is written
- **THEN** content is rendered in a `tcolorbox` with theme-colored left border
- **AND** "Example" (or localized equivalent) appears as the heading

#### Scenario: Remark environment
- **WHEN** `\begin{remark} ... \end{remark}` is written
- **THEN** content is rendered with a gray left border and italic body

#### Scenario: Warning environment
- **WHEN** `\begin{warning} ... \end{warning}` is written
- **THEN** content is rendered with a red/amber left border

#### Scenario: Generic synbox
- **WHEN** `\begin{synbox}[title=Note, color=blue] ... \end{synbox}` is written
- **THEN** content is rendered in a customizable `tcolorbox` with the given title and color

---

### Requirement: Mode-Dependent Box Loading
The system SHALL load `synaptic-boxes.sty` only when the active mode benefits from visual boxes.

#### Scenario: Lecture mode
- **WHEN** `mode=lecture`
- **THEN** `synaptic-boxes.sty` is loaded and all box environments are available

#### Scenario: Journal mode
- **WHEN** `mode=journal`
- **THEN** `synaptic-boxes.sty` is NOT loaded by default (to keep the output minimal)
- **AND** the user may explicitly load it with `\usepackage{synaptic-boxes}`

---

### Requirement: Exercise Environment (Lecture Mode)
The system SHALL provide an `{exercise}` environment in lecture mode.

#### Scenario: Exercise with numbering
- **WHEN** `mode=lecture` and `\begin{exercise} ... \end{exercise}` is written
- **THEN** the exercise is numbered by section and rendered in a colored box
