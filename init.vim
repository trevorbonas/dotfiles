"   /$$$$$$$   /$$$$$$   /$$$$$$  /$$    /$$ /$$ /$$$$$$/$$$$ 
"  | $$__  $$ /$$__  $$ /$$__  $$|  $$  /$$/| $$| $$_  $$_  $$
"  | $$  \ $$| $$$$$$$$| $$  \ $$ \  $$/$$/ | $$| $$ \ $$ \ $$
"  | $$  | $$| $$_____/| $$  | $$  \  $$$/  | $$| $$ | $$ | $$
"  | $$  | $$|  $$$$$$$|  $$$$$$/   \  $/   | $$| $$ | $$ | $$
"  |__/  |__/ \_______/ \______/     \_/    |__/|__/ |__/ |__/

set exrc
set relativenumber
set nu
set hidden
set spell
set tabstop=4
set shiftwidth=4
set cursorline
set cindent
set nohlsearch
set directory=$HOME/.nvim/swapfiles//
set noerrorbells
set incsearch
set signcolumn=yes
set expandtab
set nofixendofline
set laststatus=2

" Show whitespace as characters
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" set list

map <F6> :setlocal spell! spelllang=en_us<CR>
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joshdick/onedark.vim', { 'as': 'onedark' }
Plug 'drewtempelmeyer/palenight.vim', { 'as': 'palenight' }
Plug 'lewis6991/gitsigns.nvim'
Plug 'projekt0n/github-nvim-theme'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'LunarVim/Colorschemes'
Plug 'rakr/vim-one'
Plug 'HenryNewcomer/vim-theme-papaya'
Plug 'ts-26a/vim-darkspace'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
Plug 'navarasu/onedark.nvim'
call plug#end()

syntax enable

let g:coc_default_semantic_highlight_groups = 1
" Favourite colorschemes
"colorscheme github_dark_high_contrast
colorscheme github_dark_dimmed
"colorscheme tempus_winter
"colorscheme astrodark

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set splitbelow splitright

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap <SPACE> <Nop>
let mapleader=" "

" fzf keybind
nmap <C-P> :FZF --keep-right<CR>

" CTRL-Tab is next tab
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>
" CTRL-SHIFT-Tab is previous tab
noremap <C-S-Tab> :<C-U>tabprevious<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabprevious<CR>
cnoremap <C-S-Tab> <C-C>:tabprevious<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
      " \ coc#pum#visible() ? coc#pum#next(1) :
      " \ CheckBackspace() ? \"\<Tab>" :
      " \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : \"\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif

" Enable FZF to search for strings within hidden files
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': ['--keep-right']}), <bang>0)

" Make FZF keep buffer names right aligned
command! -bang Buffers call fzf#vim#buffers({'options': ['--keep-right']})

" Make FZF keep buffer names right aligned
command! -bang History call fzf#vim#history({'options': ['--keep-right']})

" PLUGIN: FZF
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

" Source vimrc
nnoremap <silent> <Leader>vc :source $MYVIMRC<CR>:echo "Reloaded init.vim"<CR>

" Delete current buffer
nnoremap <silent> <Leader>dd :bd<CR>

" Delete all buffers and return to home screen
nnoremap <silent> <Leader>da :bufdo bwipeout<CR>:Alpha<CR>

" Edit MYVIMRC
nnoremap <silent> <Leader>c :e $MYVIMRC<CR>

lua <<EOF

-- Setup gitsigns
-- require('gitsigns').setup()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()

-- Setup gitsigns
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

require "paq" {
    "savq/paq-nvim";
    "goolord/alpha-nvim";
    "kyazdani42/nvim-web-devicons";
    "glepnir/dashboard-nvim";
    "nvim-lua/plenary.nvim";
    "kdheepak/lazygit.nvim";
    "nvim-telescope/telescope.nvim";
    "AstroNvim/astrotheme";
}
require('telescope').load_extension('lazygit')

