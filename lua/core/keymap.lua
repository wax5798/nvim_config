
local set_map = vim.api.nvim_set_keymap

-- ########################## common ########################## --
-- normal
set_map("n", "[b", ":bprevious<cr>", {noremap = true, silent = true})
set_map("n", "]b", ":bnext<cr>", {noremap = true, silent = true})
set_map("n", "[B", ":bfirst<cr>", {noremap = true, silent = true})
set_map("n", "]B", ":blast<cr>", {noremap = true, silent = true})
set_map("n", "[c", ":cprevious<cr>", {noremap = true, silent = true})
set_map("n", "]c", ":cnext<cr>", {noremap = true, silent = true})
set_map("n", "[C", ":cfirst<cr>", {noremap = true, silent = true})
set_map("n", "]C", ":clast<cr>", {noremap = true, silent = true})
set_map("n", "<A-[>", ":vertical resize +5<cr>", {noremap = true, silent = true})
set_map("n", "<A-]>", ":vertical resize -5<cr>", {noremap = true, silent = true})
set_map("n", "<A-;>", ":resize -2<cr>", {noremap = true, silent = true})
set_map("n", "<A-'>", ":resize +2<cr>", {noremap = true, silent = true})
set_map("n", "<A-s>", ":wa<cr>", {noremap = true, silent = true})
set_map("n", "<C-]>", "g<C-]>", {noremap = true})
set_map("n", "<C-LeftMouse>", "<LeftMouse>g<C-]>", {noremap = true})
set_map("n", "<C-RightMouse>", "<LeftMouse><C-t>", {noremap = true})
set_map("n", "<C-h>", "<C-w>h", {noremap = true})
set_map("n", "<C-l>", "<C-w>l", {noremap = true})
set_map("n", "<C-j>", "<C-w>j", {noremap = true})
set_map("n", "<C-k>", "<C-w>k", {noremap = true})
set_map("n", "<C-q>", ":qa<cr>", {noremap = true})
set_map("n", "J", "<S-v>:m '>+1<cr>gv=gv<ESC>", {noremap = true, silent = true})
set_map("n", "K", "<S-v>:m '<-2<cr>gv=gv<ESC>", {noremap = true, silent = true})
set_map("n", "<leader>e", ":set et!<CR>", {noremap = true})
set_map("n", "<tab>", "za", {noremap = true})

-- Insert
set_map("i", "<C-g>", "<Esc>gUawea", {noremap = true})
set_map("i", "<C-u>", "<C-G>u<C-U>", {noremap = true})
set_map("i", "<C-b>", "<Left>", {noremap = true})
set_map("i", "<C-f>", "<Right>", {noremap = true})
set_map("i", "<C-a>", "<ESC>I", {noremap = true})
set_map("i", "<C-e>", "<ESC>A", {noremap = true})
set_map("i", "<C-S-V>", "<C-r>+", {noremap = true})
set_map("i", "<S-Insert>", "<C-r>+", {noremap = true})

-- command line
set_map("c", "<C-b>", "<Left>", {noremap = true})
set_map("c", "<C-f>", "<Right>", {noremap = true})
set_map("c", "<C-a>", "<Home>", {noremap = true})
set_map("c", "<C-e>", "<End>", {noremap = true})
set_map("c", "<C-d>", "<Del>", {noremap = true})
set_map("c", "<C-h>", "<BS>", {noremap = true})
set_map("c", "<C-S-V>", "<C-r>+", {noremap = true})
set_map("c", "<S-Insert>", "<C-r>+", {noremap = true})
set_map("c", "<C-t>", '[[<C-R>=expand("%:p:h") . "/" <cr>]]', {noremap = true})
set_map("c", "w!!", "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!", {noremap = true})

-- Visual
set_map("v", "<C-c>", '"+y', {noremap = true})
set_map("v", "<", "<gv", {noremap = true})
set_map("v", ">", ">gv", {noremap = true})


-- ########################## plugin tools ########################## --
-- Plugin Telescope
set_map("n", "<Leader>fp", ":lua require('telescope').extensions.project.project{}<cr>", {noremap = true, silent = true})
set_map("n", "<Leader>fr", ":lua require('telescope').extensions.frecency.frecency{}<cr>", {noremap = true, silent = true})
set_map("n", "<Leader>fe", ":Telescope oldfiles<cr>", {noremap = true, silent = true})
set_map("n", "<Leader>ff", ":Telescope find_files<cr>", {noremap = true, silent = true})
set_map("n", "<Leader>fc", ":Telescope colorscheme<cr>", {noremap = true, silent = true})
set_map("n", "<Leader>fw", ":Telescope live_grep<cr>", {noremap = true, silent = true})
set_map("n", "<Leader>fs", ":Telescope grep_string<cr>", {noremap = true, silent = true})
set_map("n", "<Leader>fg", ":Telescope git_files<cr>", {noremap = true, silent = true})
set_map("n", "<Leader>fz", ":Telescope zoxide list<cr>", {noremap = true, silent = true})
set_map("n", "<C-p>", ":Telescope find_files<cr>", {noremap = true, silent = true})

