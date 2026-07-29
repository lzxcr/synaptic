# Design: synaptic v2 现代化重构

## 架构决策

### ADR-1: 分层模块 vs 单体 sty

**决策**: 拆分为 10 个模块（`synaptic-*.sty`），由 `synaptic.sty` 作为薄壳调度。

**理由**:
- 单体 sty 无法表达 journal/book/lecture 三种本质不同的排版模式
- 每个模块可独立测试、独立文档化
- 用户可按需加载子模块（如只用 `synaptic-theorem.sty`）
- CTAN 评审偏好模块化设计

**风险**:
- 跨模块的内部 API 需要稳定契约
- 旧用户从 `\usepackage{synaptic}` 迁移需要改写少量代码

**缓解**:
- 所有内部 API 统一 `\__synaptic_<module>_<fn>:<sig>` 命名
- 提供迁移指南（不提供二进制兼容）

---

### ADR-2: `mode=` 系统设计

**决策**: 用 `mode=` 替代 `style=`，控制加载哪些子模块 + 子模块行为参数。

**`mode=` 语义**:

| mode | document class | 加载模块 | 特征 |
|------|---------------|---------|------|
| `journal` | `scrartcl` | base+fonts+color+layout+title+theorem | 紧凑标题页、submission header、双栏友好 |
| `book` | `scrbook` | base+fonts+color+layout+title+theorem+book | Chapter 风格、running head、front/main/back matter |
| `lecture` | `scrartcl`/`scrreprt` | base+fonts+color+layout+theorem+lecture+boxes | 大标题、宽边距、彩色定理盒、Example/Exercise |
| `notes` | `scrartcl` | base+fonts+color+layout+theorem | 极简、无标题页、最小间距 |

**实现方式**: `synaptic.sty` 内 `\str_case:Vn \l_synaptic_mode_str { ... }` 条件加载。

**替代方案**: 让用户手动 `\usepackage{synaptic-base,synaptic-book}`——被否决，因为对初学者不友好。

---

### ADR-3: `theme=` 系统设计

**决策**: theme 是独立 `.def` 文件，定义一组颜色 + 风格变量。

**Theme 结构** (`synaptic-theme-ocean.def`):
```latex
\tl_set:Nn \l_synaptic_theme_primary_tl   { RGB: 0,106,176 }
\tl_set:Nn \l_synaptic_theme_secondary_tl { RGB: 46,64,83 }
\tl_set:Nn \l_synaptic_theme_accent_tl    { RGB: 14,98,81 }
% heading 风格
\tl_set:Nn \l_synaptic_theme_heading_font_tl { \sffamily\bfseries }
% theorem 风格
\tl_set:Nn \l_synaptic_theme_theorem_style_tl { framed }
```

**内置 themes**: `ocean`, `graphite`, `forest`, `midnight`, `paper`

**扩展**: 用户可 `\SynapticLoadTheme{mytheme}` 加载自定义 `.def`

**替代方案**: 用 `\keys_define:nn` 动态定义——被否决，因为 theme 需要跨模块共享大量变量，独立文件更清晰。

---

### ADR-4: API 命名空间策略（干净分层，零兼容）

**决策**: 干净分层，旧 API 全部废弃

| 层级 | 前缀 | 示例 | 说明 |
|------|------|------|------|
| 用户 API | `\Synaptic*` | `\SynapticTitle`, `\SynapticSetup` | CamelCase，面向用户 |
| 用户环境 | `synaptic*` | `synapticexample`, `synapticbox` | 小写 + 前缀 |
| 内部实现 | `\__synaptic_<mod>_*` | `\__synaptic_title_render:` | 私有，expl3 规范 |

**关键变更**: 不再 `\RenewDocumentCommand{\title}`，改为提供 `\SynapticTitle{}`。
`\title` / `\author` / `\maketitle` 不再有效（不提供兼容层）。

**理由**:
- 避免与其他 package（babel, hyperref, cleveref, KOMA）的 `\title` 定义冲突
- CTAN 最佳实践：不覆盖 LaTeX 内核命令
- v2 是干净重写，不背旧包袱

---

### ADR-5: 字体系统 — fontset + Lua 检测

**决策**: `fontset=` 选项 + Lua 字体检测引擎。

