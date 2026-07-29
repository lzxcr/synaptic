#!/usr/bin/env texlua

-- l3build configuration for the synaptic bundle

module = "synaptic"

-- Source files (dtx + ins)
sourcefiledir = "."
sourcefiles = {
  "synaptic.dtx",
  "synaptic.ins",
  "synaptic-fonts.lua"
}

-- Install destination
installfiles = {
  "synaptic.sty",
  "synaptic-base.sty",
  "synaptic-color.sty",
  "synaptic-fonts.sty",
  "synaptic-fonts.lua",
  "synaptic-layout.sty",
  "synaptic-title.sty",
  "synaptic-theorem.sty",
  "synaptic-book.sty",
  "synaptic-lecture.sty",
  "synaptic-boxes.sty",
  "synaptic-lang-en.def",
  "synaptic-lang-zh.def"
}

-- Documentation
docfiles = {
  "README.md",
  "CHANGELOG.md",
  "LICENSE"
}

-- Typeset documentation
typesetfiles = { "synaptic.dtx" }

-- CTAN directory
ctanpostdir = "synaptic"

-- Packing
packtdszip = true

-- Check configuration
checkconfigs = {
  {
    testdir = "testfiles",
    typeset = false
  }
}

-- Dependencies
dependencies = {
  "koma-script",
  "fontspec",
  "unicode-math",
  "mathtools",
  "geometry",
  "hyperref",
  "bookmark",
  "microtype",
  "amsthm",
  "thmtools",
  "tcolorbox",
  "setspace",
  "caption",
  "enumitem",
  "seqsplit",
  "xcolor",
  "graphicx"
}

-- Tagging
tagset = {
  -- The version and date are extracted from synaptic.dtx
}
