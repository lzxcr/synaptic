## 1. 项目基础设施
- [ ] 1.1 创建 CTAN 标准目录结构 (`tex/latex/synaptic/`, `doc/`, `source/`)
- [ ] 1.2 创建 `synaptic.dtx` 骨架（DocStrip 主文件）
- [ ] 1.3 创建 `synaptic.ins` 安装文件
- [ ] 1.4 创建 `l3build.lua` 构建脚本
- [ ] 1.5 更新 `README.md` 反映新架构
- [ ] 1.6 添加 `CHANGELOG.md`

## 2. synaptic-base.sty（核心基础设施）
- [ ] 2.1 从 `synaptic.sty` 提取引擎检查与 KOMA 检测逻辑
- [ ] 2.2 实现新的 `\SynapticSetup{}` 统一配置接口
- [ ] 2.3 实现 `mode=` 选项解析（journal/book/lecture/notes）
- [ ] 2.4 实现 `theme=` 选项解析（ocean/graphite/forest/midnight/paper）
- [ ] 2.5 实现 `lang=` 选项解析（`en`=英文标签；`zh`=中文标签 + CJK 字体）
- [ ] 2.6 实现 `fontset=` 选项解析（xcharter/libertinus/stix2/lm/auto）
- [ ] 2.7 保留并迁移 `extra-math`、`toc`、`toc-layout`、`fine-breaking` 选项
- [ ] 2.8 废弃 `style=` / `color=` 选项（报错提示使用 `mode=` / `theme=`）
- [ ] 2.9 实现 mode-aware 模块自动加载

## 3. synaptic-fonts.sty（字体系统）
- [ ] 3.1 从 `synaptic.sty` 提取字体加载逻辑
- [ ] 3.2 消除硬编码 OTF 文件名（改用 font name）
- [ ] 3.3 实现 `fontset=xcharter` → XCharter + Cabin + Inconsolata
- [ ] 3.4 实现 `fontset=libertinus` → Libertinus Serif + Sans + Mono
- [ ] 3.5 实现 `fontset=stix2` → STIX Two Text + Math
- [ ] 3.6 实现 `fontset=lm` → Latin Modern（零依赖回退）
- [ ] 3.7 实现 `fontset=auto` → Lua 字体检测 + 自动按优先级选择
- [ ] 3.8 创建 `synaptic-fonts.lua` 辅助脚本（字体检测函数）
- [ ] 3.9 `lang=zh` 时 CJK 字体加载路径（Noto Serif/Sans CJK SC → Fandol 回退）

## 4. synaptic-color.sty（主题色彩系统）
- [ ] 4.1 从 `synaptic.sty` 提取颜色定义
- [ ] 4.2 重构为 theme-based 配色：每个 theme 定义 primary/secondary/faded/rule
- [ ] 4.3 实现 `theme=ocean`（现有 ocean 配色）
- [ ] 4.4 实现 `theme=graphite`（灰色系）
- [ ] 4.5 实现 `theme=forest`（绿色系）
- [ ] 4.6 实现 `theme=midnight`（深蓝黑系）
- [ ] 4.7 实现 `theme=paper`（黑白印刷优化）
- [ ] 4.8 实现 `\SynapticDefineTheme{name}{...}` 用户自定义主题接口
- [ ] 4.9 各 theme 文件放入 `themes/` 子目录（`synaptic-theme-ocean.def` 等）

## 5. synaptic-layout.sty（页面布局）
- [ ] 5.1 从 `synaptic.sty` 提取 geometry/段落/间距/断行配置
- [ ] 5.2 实现 mode-aware geometry（journal/lecture/book 不同边距）
- [ ] 5.3 迁移 microtype 逻辑（中英文分支）
- [ ] 5.4 迁移 section heading KOMA 配置
- [ ] 5.5 添加 `\AddToHook{begindocument}` 延迟执行

