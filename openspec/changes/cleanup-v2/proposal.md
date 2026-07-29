## Why

synaptic v2 重构完成后存在以下遗留问题：
1. **编译警告** — `require('synaptic-fonts')` 找不到 Lua 模块（`require` 不走 TEXINPUTS）；`\synaptic_if_lang_zh:TF` 未定义
2. **多余文件** — 根目录 `synaptic.ins` 与 `tex/latex/synaptic/synaptic.ins` 重复；`source/` 空目录；`.cache/` 编译缓存
3. **缺少 `.gitignore`** — 编译器输出和缓存文件会污染 git 状态
4. **文档可扩充** — 手册缺 theme/fontset/mode 详细说明；dtx 文档可加更多模块注释
5. **`\file_input:n` 加载 `.def` 在某些 LaTeX 版本可能不稳定**

## What Changes

### 1. 清理多余文件和目录
- 删除根目录 `synaptic.ins`（保留 `tex/latex/synaptic/` 下的）
- 删除空的 `source/` 目录
- 删除 `srcs/*.log` 等 stray 编译产物
- 创建 `.gitignore`

### 2. 修复编译警告
- 改用 `dofile(kpse.find_file('synaptic-fonts.lua'))` 替代 `require('synaptic-fonts')`
- 确保 `\synaptic_if_lang_zh:TF` 在所有调用点之前已定义
- 消除所有 undefined control sequence / overfull / underfull

### 3. 扩充文档
- 更新用户手册：增加 theme 配色预览表、fontset 对照表、mode 对比
- 更新技术手册：详细模块依赖说明、版本历史
- dtx：增加 Implementation 部分的模块级注释

### 4. 按 CTAN checklist 补齐
- `.gitignore`
- `synaptic.ins` 去重
- 确保 `l3build check` 友好