require("astrotheme").setup({
  palette = "astrodark", -- String of the default palette to use when calling `:colorscheme astrotheme`
  background = { -- :h background, palettes to use when using the core vim background colors
    light = "astrolight",
    dark = "astrodark",
  },

  style = {
    transparent = false,         -- Bool value, toggles transperency.
    inactive = true,             -- Bool value, toggles inactive window color.
    float = true,                -- Bool value, toggles floating windows background colors.
    popup = true,                -- Bool value, toggles popup background color.
    neotree = true,              -- Bool value, toggles neo-trees background color.
    border = true,               -- Bool value, toggles borders.
    title_invert = true,         -- Bool value, swaps text and background colors.
    italic_comments = true,      -- Bool value, toggles italic comments.
    simple_syntax_colors = false, -- Bool value, simplifies the amounts of colors used for syntax highlighting.
  },


  termguicolors = true, -- Bool value, toggles if termguicolors are set by AstroTheme.

  terminal_color = true, -- Bool value, toggles if terminal_colors are set by AstroTheme.

  plugin_default = "auto", -- Sets how all plugins will be loaded
                           -- "auto": Uses lazy / packer enabled plugins to load highlights.
                           -- true: Enables all plugins highlights.
                           -- false: Disables all plugins.

  plugins = {              -- Allows for individual plugin overides using plugin name and value from above.
    ["bufferline.nvim"] = false,
  },

  palettes = {
    global = {             -- Globaly accessible palettes, theme palettes take priority.
      my_grey = "#ebebeb",
      my_color = "#ffffff"
    },
    astrodark = {          -- Extend or modify astrodarks palette colors
      ui = {
        red = "#800010", -- Overrides astrodarks red UI color
        accent = "#CC83E3"  -- Changes the accent color of astrodark.
      },
      syntax = {
        cyan = "#800010", -- Overrides astrodarks cyan syntax color
        comments = "#CC83E3"  -- Overrides astrodarks comment color.
      },
      my_color = "#000000" -- Overrides global.my_color
    },
  },

  highlights = {
    global = {             -- Add or modify hl groups globaly, theme specific hl groups take priority.
      modify_hl_groups = function(hl, c)
        hl.PluginColor4 = {fg = c.my_grey, bg = c.none }
      end,
      ["@String"] = {fg = "#ff00ff", bg = "NONE"},
    },
    astrodark = {
      -- first parameter is the highlight table and the second parameter is the color palette table
      modify_hl_groups = function(hl, c) -- modify_hl_groups function allows you to modify hl groups,
        --hl.Comment.fg = c.my_color
        hl.Comment.italic = true
      end,
      ["@String"] = {fg = "#ff00ff", bg = "NONE"},
    },
  },
})

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"

dashboard.section.header.val = {
  [[]],
  [[]],
[[ __   __     ______     ______     __   __   __     __    __    ]],
[[/\ "-.\ \   /\  ___\   /\  __ \   /\ \ / /  /\ \   /\ "-./  \   ]],
[[\ \ \-.  \  \ \  __\   \ \ \/\ \  \ \ \'/   \ \ \  \ \ \-./\ \  ]],
[[ \ \_\\"\_\  \ \_____\  \ \_____\  \ \__|    \ \_\  \ \_\ \ \_\ ]],
[[  \/_/ \/_/   \/_____/   \/_____/   \/_/      \/_/   \/_/  \/_/ ]],
[[]]
}


-- dashboard.section.header.val = {
    -- [[]],
    -- [[]],
-- [[         ,MMM8&&&.]],
-- [[    _...MMMMM88&&&&..._]],
-- [[ .::'''MMMMM88&&&&&&'''::.]],
-- [[::     MMMMM88&&&&&&     ::]],
-- [['::....MMMMM88&&&&&&....::']],
-- [[   `''''MMMMM88&&&&''''`]],
-- [[         'MMM8&&&']],
-- [[]],
-- }

dashboard.section.buttons.val = {
  dashboard.button("p", "λ Find File", ":FZF<CR>"),
  dashboard.button("e", "☀ New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("h", "▲ Recent Files", ":History<CR>"),
  dashboard.button("f", "τ Find Text", ":Rg<CR>"),
  dashboard.button("c", "Ω Configuration", ":e $MYVIMRC<CR>"),
  dashboard.button("u", "Σ Update Plugins", ":PlugUpdate | PaqUpdate<CR>"),
  dashboard.button("q", "x Quit Neovim", ":qa!<CR>"),
}

local footer = function()
  local version = "neovim " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
  if packer_plugins == nil then
    return version
  else
    local total_plugins = "   " .. #vim.tbl_keys(packer_plugins) .. " Plugins"
    return version .. total_plugins
  end
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "AlphaFooter"
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButton"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)

-- End of Lua
EOF

" LazyGit shortcut
nnoremap <Leader>lg :LazyGit<CR>

" Gitsigns shortcuts
" c for change
nnoremap <Leader>cj :Gitsigns next_hunk<CR>
nnoremap <Leader>ck :Gitsigns prev_hunk<CR>
nnoremap <Leader>cb :Gitsigns blame_line<CR>
nnoremap <Leader>cuh :Gitsigns reset_hunk<CR>
nnoremap <Leader>cub :Gitsigns reset_buffer<CR>
