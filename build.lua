-- l3build configuration for the synaptic bundle
module = "synaptic"

sourcefiledir = "."
sourcefiles   = {"synaptic.dtx", "synaptic.ins", "docs/*.tex", "examples/*.tex"}
installfiles  = {"synaptic*.sty", "synaptic-lang-*.def"}
typesetfiles  = {
  "synaptic.dtx",
  "synaptic-tech-en.tex",
  "synaptic-tech-zh.tex",
  "synaptic-user-en.tex",
  "synaptic-user-zh.tex",
}
typesetdemofiles = {"book.tex", "journal.tex", "lecture.tex", "notes.tex"}
demofiles     = {"examples/*.tex"}
textfiles     = {"README.md", "CHANGELOG.md", "LICENSE"}
ctanpostdir   = "synaptic"
packtdszip    = true

typesetexe    = "lualatex"
typesetopts   = "-interaction=nonstopmode -halt-on-error"
checkengines  = {"luatex"}
stdengine     = "luatex"
checkruns     = 2
