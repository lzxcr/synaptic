%% File: synaptic.dtx
%% License: LPPL 1.3c or later
%%
%% synaptic -- Modern Academic Typesetting Framework
%% A modular LaTeX3 design system for articles, books, and lecture notes.
%% Requires LuaLaTeX + KOMA-Script.
%%










-- synaptic-fonts.lua
-- Font detection and priority selection for synaptic

if not synaptic then synaptic = {} end
if not synaptic.fonts then synaptic.fonts = {} end

local kpse = kpse
local font_priority = {
  "XCharter",
  "Libertinus Serif",
  "STIX Two Text",
  "Latin Modern Roman"
}

local font_cache = {}

function synaptic.fonts.exists(fontname)
  if font_cache[fontname] ~= nil then
    return font_cache[fontname]
  end
  -- Use kpsewhich-style lookup via luaotfload
  local found = kpse.find_file(fontname, "opentype fonts")
      or kpse.find_file(fontname, "truetype fonts")
  font_cache[fontname] = (found ~= nil)
  return font_cache[fontname]
end

function synaptic.fonts.detect()
  for _, font in ipairs(font_priority) do
    if synaptic.fonts.exists(font) then
      if font == "XCharter" then return "xcharter"
      elseif font == "Libertinus Serif" then return "libertinus"
      elseif font == "STIX Two Text" then return "stix2"
      else return "lm" end
    end
  end
  return "lm"
end

return synaptic





