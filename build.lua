#!/usr/bin/env texlua

-- l3build configuration for the synaptic bundle

module = "synaptic"

-- Source files at project root
sourcefiledir  = "."
sourcefiles    = {"synaptic.dtx", "synaptic.ins"}

-- Files to install (relative to tex/latex/synaptic/)
installfiles   = {"tex/latex/synaptic/*"}

-- Typeset documentation
typesetfiles   = {"synaptic.dtx"}

-- Documentation files for CTAN
docfiles       = {"README.md", "CHANGELOG.md", "LICENSE"}

-- CTAN packaging
ctanpostdir    = "synaptic"
packtdszip     = true

-- Dependencies
dependencies   = {
  "koma-script", "fontspec", "unicode-math", "mathtools",
  "geometry", "hyperref", "bookmark", "microtype",
  "amsthm", "thmtools", "tcolorbox", "setspace",
  "caption", "enumitem", "seqsplit", "xcolor", "graphicx"
}
