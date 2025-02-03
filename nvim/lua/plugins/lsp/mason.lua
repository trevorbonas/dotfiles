return {
    'williamboman/mason.nvim',
    name = 'mason',
    build = ':MasonUpdate',
    cmd = 'Mason',
    lazy = false,
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
    },
    config = function()
        require('mason').setup({
            ui = {
                icons = {
                    package_installed = ' ',
                    package_pending = ' ',
                    package_uninstalled = ' ',
                },
                border = 'single',
                height = 0.8,
            },
        })
    end,
}