**fontset 选项**:
- `auto` (默认) — Lua 按优先级自动检测
- `xcharter` — XCharter + Cabin + Inconsolata (当前)
- `libertinus` — Libertinus Serif + Sans + Mono
- `stix2` — STIX Two Text + Math
- `lm` — Latin Modern (安全 fallback)

**Lua 检测** (`synaptic-fonts.lua`):
```lua
synaptic.fonts = {
  priority = {
    main = {"XCharter-Roman.otf", "LibertinusSerif-Regular.otf", ...},
    math = {"XCharter-Math.otf", "LibertinusMath-Regular.otf", ...},
  },
  detect = function()
    -- 用 luaotfload 检测字体是否存在
  end
}
```

**中文**: `lang=zh` 时自动加载 CJK 字体，不受 `fontset=` 影响。

---

### ADR-6: dtx + ins 构建

**决策**: 用 DocStrip 管理源码，`l3build` 做构建。

**目录结构**:
```
synaptic/
├── synaptic.dtx              % 主 DocStrip 源码
├── synaptic.ins              % 安装脚本
├── l3build.lua               % 构建配置
├── README.md
├── LICENSE
├── CHANGELOG.md
│
├── tex/latex/synaptic/       % 生成的 sty 文件
│   ├── synaptic.sty
│   ├── synaptic-base.sty
│   ├── ...
│   └── synaptic-theme-*.def
│
├── doc/                      % 文档
│   ├── synaptic.pdf
│   └── ...
│
└── source/                   % 文档源码
    └── ...
```

---

### ADR-7: 语言系统（精简合一）

**决策**: `lang=zh` 一次性做两件事：中文标签翻译 + CJK 字体加载。不拆分 `chinese=true`。

```latex
\usepackage[
  mode=journal,
  lang=zh      % 标签：摘要/关键词/证明... + CJK 字体
]{synaptic}
```

**标签系统**: `synaptic-lang-en.def` / `synaptic-lang-zh.def`，每个文件定义一组 `\__synaptic_label_<key>:tl`。

**CJK 字体**: `lang=zh` 时加载 ctex（`heading=false, scheme=plain`），配 Noto Serif/Sans CJK SC → Fandol 回退。

**原因不拆分**: `lang=zh` 的合理语义就是"用中文写文档"，标签 + 字体是自然的整体。为边缘用例（英文标签 + 中文文本）增加一个独立选项是过度工程。

---

### ADR-8: 定理系统增强

**决策**: 保留 `thmtools` 基础，叠加 `tcolorbox` box 系统。

- `mode=journal` — 传统 thmtools 风格（当前行为）
- `mode=lecture` — tcolorbox 彩色盒
- `mode=book` — 介于两者之间

定理风格变量通过 theme 控制。

---

### ADR-9: PDF Metadata & Accessibility

**决策**: 在 `\AtBeginDocument` 注入：

```latex
\DocumentMetadata{
  pdfstandard = A-2b,
  lang        = <detected>,
  testphase   = {phase-III}  % tagging
}
```

这需要 LaTeX 2023-11+，当前用户已声明的 `\NeedsTeXFormat{LaTeX2e}[2023/11/01]` 满足。

---

## 模块依赖图

```
synaptic.sty (薄壳)
  ├── synaptic-base.sty      (无依赖)
  ├── synaptic-color.sty     (依赖 base)
  ├── synaptic-fonts.sty     (依赖 base)
  │     └── synaptic-fonts.lua
  ├── synaptic-layout.sty    (依赖 base, color)
  ├── synaptic-title.sty     (依赖 base, color, layout)
  ├── synaptic-theorem.sty   (依赖 base, color)
  ├── synaptic-boxes.sty     (依赖 base, color, theorem)
  ├── synaptic-book.sty      (依赖 base, layout, title)
  └── synaptic-lecture.sty   (依赖 base, layout, theorem, boxes)
```

---

## 破坏性变更（v1 → v2，不提供兼容层）

| 旧 API | v2 行为 |
|--------|---------|
| `\usepackage[color=ocean]{synaptic}` | 报错，提示用 `theme=ocean` |
| `\usepackage[style=modern]{synaptic}` | 报错，提示用 `mode=journal` |
| `\title{...}` / `\author{...}` | 报错，提示用 `\SynapticTitle{...}` / `\SynapticAuthor{...}` |
| `\maketitle` | 不再可用，改为 `\SynapticMakeTitle` |
| `\usepackage[lang=zh]{synaptic}` | 保持不变（中文标签 + CJK 字体） |
