## MODIFIED Requirements

### Requirement: Title Page API
The system SHALL provide a non-invasive title page API using `\SynapticTitle`, `\SynapticAuthor`, `\SynapticAffiliation`, `\SynapticEmail`, and `\SynapticMakeTitle` — without redefining `\title` or `\author`.

#### Scenario: Basic title page (journal mode)
- **WHEN** the user writes `\SynapticTitle{...}`, `\SynapticAuthor{...}`, and calls `\SynapticMakeTitle`
- **THEN** a title page is rendered with header, title, author block, affiliation list, emails

#### Scenario: Abstract rendering
- **WHEN** `\begin{abstract}...\end{abstract}` is used
- **THEN** the abstract content is collected and rendered within `\SynapticMakeTitle`

#### Scenario: Keywords and arXiv
- **WHEN** `\SynapticKeywords{...}` and `\SynapticArxiv{...}` are specified
- **THEN** both are rendered below the abstract on the title page

#### Scenario: Submission header customization
- **WHEN** `\SynapticHeader{...}` is specified
- **THEN** the custom header replaces the default "Prepared for submission to journal"

---
## ADDED Requirements

### Requirement: Author Object
The system SHALL support structured author metadata including name, affiliation reference, ORCID, and email.

#### Scenario: Author with affiliation reference
- **WHEN** `\SynapticAuthor[ref=1,email=a@b.com]{Alice Smith}` is written
- **THEN** the author is rendered with superscript "1" linking to affiliation item 1
- **AND** the email is stored and rendered in the email list

#### Scenario: Multiple authors
- **WHEN** three `\SynapticAuthor` commands are issued
- **THEN** all three appear in the author block, separated by appropriate spacing
