# Neovim Configuration

基于 LazyVim 的 Neovim 配置，适用于 Windows 系统。

## 安装说明

### 前置要求

- **Neovim 0.10+**: [下载地址](https://github.com/neovim/neovim/releases) （当前推荐 v0.12.1）
- **Git**: 用于插件管理
- **Windows Terminal / PowerShell / CMD**: 终端环境

### 步骤

1. 备份现有配置（可选）:
   ```powershell
   Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
   ```

2. 克隆配置到配置目录:
   ```powershell
   git clone https://github.com/your-repo/nvim_config.git $env:LOCALAPPDATA\nvim
   ```

3. 启动 Neovim:
   ```powershell
   nvim
   ```

4. 等待 LazyVim 自动安装所有插件

5. 安装完成后，运行 Treesitter 更新:
   ```vim
   :TSUpdate
   ```

---

## 必需工具

部分插件需要安装额外的外部工具才能正常工作。

| 工具 | 说明 | 下载地址 | 需要的插件 | 必需 |
|------|------|----------|------------|------|
| **Git** | 版本控制 | [git-scm.com](https://git-scm.com/download/win) | gitsigns.nvim, diffview.nvim, lazy.nvim | ✅ |
| **Nerd Font** | 编程字体（含图标） | [nerdfonts.com](https://www.nerdfonts.com/) | nvim-tree.lua, bufferline.nvim, lualine.nvim | ✅ |
| **Universal Ctags** | 代码索引工具 | [ctags.io](https://ctags.io/) | tagbar, vim-gutentags | ✅ |
| **GNU Global** | 作用域感知代码索引（gtags） | [www.gnu.org/software/global](https://www.gnu.org/software/global/) | vim-gutentags, gutentags_plus | ✅ |
| **gtags-cscope** | GNU Global 的 cscope 兼容接口 | 随 GNU Global 安装 | gutentags_plus | ✅ |
| **zoxide** | 智能目录跳转 | [github.com/ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide/releases) | telescope-zoxide | ⚠️ |
| **Make** | 编译工具 | 通过 MSYS2 或 MinGW 安装 | telescope-fzf-native.nvim | ✅ |
| **Node.js + neovim** | Node.js 集成 | [nodejs.org](https://nodejs.org/) | 可选 LSP 功能 | ⚠️ |
| **Python 3** | Python 支持 | [python.org](https://www.python.org/downloads/) | dap python, neovim remote plugin | ⚠️ |
| **Perl** | Perl 支持 | [strawberryperl.com](https://strawberryperl.com/) | 可选 provider | ⚠️ |

### Nerd Font 安装步骤

1. 下载 Nerd Font（推荐 JetBrainsMono Nerd Font 或 FiraCode Nerd Font）
2. 解压并安装 `.ttf` 字体文件
3. 将终端字体设置为已安装的 Nerd Font

### Make 安装步骤（MSYS2）

1. 下载 [MSYS2](https://www.msys2.org/)
2. 安装后打开 MSYS2 UCRT64 终端
3. 运行:
   ```bash
   pacman -S make mingw-w64-ucrt-x86_64-gcc
   ```
4. 将 `C:\msys64\ucrt64\bin` 添加到系统 PATH 环境变量

### Node.js neovim npm 包（可选）

如需使用 Node.js 集成，运行:
```powershell
npm install -g neovim
```

---

## 需要编译的插件

以下插件在安装后需要执行编译或构建步骤：

| 插件 | 编译命令 | 说明 |
|------|----------|------|
| **nvim-treesitter** | `:TSUpdate` | 下载并编译所有语言的语法解析器 |
| **telescope-fzf-native.nvim** | `make` | 编译 FZF 原生搜索扩展（需安装 Make） |

### 编译 Treesitter 语法解析器

启动 Neovim 后，执行:
```vim
:TSUpdate
```

或者更新单个语言:
```vim
:TSUpdate python
```

### 编译 telescope-fzf-native

插件会自动尝试编译，如需手动编译:
```bash
cd $env:LOCALAPPDATA\nvim\data\lazy\telescope-fzf-native.nvim
make
```

---

## 插件依赖关系图

```
nvim-treesitter
  ├── nvim-treesitter-textobjects
  ├── nvim-ts-rainbow
  └── vim-matchup

nvim-cmp
  ├── cmp-under-comparator
  ├── cmp_luasnip
  ├── cmp-nvim-lua
  ├── cmp-tmux
  ├── cmp-path
  ├── cmp-spell
  └── cmp-buffer

LuaSnip
  └── friendly-snippets

telescope.nvim
  ├── plenary.nvim
  ├── telescope-fzf-native.nvim  ⚠️ 需要编译
  ├── telescope-project.nvim
  ├── telescope-frecency.nvim
  │   └── sqlite.lua
  └── telescope-zoxide  ⚠️ 需要 zoxide

nvim-dap
  └── nvim-dap-ui

nvim-tree.lua  ⚠️ 需要 Nerd Font
  └── nvim-web-devicons  ⚠️ 需要 Nerd Font

gitsigns.nvim
  └── plenary.nvim
```

---

## 快捷键

| 快捷键 | 功能 |
|--------|------|
| `,` | Leader 键 |
| `<C-p>` | Telescope 查找文件 |
| `<Leader>ff` | Telescope 文件搜索 |
| `<Leader>fw` | Telescope 字符串搜索 |
| `<Leader>fg` | Telescope Git 文件 |
| `<Leader>fs` | Telescope 符号搜索 |
| `<C-n>` | NvimTree 切换 |
| `gb` | BufferLine 选择缓冲区 |
| `gt` | Trouble 切换 |
| `<F8>` | 单词高亮切换 |
| `<F4>` | Aerial 符号大纲切换 |
| `<Leader>cg` | GNU Global 查找定义（光标处单词） |
| `<Leader>cz` | GNU Global 查找 tag（taglist） |
| `<Leader>cs` | GNU Global 查找符号 |
| `<Leader>cc` | GNU Global 查找调用者 |
| `<Leader>ct` | GNU Global 全文搜索 |
| `<Leader>ck` | 关闭全部 cscope 连接 |
| `<Leader>u` | Undotree 切换 |
| `j/k` | 加速的 jk 移动 |
| `ga` | EasyAlign 对齐 |
| `<Leader>tt` | ToggleTerm 终端 |

---

## C/C++ 非 LSP 跳转（GNU Global + gutentags_plus）

C/C++ 文件默认不启用 clangd LSP，改用 **GNU Global (gtags)** 提供作用域感知的跳转：

- vim-gutentags 在后台生成 `tags`（ctags）与 `GTAGS`/`GRTAGS`/`GPATH`（gtags）数据库
- 数据库缓存在 `%LOCALAPPDATA%\nvim-data\gtags\` 下，不污染项目目录
- gutentags_plus 提供 `GscopeFind` 命令，结果进入 quickfix 窗口

对比 ctags：同名函数分散在不同 class 时，`g<C-]>` 的 ctags 选项会很多且无上下文；而 gtags 的 `global` 支持带作用域前缀（如 `A::f`）的精确定位。

### GNU Global 安装（MSYS2）

```bash
pacman -S mingw-w64-x86_64-global
```

安装后确认 `global`、`gtags`、`gtags-cscope` 在 PATH 中。

### 补丁说明（重要）

以下插件在 Windows + Neovim 下有兼容问题，本配置通过 `patches/` 目录下的补丁修复（补丁文件位于本仓库的 `patches/` 文件夹，完整路径为 `%LOCALAPPDATA%\nvim\patches\`）：

| 补丁 | 解决的问题 |
|------|-----------|
| `wilder.nvim-popupmenu_devicons-E704.patch` | 命令栏补全函数式完成的用户命令（`-complete=customlist,xxx` 等）时，`cmdline.expand` 是 Funcref，`l:expand` 触发 `E704: Funcref variable name must start with a capital`；改名 `l:Expand` 修复 |
| `vim-gutentags-nvim-cmd-shell.patch` | ① Neovim 用 bash 壳执行 .cmd 脚本失败（`/usr/bin/bash: /s`），强制走 cmd.exe；② 移除 cscope 守卫（Neovim 0.5+ 无 cscope 支持，GTAGS 模块需要它）；③ 退出前停掉进行中的后台任务并清理半成品 DB/临时文件，避免大项目首轮生成时 `:wq` 卡死与下次 `--incremental` 报 "corrupted"（不用 `detach`，否则子进程弹出可见 cmd 窗口）；④ `update_tags.cmd` 默认日志从 `CON` 改 `NUL` |
| `gutentags_plus-nvim-cmd-shell.patch` | `system()`/`systemlist()` 走 bash 失败（`/usr/bin/bash: /s`），强制走 cmd.exe |

**使用方法（手动，首次安装或每次 `:Lazy update` 后需重新执行）**：

每个补丁需要在**对应的插件安装目录**下执行 `git apply`，补丁文件统一从 `%LOCALAPPDATA%\nvim\patches\` 引用。依次执行：

```bash
cd %LOCALAPPDATA%\nvim-data\lazy\wilder.nvim
git apply %LOCALAPPDATA%\nvim\patches\wilder.nvim-popupmenu_devicons-E704.patch

cd %LOCALAPPDATA%\nvim-data\lazy\vim-gutentags
git apply %LOCALAPPDATA%\nvim\patches\vim-gutentags-nvim-cmd-shell.patch

cd %LOCALAPPDATA%\nvim-data\lazy\gutentags_plus
git apply %LOCALAPPDATA%\nvim\patches\gutentags_plus-nvim-cmd-shell.patch
```

执行 `:Lazy update` 会重置插件，补丁被覆盖，需重新执行以上命令。

> 提示：也可以在 `lua/modules/tools/plugins.lua` 中给对应插件加 lazy.nvim 的 `build` 钩子，使更新后自动重新打补丁，免去手动执行。

---

## 故障排除

### checkhealth 警告信息

运行 `:checkhealth` 查看当前配置状态，常见警告：

| 警告 | 解决方案 |
|------|----------|
| `WARNING Nvim x.x.x is available` | 更新 Neovim 到最新版本 |
| `Missing "neovim" npm package` | 运行 `npm install -g neovim` |
| `WARNING python3 not installed` | 安装 [Python 3](https://www.python.org/downloads/) |
| `No perl executable found` | 安装 [Strawberry Perl](https://strawberryperl.com/) 或忽略（可选） |

### 字体图标显示为方块

确保已安装 Nerd Font 并在终端设置中启用。

### Telescope 搜索慢

确保 `telescope-fzf-native.nvim` 已成功编译。

### Treesitter 语法高亮异常

运行 `:TSUpdate` 更新语法解析器。

### tagbar 无法工作

确保已安装 Universal Ctags 并在 PATH 中。

### shell 相关命令异常（`/usr/bin/bash: /s: No such file or directory`）

Neovim 在 Windows 上会把 PATH 中的 git-bash 自动检测为 `&shell`，但它对 bash 的
字符串命令拼接不可靠（`system()`/`jobstart()` 会变成 `bash /s /c ...` 而失败）。
本配置已在 `lua/core/options.lua` 中显式固定 `shell = "cmd.exe"`。终端窗口
（toggleterm）不受影响，仍使用 git-bash。

### 查看 tags/GTAGS 是否已生成

打开项目文件后：

```vim
:echo b:gutentags_files    " 显示当前项目的 ctags/GTAGS 路径
:echo filereadable('C:\Users\81090\AppData\Local\nvim-data\gtags\<项目>\GTAGS')
```

文件存在且 `getfsize()` 数值不再增长 = 生成完成；生成中会先出现 `.lock` 临时文件。
也可用 `:messages` 查看 "Generating missing tags file" 等进度。强制重建：`:GutentagsUpdate`。

### `,cg` 报 `<<...GTAGS>> corrupted.`

多发生在 GTAGS 生成被中途打断（例如大项目首次生成未完成就关闭 nvim）。会随下次打开自动
全量重建；若长时间仍报错，手动删除 `nvim-data\gtags\<项目>` 目录后重开即可。
