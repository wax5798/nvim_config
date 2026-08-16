local global = require("core.global")

local function load_options()
    local global_local = {
        termguicolors = true,
        mouse = "a",
        errorbells = false,
        visualbell = false,
        hidden = true,
        fileformats = "unix,mac,dos",
        magic = true,
        virtualedit = "block",
        encoding = "utf-8",
        viewoptions = "folds,cursor,curdir,slash,unix",
        sessionoptions = "curdir,help,tabpages,winsize",
        -- clipboard = "unnamedplus",
        wildignorecase = true,
        wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
        backup = false,
        writebackup = false,
        swapfile = false,
        undodir = global.cache_dir .. "undo/",
        -- directory = global.cache_dir .. "swap/",
        -- backupdir = global.cache_dir .. "backup/",
        -- viewdir = global.cache_dir .. "view/",
        -- spellfile = global.cache_dir .. "spell/en.uft-8.add",
        history = 2000,
        shada = "!,'300,<50,@100,s10,h",
        backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
        smarttab = true,
        shiftround = true,
        timeout = true,
        ttimeout = true,
        timeoutlen = 500,
        ttimeoutlen = 0,
        updatetime = 100,
        redrawtime = 1500,
        ignorecase = true,
        smartcase = true,
        infercase = true,
        incsearch = true,
        wrapscan = true,
        complete = ".,w,b,k",
        inccommand = "nosplit",
        grepformat = "%f:%l:%c:%m",
        grepprg = "rg --hidden --vimgrep --smart-case --",
        breakat = [[\ \	;:,!?]],
        startofline = false,
        whichwrap = "h,l,<,>,[,],~",
        splitbelow = true,
        splitright = true,
        switchbuf = "useopen",
        backspace = "indent,eol,start",
        diffopt = "filler,iwhite,internal,algorithm:patience",
        completeopt = "menuone,noselect",
        jumpoptions = "stack",
        showmode = false,
        shortmess = "aoOTIcF",
        scrolloff = 2,
        sidescrolloff = 5,
        foldlevelstart = 99,
        ruler = true,
        cursorline = true,
        cursorcolumn = true,
        list = true,
        showtabline = 2,
        winwidth = 30,
        winminwidth = 10,
        pumheight = 15,
        helpheight = 12,
        previewheight = 12,
        showcmd = false,
        cmdheight = 2,
        cmdwinheight = 5,
        equalalways = false,
        laststatus = 2,
        display = "lastline",
        showbreak = "↳  ",
        listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
        -- pumblend = 10,
        -- winblend = 10,
        autoread = true,
        autowrite = true,

        undofile = true,
        synmaxcol = 2500,
        formatoptions = "1jcroql",
        expandtab = true,
        autoindent = true,
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 4,
        breakindentopt = "shift:2,min:20",
        wrap = false,
        linebreak = true,
        number = true,
        -- relativenumber = true,
        foldenable = true,
        signcolumn = "no",
        splitkeep = "screen",
        conceallevel = 0,
        concealcursor = "niv",
        tags = "tags",
        guifont = "JetBrainsMono Nerd Font:h12",
    }

    if global.is_windows then
        -- Neovim 在 Windows 上仅对 cmd.exe 的 shell 处理可靠：若 &shell 被自动
        -- 检测为 git-bash，字符串形式的 system()/jobstart() 会拼成 `bash /s /c ...`
        -- 而失败；bash + shellcmdflag='-c' 也会被 nvim 的 win32 引号逻辑破坏。
        -- 显式固定为 cmd.exe。toggleterm 不受影响（它单独指定 bash 作为终端 shell）。
        vim.o.shell = "cmd.exe"
        vim.o.shellcmdflag = "/s /c"
    end

    -- neovide 光标动画
    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_trail_size = 1.0

    vim.g.python_host_prog = global.python_host_prog
    vim.g.python3_host_prog = global.python3_host_prog
    vim.g.loaded_perl_provider = 0
    for name, value in pairs(global_local) do
        vim.o[name] = value
    end
end

load_options()
