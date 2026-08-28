-- l3build configuration for the synaptic bundle
module = "synaptic"

sourcefiledir = "."
sourcefiles   = {"synaptic.dtx", "synaptic.ins", "srcs/*.tex", "examples/*.tex"}
installfiles  = {"synaptic.sty", "synaptic-base.sty", "synaptic-color.sty",
                  "synaptic-fonts.sty", "synaptic-layout.sty",
                  "synaptic-title.sty", "synaptic-theorem.sty", "synaptic-book.sty",
                  "synaptic-journal.sty", "synaptic-lecture.sty",
                  "synaptic-notes.sty",
                  "synaptic-lang-en.def", "synaptic-lang-zh.def"}
typesetfiles  = {"synaptic.dtx", "srcs/*.tex"}
docfiles      = {"README.md", "CHANGELOG.md", "LICENSE", "docs/*.pdf"}
demofiles     = {"examples/*.tex"}
ctanpostdir   = "synaptic"
packtdszip    = true

typesetexe    = "lualatex"
typesetopts   = "-interaction=nonstopmode -halt-on-error"
checkengines  = {"luatex"}
stdengine     = "luatex"
checkruns     = 2
