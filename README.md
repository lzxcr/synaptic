<p align="center">
  <a href="https://www.latex-project.org/"><img src="https://img.shields.io/badge/LaTeX-2e-008080?style=for-the-badge&logo=latex" alt="LaTeX"></a>
  <a href="https://www.luatex.org/"><img src="https://img.shields.io/badge/Engine-LuaLaTeX-blue?style=for-the-badge&logo=lua" alt="LuaLaTeX"></a>
  <a href="https://ctan.org/pkg/koma-script"><img src="https://img.shields.io/badge/Class-KOMA--Script-orange?style=for-the-badge" alt="KOMA-Script"></a>
  <a href="https://www.latex-project.org/lppl/"><img src="https://img.shields.io/badge/License-LPPL%201.3c-lightgrey?style=for-the-badge" alt="License"></a>
</p>

<h1 align="center">
  🧠 synaptic<br>
  <sup><i>Modern Academic Journal Framework</i></sup>
</h1>

<p align="center">
  <b>English</b> ｜ <a href="#中文说明">中文说明</a>
</p>

---

## English

**Synaptic** is a clean, modern LaTeX package for academic articles, seminar
notes, working papers, and technical reports. It is written entirely in
**expl3** (LaTeX3) and requires **LuaLaTeX** with a **KOMA‑Script** document
class.

> _Like a biological synapse, this package connects your ideas, formulas, and
> layout into a seamless, beautiful network._

### ✨ Features

- 🚀 **Modern foundation** – 100% `expl3` code, no legacy LaTeX2e hacks.
- 🎨 **Key‑value driven** – all settings through `\usepackage[...]`, no editing of `.sty` files.
- 🌐 **Bilingual** – Automatic label translation (Abstract/摘要, Proof/证明, etc.) when `lang=zh`.
- 📐 **Math first** – Powered by `unicode-math` and `thmtools`; shortcuts for `\symbb`, `\symcal`, `\symfrak`.
- 🧩 **Extensible** – Create custom theorem environments with `\declarecustomtheorem`.
- 📑 **Flexible TOC** – Place the table of contents `top`, `inline`, or on its own `page`.
- 🔤 **Font fallback** – Prefers XCharter + Cabin; falls back to Latin Modern with warnings if missing.

### ⚙️ Options

| Key | Values | Default | Description |
|-----|--------|---------|-------------|
| `lang` | `en`, `zh` | `en` | Language for labels and fonts |
| `color` | `ocean`, `teal`, `carbon` | `ocean` | Theme colour |
| `style` | `modern`, `minimal` | `modern` | Page geometry |
| `extra-math` | `true`, `false` | `false` | Enable `\symbb`, `\symcal`, `\symfrak` |
| `toc` | `true`, `false` | `true` | Show table of contents |
| `toc-layout` | `top`, `inline`, `page` | `top` | TOC placement |
| `fine-breaking` | `true`, `false` | `true` | Fine‑tune line breaking |

### 📄 Minimal Working Example

```latex
% !TEX program = lualatex
\documentclass{scrartcl}
\usepackage[lang=en, color=ocean]{synaptic}

\title{A Short Note on \texttt{synaptic}}
\author{Author Name}
\affiliation{University of Nowhere}
\emailAdd{name@example.com}
\keywords{synaptic, example}

\begin{abstract}
  This is an abstract written inside the \texttt{abstract} environment.
\end{abstract}

\begin{document}
\maketitle

\section{Introduction}
The package sets up everything automatically.

\begin{theorem}[Main result]
  All is well.
\end{theorem}
\end{document}
```

Compile with `lualatex example.tex`.

---

## 中文说明

**Synaptic**（突触）是一个为现代学术论文、研讨班讲义、工作论文和技术报告设计的 LaTeX 样式包。
它完全基于 **expl3** 编程，要求使用 **LuaLaTeX** 引擎和 **KOMA‑Script** 文档类。

> _如同生物突触，它将您的思想、公式与版面连接成一个流畅而优美的网络。_

### ✨ 核心特性

- 🚀 **现代架构** – 纯 `expl3` 实现，无老旧 LaTeX2e 补丁。
- 🎨 **键值驱动** – 全部配置通过 `\usepackage[...]` 传入，无需修改宏包内核。
- 🌐 **双语支持** – 切换 `lang=zh` 时，定理名称、摘要标签等自动中文化。
- 📐 **数学优先** – 基于 `unicode-math` 与 `thmtools`，提供黑板粗体、花体、哥特体快捷命令。
- 🧩 **可扩展** – 通过 `\declarecustomtheorem` 一键创建自定义定理环境。
- 📑 **灵活目录** – 目录可置于标题页后（`top`）、嵌入标题页（`inline`）或独立一页（`page`）。
- 🔤 **字体回退** – 首选 XCharter 与 Cabin；缺失时自动回退到 Latin Modern 并给出提示。

### ⚙️ 选项说明

| 选项 | 可选值 | 默认值 | 说明 |
|------|--------|--------|------|
| `lang` | `en`, `zh` | `en` | 界面语言与默认字体 |
| `color` | `ocean`, `teal`, `carbon` | `ocean` | 主题颜色 |
| `style` | `modern`, `minimal` | `modern` | 页面版式（标准/紧凑） |
| `extra-math` | `true`, `false` | `false` | 启用 `\symbb` 等数学快捷命令 |
| `toc` | `true`, `false` | `true` | 是否显示目录 |
| `toc-layout` | `top`, `inline`, `page` | `top` | 目录显示位置 |
| `fine-breaking` | `true`, `false` | `true` | 精细断行调整 |

### 📄 最小工作示例

```latex
% !TEX program = lualatex
\documentclass{scrartcl}
\usepackage[lang=zh, color=teal]{synaptic}

\title{\texttt{synaptic} 快速上手}
\author{作者姓名}
\affiliation{某某大学}
\emailAdd{name@example.com}
\keywords{synaptic, 示例}

\begin{abstract}
  这是一个用 \texttt{abstract} 环境撰写的摘要。
\end{abstract}

\begin{document}
\maketitle

\section{引言}
宏包会自动完成所有设置。

\begin{theorem}[主要结论]
一切正常。
\end{theorem}
\end{document}
```

使用 `lualatex example.tex` 编译。

---

## 📚 文档

- 用户手册（英文）：[docs/synaptic-user-en.pdf](docs/synaptic-user-en.pdf)
- 用户手册（中文）：[docs/synaptic-user-zh.pdf](docs/synaptic-user-zh.pdf)
- 技术手册（英文）：[docs/synaptic-tech-en.pdf](docs/synaptic-tech-en.pdf)
- 技术手册（中文）：[docs/synaptic-tech-zh.pdf](docs/synaptic-tech-zh.pdf)

对应的 LaTeX 源码位于 `srcs/` 目录。

---

## 📜 许可证

本项目以 LaTeX Project Public License v1.3c 或更高版本发布。  
详见 [https://www.latex-project.org/lppl/](https://www.latex-project.org/lppl/)。

---

## 🔗 相关链接

- [CTAN 页面](#)（待上传）
- [项目主页](https://github.com/lzxcr/synaptic)

---

<p align="center">
  <sub>Made with ❤️ for the LaTeX community</sub>
</p>