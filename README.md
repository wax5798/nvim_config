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
| **Universal Ctags** | 代码索引工具 | [ctags.io](https://ctags.io/) | tagbar | ✅ |
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
| `<F4>` | Tagbar 切换 ⚠️ 需要 ctags |
| `<Leader>u` | Undotree 切换 |
| `j/k` | 加速的 jk 移动 |
| `ga` | EasyAlign 对齐 |
| `<Leader>tt` | ToggleTerm 终端 |

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
