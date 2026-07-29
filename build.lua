-- l3build configuration for the synaptic bundle
module = "synaptic"

sourcefiledir = "."
sourcefiles   = {"synaptic.dtx", "synaptic.ins"}
installfiles  = {"synaptic.sty", "synaptic-base.sty", "synaptic-color.sty",
                  "synaptic-fonts.sty", "synaptic-fonts.lua", "synaptic-layout.sty",
                  "synaptic-title.sty", "synaptic-theorem.sty", "synaptic-book.sty",
                  "synaptic-lecture.sty", "synaptic-boxes.sty",
                  "synaptic-lang-en.def", "synaptic-lang-zh.def"}
typesetfiles  = {"synaptic.dtx"}
docfiles      = {"README.md", "CHANGELOG.md", "LICENSE"}
ctanpostdir   = "synaptic"
packtdszip    = true

dependencies  = {
  "koma-script", "fontspec", "unicode-math", "mathtools",
  "geometry", "hyperref", "bookmark", "microtype",
  "amsthm", "thmtools", "tcolorbox", "setspace",
  "caption", "enumitem", "seqsplit", "xcolor", "graphicx"
}
