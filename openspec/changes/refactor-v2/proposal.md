## Why

`synaptic.sty` 当前是一个 677 行的单体 `.sty`，其排版美学与 expl3 代码质量已达到"高级个人模板"水平。但若要达到 **CTAN 发布级 LaTeX3 学术排版框架**，存在以下结构性问题：

1. **架构耦合过重** — 单体 sty 同时承担 article/book/lecture note/journal 全部职责，无法自然扩展多种出版形态
2. **API 侵入性强** — 重定义 `\title`/`\author`/`\maketitle`，与其他 package（hyperref/babel/cleveref）可能冲突
3. **缺乏 namespace 分层** — 公开 API / 内部实现混在一起，无 `__synaptic` 私有层约定
4. **选项系统扁平** — `color=ocean` 仅管配色，无法扩展为完整 theme（配色+字体风格+间距风格）
5. **缺少 mode 系统** — 无 journal/book/lecture/notes 模式区分
6. **LaTeX2e 残余** — 混用 `\newcommand`/`\setlength`/`\renewcommand`，与 expl3 理念不一致
7. **字体策略硬编码** — 按文件名检测，缺少 fontset 抽象与 Lua 字体引擎
8. **缺少 CTAN 必需基础设施** — 无 `.dtx`/`.ins`，无 `l3build`，无 PDF metadata/accessibility
9. **语言系统粗糙** — `lang=zh` 直接加载 ctex，可能干扰用户已有的中文设置

## What Changes

### 1. 模块拆分（单体 sty → 分层模块组）
将 677 行 `synaptic.sty` 拆为：
- `synaptic-base.sty` — 引擎检查、options 解析、公共基础设施
- `synaptic-fonts.sty` — 字体加载、fontset 策略、Lua 字体检测
- `synaptic-color.sty` — 颜色定义、theme 配色系统
- `synaptic-layout.sty` — geometry、段落、间距、断行
- `synaptic-title.sty` — 标题页渲染（journal 模式）
- `synaptic-theorem.sty` — 定理/证明环境
- `synaptic-book.sty` — book 模式（chapter 风格、页眉）
- `synaptic-lecture.sty` — lecture 模式（Example/Exercise box、彩色定理盒）

`synaptic.sty` 变为薄壳：按 mode 自动加载对应子模块。

### 2. 引入 `mode=` 系统
替代现有 `style=modern/minimal`，新增：
- `mode=journal` — 现有功能，论文/预印本
- `mode=book` — scrbook，chapter 风格
- `mode=lecture` — 讲义，大标题 + 宽边距 + 彩色 box
- `mode=notes` — 个人笔记，极致简洁

### 3. 引入 `theme=` 系统
替代现有 `color=ocean/teal/carbon`，扩展为：
- `theme=ocean` / `theme=graphite` / `theme=forest` / `theme=midnight` / `theme=paper`
- 每个 theme 定义：primary/secondary 颜色 + heading 风格 + theorem 风格 + hyperlink 颜色

### 4. API 命名空间清理
- 公开用户接口 → `\SynapticTitle{}`、`\SynapticAuthor{}`、`\SynapticSetup{}`（不污染 `\title`/`\author`）
- 废弃 `\RenewDocumentCommand{\title}` 等侵入式重定义
- 内部实现全部进 `\__synaptic_` 私有前缀
- **废弃旧 API**：旧 `\title`/`\author`/`\maketitle` 不再有效，用户必须使用新 API

### 5. 字体系统重构
- 引入 `fontset=` 选项（`xcharter`/`libertinus`/`stix2`/`lm`/`auto`）
- `fontset=auto` 时用 Lua 自动检测最佳可用字体
- 不再硬编码 OTF 文件名

### 6. CTAN 基础建设
- 源码转入 `.dtx` + `.ins`（DocStrip）
- 添加 `l3build.lua` 构建脚本
- 添加 PDF metadata（`\DocumentMetadata`）
- 目录结构对齐 CTAN 标准（`tex/latex/synaptic/` + `doc/`）

### 7. 语言系统
- `lang=zh` 一次性完成：中文标签翻译 + CJK 字体加载
- 不再拆分 `chinese=true` 独立选项（避免 API 膨胀）
- 标签数据抽取到 `synaptic-lang-en.def` / `synaptic-lang-zh.def`
- `lang=zh` 加载 ctex 时保持 `heading=false, scheme=plain`，仅获取 CJK 字体能力

### 8. Box 系统（tcolorbox）
- `synaptic-boxes.sty`：`{example}`、`{remark}`、`{warning}`、`{synbox}`
- lecture 模式下默认启用彩色 box
