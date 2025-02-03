return {
    "goolord/alpha-nvim",
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'glepnir/dashboard-nvim',
        'fzf-lua',
    },
    lazy = false,
    config = function()
      local fzf = require('fzf-lua')
      local dashboard = require("alpha.themes.dashboard")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider

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

      dashboard.section.buttons.val = {
        dashboard.button("p", "λ Find File", ":FzfLua files<CR>"),
        dashboard.button("e", "☀ New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("h", "▲ Recent Files", ":FzfLua oldfiles<CR>"),
        dashboard.button("f", "τ Find Text", ":FzfLua grep_project<CR>"),
        dashboard.button("c", "Ω Configuration", ":e $MYVIMRC<CR>"),
        dashboard.button("z", "Σ Lazy", ":Lazy<CR>"),
        dashboard.button("q", "x Quit Neovim", ":qa!<CR>"),
      }

      local footer = function()
        local version = "neovim " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
        return version
      end

      dashboard.section.footer.val = footer()

      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButton"

      dashboard.opts.opts.noautocmd = true
      require("alpha").setup(
        dashboard.config
      )
    end,
}
