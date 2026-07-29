## MODIFIED Requirements

### Requirement: Language-Driven Label Translation
The system SHALL translate all UI labels (abstract, keywords, proof, theorem names, etc.) based on the `lang=` option.

#### Scenario: English labels (lang=en, default)
- **WHEN** `lang=en` (or not specified)
- **THEN** "Abstract", "Keywords", "Proof", "Theorem", "Lemma", "Proposition", "Definition" are used
- **AND** no CJK font infrastructure is loaded

#### Scenario: Chinese labels + CJK fonts (lang=zh)
- **WHEN** `lang=zh`
- **THEN** "摘要", "关键词", "证明", "定理", "引理", "命题", "定义" are used
- **AND** `ctex` is loaded with `heading=false, scheme=plain`
- **AND** CJK fonts are loaded (Noto Serif/Sans CJK SC with Fandol fallback)

#### Scenario: Label override
- **WHEN** `\SynapticSetLabel{proof}{Demonstration}` is called before `\begin{document}`
- **THEN** the custom label "Demonstration" replaces the default for the proof environment

---

### Requirement: Language Definition Files
The system SHALL store language-specific strings in separate `.def` files (`synaptic-lang-en.def`, `synaptic-lang-zh.def`), extensible for future languages.

#### Scenario: Adding a new language
- **WHEN** a user creates `synaptic-lang-fr.def` following the same key-value structure
- **THEN** `lang=fr` can be specified and all labels are translated to French
