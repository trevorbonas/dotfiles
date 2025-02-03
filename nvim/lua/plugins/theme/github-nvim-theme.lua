return {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    config = function()
        local override = require('github-theme.override')
        override.palettes = {
          github_dark_dimmed = {
            comment = false,
            conditional = '#636e7b',
            bg1 = '#0cf150',
          }
        }
        override.specs = {
          github_dark_dimmed = {
            -- Base of spec
            -- re-export of palette values

            -- bg0 = '', -- Alt backgrounds (floats, statusline, etc.)
            -- bg1 = '#272b2f', -- Default background
            -- bg2 = '', -- Lighter bg (colorcolumn folds)
            -- bg3 = '', -- Lighter bg (Cursor line and revealed whitespace)
            -- bg4 = '', -- Lighter bg (Conceal, revealed newline chars)
            -- fg0 = '', -- Lighter fg (Relative line numbers)
            -- fg1 = '', -- Default fg
            -- fg2 = '', -- Darker fg (status line)
            -- fg3 = '', -- Darker fg (line numbers, fold columns)
            -- sel0 = '', -- Visual selection bg
            -- sel2 = '', -- Search bg
            syntax = {
              -- Maps palette color values to syntax values used by the group

              -- bracket = '', -- Brackets and punctuation
              -- builtin0 = '', -- Builtin variable
              -- builtin1 = '', -- Builtin type
              -- builtin2 = '', -- Builtin const
              -- comment = '',
              -- conditional = '', -- Conditional and loop
              -- const = '', -- Constants, imports, and booleans
              -- dep = '', -- Deprecated
              -- field = '',
              -- func = '', -- Functions and titles
              -- ident = '', -- Identifiers
              -- keyword = '',
              -- number = '',
              -- operator = '',
              -- preproc = '',
              -- regex = '',
              -- statement = '',
              -- string = '',
              -- type = '',
              -- variable = '',
            },
          }
        }
        override.groups = {
          all = {
            IncSearch = { bg = 'palette.cyan' },
          },
        }
        require('github-theme').setup({

            override = override,
            options = {
                -- Compiled file's destination location
                compile_path = vim.fn.stdpath('cache') .. '/github-theme',
                compile_file_suffix = '_compiled', -- Compiled file suffix
                hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
                hide_nc_statusline = true, -- Override the underline style for non-active statuslines
                transparent = false,       -- Disable setting bg (make neovim's background transparent)
                terminal_colors = true,    -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                dim_inactive = false,      -- Non focused panes set to alternative background
                module_default = true,     -- Default enable value for modules
                styles = {                 -- Style to be applied to different syntax groups
                    comments = 'NONE',     -- Value is any valid attr-list value `:help attr-list`
                    functions = 'NONE',
                    keywords = 'NONE',
                    variables = 'NONE',
                    conditionals = 'NONE',
                    constants = 'NONE',
                    numbers = 'NONE',
                    operators = 'NONE',
                    strings = 'NONE',
                    types = 'NONE',
                },
                inverse = {                -- Inverse highlight for different types
                    match_paren = false,
                    visual = false,
                    search = false,
                },
                darken = {                 -- Darken floating windows and sidebar-like windows
                    floats = true,
                    sidebars = {
                        enable = true,
                        list = {},             -- Apply dark background to specific windows
                    },
                },
                modules = {                -- List of various plugins and additional options
                -- ...
                },
            },
        })

        vim.cmd('colorscheme github_dark_dimmed')
    end,
}
