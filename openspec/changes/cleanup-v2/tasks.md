## 1. 清理多余文件
- [ ] 1.1 删除根目录 `synaptic.ins`（重复，保留 `tex/latex/synaptic/synaptic.ins`）
- [ ] 1.2 删除空目录 `source/`
- [ ] 1.3 删除 `srcs/synaptic-user-zh.log`（.gitignore 加 *.log）
- [ ] 1.4 创建 `.gitignore`：忽略 `*.aux/*.log/*.out/*.toc/.cache/` 等
- [ ] 1.5 将 `.cache/` 加入 `.gitignore`

## 2. 修复编译警告
- [ ] 2.1 修复 Lua 加载：`require('synaptic-fonts')` → `dofile(kpse.find_file(...))`
- [ ] 2.2 检查并消除所有 `Undefined control sequence` 警告
- [ ] 2.3 验证 `journal`/`lecture`/`book` 三种 mode 均零警告编译
- [ ] 2.4 验证 `lang=zh` 模式零警告编译

## 3. 扩充文档
- [ ] 3.1 用户手册（en）：增加 Options 详细说明表、Theme 配色预览、Fontset 对照
- [ ] 3.2 用户手册（zh）：同样扩充
- [ ] 3.3 技术手册（en）：添加完整的模块 API 说明和 mode dispatch 细节
- [ ] 3.4 重新编译四份 PDF 并替换 `docs/` 中的旧版本

## 4. dtx 完善
- [ ] 4.1 在 stdtx 中添加每个模块的简要功能注释
- [ ] 4.2 重新生成 `synaptic.dtx` 并验证 `lualatex synaptic.dtx` 能生成文档 PDF
- [ ] 4.3 验证 `lualatex synaptic.ins` 解包 → 编译全链路零警告

## 5. README 同步更新
- [ ] 5.1 确保 README 中文件路径列表与实际一致
- [ ] 5.2 添加 CTAN 安装说明
