-- ~/.config/nvim/lua/keymaps.lua

local opts = { noremap = true, silent = true }

-- Save file
vim.keymap.set('n', '<leader>w', ':w<CR>', opts)

-- Delete buffer
vim.keymap.set('n', '<leader>dd', ':bd<CR>', opts)

-- Delete all buffers and return to home
vim.keymap.set('n', '<leader>da', ':bufdo bwipeout<CR>:Alpha<CR>', opts)

-- Edit $MYVIMRC
vim.keymap.set('n', '<leader>cc', ':e $MYVIMRC<CR>', opts)

-- Center the cursor when searching
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Yank to system clipboard
vim.keymap.set('n', '<leader>y', '"+y', opts)
vim.keymap.set('v', '<leader>y', '"+y', opts)

-- Open lazy.nvim
vim.keymap.set('n', '<leader>l', ':Lazy<CR>', opts)

-- Open Mason
vim.keymap.set('n', '<leader>m', ':Mason<CR>', opts)

-- Open Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Close Lazy with either escape or q
local user_grp = vim.api.nvim_create_augroup("LazyUserGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lazy",
  desc = "Quit lazy with <esc>",
  callback = function()
    vim.keymap.set(
      "n",
      "<esc>",
      function() vim.api.nvim_win_close(0, false) end,
      { buffer = true, nowait = true }
    )
  end,
  group = user_grp,
})