-- Plugin trouble
set_map("n", "gt", ":TroubleToggle<cr>", {noremap = true, silent = true})
set_map("n", "gR", ":TroubleToggle lsp_references<cr>", {noremap = true, silent = true})
set_map("n", "<leader>cd", ":TroubleToggle document_diagnostics<cr>", {noremap = true, silent = true})
set_map("n", "<leader>cw", ":TroubleToggle workspace_diagnostics<cr>", {noremap = true, silent = true})
set_map("n", "<leader>cq", ":TroubleToggle quickfix<cr>", {noremap = true, silent = true})
set_map("n", "<leader>cl", ":TroubleToggle loclist<cr>", {noremap = true, silent = true})

-- Plugin nvim_wordshl
set_map("n", "<F8>", ":WHLToggle<cr>", {noremap = true, silent = true})
set_map("c", "<F8>", "WHLToggle ", {noremap = true})
set_map("v", "<F8>", '"ty:WHLToggle <C-r>t<cr>', {noremap = true})

-- Plugin accelerated-jk
set_map("n", "j", "<Plug>(accelerated_jk_gj)", {noremap = true, silent = true})
set_map("n", "k", "<Plug>(accelerated_jk_gk)", {noremap = true, silent = true})

-- Plugin tagbar
set_map("n", "<F4>", ":TagbarToggle<CR>", {noremap = true, silent = true})

-- ########################## plugin ui ########################## --
-- Plugin nvim-tree
set_map("n", "<C-n>", ":NvimTreeToggle<cr>", {noremap = true, silent = true})
set_map("n", "<Leader>nf", ":NvimTreeFindFile<cr>", {noremap = true, silent = true})
set_map("n", "<Leader>nr", ":NvimTreeRefresh<cr>", {noremap = true, silent = true})

-- Bufferline
set_map("n", "gb", ":BufferLinePick<cr>", {noremap = true, silent = true})
set_map("n", "<A-j>", ":BufferLineCyclePrev<cr>", {noremap = true, silent = true})
set_map("n", "<A-k>", ":BufferLineCycleNext<cr>", {noremap = true, silent = true})
set_map("n", "<A-S-j>", ":BufferLineMoveNext<cr>", {noremap = true, silent = true})
set_map("n", "<A-S-k>", ":BufferLineMovePrev<cr>", {noremap = true, silent = true})
set_map("n", "<leader>be", ":BufferLineSortByExtension<cr>", {noremap = true, silent = true})
set_map("n", "<leader>bd", ":BufferLineSortByDirectory<cr>", {noremap = true, silent = true})
set_map("n", "<A-1>", ":BufferLineGoToBuffer 1<cr>", {noremap = true, silent = true})
set_map("n", "<A-2>", ":BufferLineGoToBuffer 2<cr>", {noremap = true, silent = true})
set_map("n", "<A-3>", ":BufferLineGoToBuffer 3<cr>", {noremap = true, silent = true})
set_map("n", "<A-4>", ":BufferLineGoToBuffer 4<cr>", {noremap = true, silent = true})
set_map("n", "<A-5>", ":BufferLineGoToBuffer 5<cr>", {noremap = true, silent = true})
set_map("n", "<A-6>", ":BufferLineGoToBuffer 6<cr>", {noremap = true, silent = true})
set_map("n", "<A-7>", ":BufferLineGoToBuffer 7<cr>", {noremap = true, silent = true})
set_map("n", "<A-8>", ":BufferLineGoToBuffer 8<cr>", {noremap = true, silent = true})
set_map("n", "<A-9>", ":BufferLineGoToBuffer 9<cr>", {noremap = true, silent = true})

-- Plugin Undotree
set_map("n", "<Leader>u", ":UndotreeToggle<cr>", {noremap = true, silent = true})

-- ########################## plugin editor ########################## --
-- Plugin EasyAlign
set_map("n", "ga", ":v:lua.enhance_align('nga')<cr>", {expr = true})
set_map("x", "ga", ":v:lua.enhance_align('xga')<cr>", {expr = true})

-- nvim_comment
set_map("n", "<leader>c<space>", ":CommentToggle<cr>", {noremap = true, silent = true})
set_map("v", "<leader>c<space>", ":CommentToggle<cr>", {noremap = true, silent = true})

-- Plugin Hop
set_map("n", "<space>w", "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {noremap = true, silent = true})
set_map("v", "<space>w", "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {noremap = true, silent = true})
set_map("n", "<space>b", "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {noremap = true, silent = true})
set_map("v", "<space>b", "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {noremap = true, silent = true})
set_map("n", "<space>j", "<cmd>lua require'hop'.hint_lines({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {noremap = true, silent = true})
set_map("v", "<space>j", "<cmd>lua require'hop'.hint_lines({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {noremap = true, silent = true})
set_map("n", "<space>k", "<cmd>lua require'hop'.hint_lines({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {noremap = true, silent = true})
set_map("v", "<space>k", "<cmd>lua require'hop'.hint_lines({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {noremap = true, silent = true})
set_map("n", "<space>f", "<cmd>lua require'hop'.hint_char1()<cr>", {noremap = true, silent = true})
set_map("v", "<space>f", "<cmd>lua require'hop'.hint_char1()<cr>", {noremap = true, silent = true})
