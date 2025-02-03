--  ╭──────────────────────────────────────────────────────────╮
--  │                    LSP CONFIGURATION                     │
--  ╰──────────────────────────────────────────────────────────╯
return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufReadPost', 'BufNewFile' },
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'clangd',
                    'cssls',
                    'emmet_ls',
                    'gopls',
                    'html',
                    'intelephense',
                    'jdtls',
                    'jsonls',
                    'ltex',
                    'lua_ls',
                    'ruff',
                    'rust_analyzer',
                    'tailwindcss',
                    'texlab',
                    'tinymist',
                    'ts_ls',
                    'volar',
                    'yamlls',
                },
            })
            -- ╭───────────╮
            -- │ LSPCONFIG │
            -- ╰───────────╯
            local lspconfig = require('lspconfig')

            local lsp_defaults = lspconfig.util.default_config

            -- ╭────────────────────╮
            -- │ DIAGNOSTIC KEYMAPS │
            -- ╰────────────────────╯
            local opts = function(desc)
                return { noremap = true, silent = true, desc = desc }
            end

            vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts('Open Diagnostic Window'))
            vim.keymap.set('n', '<space><left>', function()
                vim.diagnostic.jump({ count = -vim.v.count1 })
            end, opts('Previous Diagnostic'))
            vim.keymap.set('n', '<space><right>', function()
                vim.diagnostic.jump({ count = vim.v.count1 })
            end, opts('Next Diagnostic'))
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts('Send Diagnostic to Locallist'))

            -- ╭───────────────────────╮
            -- │ LSPATTACH AUTOCOMMAND │
            -- ╰───────────────────────╯
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- ╭─────────╮
                    -- │ KEYMAPS │
                    -- ╰─────────╯
                    local bufopts = function(desc)
                        return { buffer = ev.buf, desc = desc }
                    end
                    -- Default lsp keymaps. Setting the keymaps again, only to change the description.
                    vim.keymap.set('n', 'K', function()
                        vim.lsp.buf.hover({ border = 'single' })
                    end, bufopts('Hover'))
                    vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action, bufopts('LSP Code Action'))
                    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, bufopts('LSP Rename'))
                    vim.keymap.set('n', 'grr', vim.lsp.buf.references, bufopts('LSP References'))
                    -- Custom lsp keymaps.
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts('LSP Go to Definition'))
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts('LSP Go to Declaration'))
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts('LSP Go to Implementation'))
                    vim.keymap.set('n', 'grf', function()
                        vim.lsp.buf.format({ async = true })
                    end, bufopts('LSP Formatting'))
                    vim.keymap.set('n', 'grk', function()
                        vim.lsp.buf.signature_help({ border = 'single' })
                    end, bufopts('LSP Singature Help'))
                    vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, bufopts('LSP Document Symbols'))
                    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts('LSP Type Definition'))
                    vim.keymap.set('n', 'gwa', vim.lsp.buf.add_workspace_folder, bufopts('LSP Add Workspace Folder'))
                    vim.keymap.set('n', 'gwr', vim.lsp.buf.remove_workspace_folder, bufopts('LSP Remove Workspace Folder'))
                    vim.keymap.set('n', 'gwl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, bufopts('LSP List Workspace Folder'))

                    -- Get client
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    -- ╭─────────────╮
                    -- │ INLAY HINTS │
                    -- ╰─────────────╯
                    if client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true)
                    else
                        vim.lsp.inlay_hint.enable(false)
                    end
                end,
            })

            -- ╭────────────────────╮
            -- │ TOGGLE INLAY HINTS │
            -- ╰────────────────────╯
            if vim.lsp.inlay_hint then
                vim.keymap.set('n', '<Space>ih', function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, { desc = 'Toggle Inlay Hints' })
            end

            -- ╭─────────────────────────────────────────╮
            -- │ DISABLE LSP INLINE DIAGNOSTICS MESSAGES │
            -- ╰─────────────────────────────────────────╯
            vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false,
            })

            -- ╭───────────────────╮
            -- │ DIAGNOSTIC CONFIG │
            -- ╰───────────────────╯
            vim.diagnostic.config({
                virtual_text = false,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                jump = {
                    float = true,
                },
                float = { border = 'single' },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = ' ',
                        [vim.diagnostic.severity.WARN] = ' ',
                        [vim.diagnostic.severity.HINT] = '󰌶 ',
                        [vim.diagnostic.severity.INFO] = ' ',
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
                        [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
                        [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
                        [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
                    },
                },
            })

            -- Function to check if the cursor is on a diagnostic
            local function is_cursor_on_diagnostic()
              local cursor_pos = vim.api.nvim_win_get_cursor(0) -- Get current cursor position (1-based line, 1-based column)
              local diagnostics = vim.diagnostic.get(0) -- Get diagnostics for the current buffer

              for _, diagnostic in ipairs(diagnostics) do
                local start_row, start_col = diagnostic.lnum, diagnostic.col
                local end_row, end_col = diagnostic.end_lnum or start_row, diagnostic.end_col or start_col

                -- Check if the cursor is within the diagnostic range
                if cursor_pos[1] == start_row + 1 and cursor_pos[2] >= start_col and cursor_pos[2] <= end_col then
                  return true
                end
              end

              return false
            end

            -- Automatically show diagnostics in a floating window only when the cursor is on the diagnostic
            vim.api.nvim_create_autocmd('CursorHold', {
              pattern = '*',
              callback = function()
                if is_cursor_on_diagnostic() then
                  vim.diagnostic.open_float(nil, { focusable = false, border = 'rounded' })
                end
              end,
            })

            vim.diagnostic.open_float(nil, {
              focusable = false, -- Make the floating window non-focusable
              border = 'rounded', -- Use a rounded border
              source = 'always', -- Always show the source of the diagnostic
            })

            vim.opt.updatetime = 300 -- Set updatetime to 300ms

            --  ╭──────────────────────────────────────────────────────────╮
            --  │                         SERVERS                          │
            --  ╰──────────────────────────────────────────────────────────╯
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            capabilities.textDocument.inlayHint = { dynamicRegistration = true }

            -- ╭────────────╮
            -- │ LUA SERVER │
            -- ╰────────────╯
            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, 'lua/?.lua')
            table.insert(runtime_path, 'lua/?/init.lua')
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                        return
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                -- Depending on the usage, you might want to add additional paths here.
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                            },
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        },
                    })
                    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
                end,
                settings = {
                    Lua = {},
                },

            })

            -- ╭───────────────────╮
            -- │ JAVASCRIPT SERVER │
            -- ╰───────────────────╯
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                init_options = {
                    plugins = {
                        {
                            name = '@/vue/typescript-plugin',
                            location = '/Users/ilias/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server',
                            languages = { 'vue' },
                        },
                    },
                    preferences = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                        importModuleSpecifierPreference = 'non-relative',
                    },
                },
            })

            -- ╭───────────╮
            -- │ GO SERVER │
            -- ╰───────────╯
            lspconfig.gopls.setup({
                capabilities = capabilities,
            })

            -- ╭──────────────╮
            -- │ C/C++ SERVER │
            -- ╰──────────────╯
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })

            -- ╭──────────────────╮
            -- │ VOLAR VUE SERVER │
            -- ╰──────────────────╯
            lspconfig.volar.setup({
                capabilities = capabilities,
                init_options = {
                    typescript = {
                        tsdk = '/Users/ilias/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib',
                    },
                    vue = {
                        hybridMode = false,
                    },
                },
            })

            -- ╭───────────────╮
            -- │ PYTHON SERVER │
            -- ╰───────────────╯
            lspconfig.ruff.setup({
                capabilities = capabilities,
            })

            -- ╭───────────────────────╮
            -- │ EMMET LANGUAGE SERVER │
            -- ╰───────────────────────╯
            lspconfig.emmet_language_server.setup({
                capabilities = capabilities,
            })

            -- ╭────────────╮
            -- │ CSS SERVER │
            -- ╰────────────╯
            lspconfig.cssls.setup({
                capabilities = capabilities,
                settings = {
                    css = {
                        lint = {
                            unknownAtRules = 'ignore',
                        },
                    },
                },
            })

            -- ╭─────────────────╮
            -- │ TAILWIND SERVER │
            -- ╰─────────────────╯
            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
                settings = {
                    tailwindCSS = {
                        classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
                        includeLanguages = {
                            eelixir = 'html-eex',
                            eruby = 'erb',
                            htmlangular = 'html',
                            templ = 'html',
                        },
                        lint = {
                            cssConflict = 'warning',
                            invalidApply = 'error',
                            invalidConfigPath = 'error',
                            invalidScreen = 'error',
                            invalidTailwindDirective = 'error',
                            invalidVariant = 'error',
                            recommendedVariantOrder = 'warning',
                        },
                        validate = true,
                    },
                },
            })

            -- ╭─────────────╮
            -- │ JSON SERVER │
            -- ╰─────────────╯
            lspconfig.jsonls.setup({
                capabilities = capabilities,
                filetypes = { 'json', 'jsonc' },
                init_options = {
                    provideFormatter = true,
                },
            })

            -- ╭─────────────╮
            -- │ HTML SERVER │
            -- ╰─────────────╯
            lspconfig.html.setup({
                capabilities = capabilities,
                settigns = {
                    css = {
                        lint = {
                            validProperties = {},
                        },
                    },
                },
            })

            -- ╭─────────────╮
            -- │ LTEX SERVER │
            -- ╰─────────────╯
            lspconfig.ltex.setup({
                capabilities = capabilities,
                filetypes = { 'bibtex', 'markdown', 'latex', 'tex' },
                settings = {
                    -- ltex = {
                    --     language = 'de-DE',
                    -- },
                },
            })

            -- ╭───────────────╮
            -- │ TEXLAB SERVER │
            -- ╰───────────────╯
            lspconfig.texlab.setup({
                capabilities = capabilities,
                settings = {
                    texlab = {
                        auxDirectory = '.',
                        bibtexFormatter = 'texlab',
                        build = {
                            args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
                            executable = 'latexmk',
                            forwardSearchAfter = false,
                            onSave = false,
                        },
                        chktex = {
                            onEdit = false,
                            onOpenAndSave = false,
                        },
                        diagnosticsDelay = 300,
                        formatterLineLength = 100,
                        forwardSearch = {
                            args = {},
                        },
                        latexFormatter = 'latexindent',
                        latexindent = {
                            modifyLineBreaks = false,
                        },
                    },
                },
            })

            -- ╭────────────╮
            -- │ PHP SERVER │
            -- ╰────────────╯
            lspconfig.intelephense.setup({
                capabilities = capabilities,
            })

            -- ╭─────────────╮
            -- │ JAVA SERVER │
            -- ╰─────────────╯
            lspconfig.jdtls.setup({
                capabilities = capabilities,
            })

            -- ╭─────────────╮
            -- │ YAML SERVER │
            -- ╰─────────────╯
            lspconfig.yamlls.setup({
                capabilities = capabilities,
                settings = {
                    yaml = {
                        validate = true,
                        hover = true,
                        completion = true,
                        format = {
                            enable = true,
                            singleQuote = true,
                            bracketSpacing = true,
                        },
                        editor = {
                            tabSize = 2,
                        },
                        schemaStore = {
                            enable = true,
                        },
                    },
                    editor = {
                        tabSize = 2,
                    },
                },
            })

            -- ╭─────────────╮
            -- │ RUST SERVER │
            -- ╰─────────────╯
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
            })

            -- ╭──────────────╮
            -- │ TYPST SERVER │
            -- ╰──────────────╯
            lspconfig.tinymist.setup({
                capabilities = capabilities,
                single_file_support = true,
                root_dir = function()
                    return vim.fn.getcwd()
                end,
                settings = {
                    formatterMode = 'typstyle',
                },
            })
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        name = 'nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
            'hrsh7th/cmp-buffer',   -- Buffer source for nvim-cmp
            'hrsh7th/cmp-path',     -- Path source for nvim-cmp
            'hrsh7th/cmp-cmdline',  -- Command-line source for nvim-cmp
            'L3MON4D3/LuaSnip',     -- Snippet engine
            'saadparwaiz1/cmp_luasnip', -- Snippet source for nvim-cmp
        },
        config = function()
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            cmp.setup({
                preselect = cmp.PreselectMode.None,
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback() -- Fallback to default behavior (newline)
                            end
                        end,
                    }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        -- Add icons for different sources
                        vim_item.menu = ({
                            nvim_lsp = '[LSP]',
                            luasnip = '[Snippet]',
                            buffer = '[Buffer]',
                            path = '[Path]',
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })

            -- Use buffer source for `/` and `?` (if you enabled `cmp-cmdline`).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `cmp-cmdline`).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                }),
            })

            -- LuaSnip configuration
            require('luasnip.loaders.from_vscode').lazy_load()
        end,
    },
}