## 6. synaptic-title.sty（标题页系统）
- [ ] 6.1 实现新公开 API：`\SynapticTitle`、`\SynapticAuthor`、`\SynapticAffiliation`
- [ ] 6.2 实现 `\SynapticEmail`、`\SynapticKeywords`、`\SynapticArxiv`
- [ ] 6.3 实现 `\SynapticHeader`、`\SynapticSubHeader`、`\SynapticDedicated`
- [ ] 6.4 实现 `\SynapticMakeTitle`（替代旧 `\maketitle`）
- [ ] 6.5 保留 `abstract` 环境收集机制
- [ ] 6.6 内部数据结构从 prop/seq 改为结构化对象

## 7. synaptic-theorem.sty（定理系统）
- [ ] 7.1 从 `synaptic.sty` 提取定理环境定义
- [ ] 7.2 实现 mode-aware 定理样式（academic/lecture/book 三种）
- [ ] 7.3 迁移 proof 环境
- [ ] 7.4 迁移 `\declarecustomtheorem` → `\SynapticNewTheorem`
- [ ] 7.5 定理标签改为按 mode+lang 动态解析

## 8. synaptic-book.sty（Book 模式）
- [ ] 8.1 实现 chapter 标题页风格（章节编号 + 横线装饰）
- [ ] 8.2 实现 running header（章节名/节名交替）
- [ ] 8.3 实现 frontmatter/mainmatter/backmatter 页面样式
- [ ] 8.4 实现 part 页样式

## 9. synaptic-lecture.sty（Lecture 模式）
- [ ] 9.1 实现 lecture 模式 geometry（宽边距 + 大标题）
- [ ] 9.2 加载 `synaptic-boxes.sty`
- [ ] 9.3 配置 lecture 专属定理样式（tcolorbox 彩色边框）

## 10. synaptic-boxes.sty（Box 系统）
- [ ] 10.1 基于 `tcolorbox` 实现 `{example}` 环境
- [ ] 10.2 实现 `{remark}` 环境
- [ ] 10.3 实现 `{warning}` 环境
- [ ] 10.4 实现 `{exercise}` 环境
- [ ] 10.5 实现通用 `{synbox}` 环境（可配置标题+颜色）

## 11. 语言系统
- [ ] 11.1 创建 `synaptic-lang-en.def`（英文标签集）
- [ ] 11.2 创建 `synaptic-lang-zh.def`（中文标签集）
- [ ] 11.3 实现 `\SynapticSetLabel` 运行时标签覆盖

## 12. CTAN 合规与文档
- [ ] 12.1 创建 `synaptic.dtx`：嵌入所有 module 代码 + DocStrip guard，含文档 driver（ltxdoc）
- [ ] 12.2 验证 `.ins` + `.dtx` 能正确解包出所有 `.sty` 文件
- [ ] 12.3 更新 `srcs/synaptic-user-en.tex` 适配 v2 API（mode/theme/fontset、新命令）
- [ ] 12.4 更新 `srcs/synaptic-user-zh.tex` 同步中文版用户手册
- [ ] 12.5 更新 `srcs/synaptic-tech-en.tex` 反映模块架构
- [ ] 12.6 配置 `l3build ctan` 打包并测试 `l3build doc` 能生成手册 PDF
- [ ] 12.7 运行 `l3build check` 全量验证
- [ ] 12.8 编译并替换新版 `docs/synaptic-user-en.pdf` 和 `docs/synaptic-user-zh.pdf`

## 13. 测试与验证
- [ ] 13.1 为每个 mode 创建 MWE 测试文档
- [ ] 13.2 为每个 theme 创建配色展示文档
- [ ] 13.3 为每个 fontset 创建字体对比文档
- [ ] 13.4 l3build 回归测试
- [ ] 13.5 更新根目录 `README.md` 反映新架构与新 API
- [ ] 13.6 更新根目录 `CHANGELOG.md`
