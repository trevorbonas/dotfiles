return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },

    -- Custom keybinds
    keys = {
      { "<C-P>", function() require("fzf-lua").files() end, desc = "FZF files" },
      { "<leader>b", function() require("fzf-lua").buffers() end, desc = "FZF buffers" },
      { "<leader>f", function() require("fzf-lua").grep_project() end, desc = "FZF find" },
      { "<leader>cc", function() require("fzf-lua").git_commits() end, desc = "FZF commits" },
      { "<leader>hh", function() require("fzf-lua").oldfiles() end, desc = "FZF file history" },
    },

    config = function()
        require('fzf-lua').setup({
            keymap = {
                builtin = {
                    ["<C-J>"] = "preview-down",
                    ["<C-K>"] = "preview-up",
                    ["<C-D>"] = "preview-page-down",
                    ["<C-U>"] = "preview-page-up",
                }
            },
            fzf_colors = {
                true,
            },
            fzf_opts = {
                ['--ansi'] = true,
                ['--layout'] = 'default',
                ['--style'] = 'full',
                ['--keep-right'] = true,
            },
        })
    end,
}

