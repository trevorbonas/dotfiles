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
set cindent
set nohlsearch
set directory=$HOME/.nvim/swapfiles//
set noerrorbells
set incsearch
set signcolumn=yes
set expandtab
set cursorline
set nocompatible
filetype plugin on
syntax on

map <F6> :setlocal spell! spelllang=en_us<CR>
call plug#begin('~/.vim/plugged')
Plug 'nvim-telescope/telescope.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'lewis6991/gitsigns.nvim'
Plug 'EdenEast/nightfox.nvim' " Vim-Plug
Plug 'bluz71/vim-moonfly-colors', { 'branch': 'cterm-compat' }
Plug 'michaeldyrynda/carbon'
Plug 'yonlu/omni.vim'
Plug 'projekt0n/github-nvim-theme'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'vimwiki/vimwiki'
Plug 'bluz71/vim-nightfly-colors'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
call plug#end()

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set splitbelow splitright

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap <SPACE> <Nop>
let mapleader=" "

" fzf keybind
nmap <C-P> :FZF<CR>

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
if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
endif

" Lua integration
lua <<EOF

-- Setup gitsigns
-- require('gitsigns').setup()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()

require('github-theme').setup({
colors = {
        cursor_line_nr = "#FCF669",
        fg = "#fafafa",
   },
 overrides = function(c)
   return {
     Statusline = { bg = "#D9D9D9", fg = "#000000"},
   }
 end,
    dev = true,
    comment_style = "NONE",
    keyword_style = "NONE",
    function_style = "NONE",
    variable_style = "NONE"
})

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
}

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"

dashboard.section.header.val = {
    [[]],
    [[]],
[[         ,MMM8&&&.]],
[[    _...MMMMM88&&&&..._]],
[[ .::'''MMMMM88&&&&&&'''::.]],
[[::     MMMMM88&&&&&&     ::]],
[['::....MMMMM88&&&&&&....::']],
[[   `''''MMMMM88&&&&''''`]],
[[         'MMM8&&&']],
[[]],
}

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

command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)

" PLUGIN: FZF
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

" Source vimrc
nnoremap <silent> <Leader>vc :source $MYVIMRC<CR>:echo "Reloaded init.vim"<CR>

colorscheme github_dark_default
highlight clear SignColumn
