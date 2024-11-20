-- Initialize Packer
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Packer itself
    use 'windwp/nvim-autopairs' -- Autopairs
    use 'nvim-treesitter/nvim-treesitter' -- Syntax highlighting
    use 'neovim/nvim-lspconfig' -- Language Server Protocol
    use 'hrsh7th/nvim-cmp' -- Autocompletion
    use 'hrsh7th/cmp-nvim-lsp' -- LSP completion source
    use 'hrsh7th/cmp-buffer' -- Buffer completion source
    use 'hrsh7th/cmp-path' -- Path completion
    use 'nvim-lua/plenary.nvim' -- Common Lua functions
    use 'nvim-telescope/telescope.nvim' -- File searcher
    use 'mfussenegger/nvim-dap' -- Debug Adapter Protocol
end)

-- Treesitter Configuration
require('nvim-treesitter.configs').setup {
    ensure_installed = { "c" }, -- Install the C parser
    highlight = { enable = true },
    indent = { enable = true }
}

-- LSP Configuration for C (clangd)
local lspconfig = require('lspconfig')
lspconfig.clangd.setup {}

-- Autocompletion Configuration
local cmp = require'cmp'

cmp.setup({
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept completion
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' }
    }
})

-- Telescope Configuration
require('telescope').setup {}

-- Autopair Configuration
require('nvim-autopairs').setup {}

-- Debug Adapter Protocol (DAP) Configuration
local dap = require('dap')
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '~/.vscode/extensions/ms-vscode.cpptools-1.22.11/debugAdapters/bin/OpenDebugAD7' 
}
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        setupCommands = {
            { text = '-enable-pretty-printing', description = 'Enable pretty printing', ignoreFailures = false }
        }
    }
}

-- Keybinding for Build and Run
vim.api.nvim_set_keymap('n', '<F5>', ':w<CR>:!gcc % -o %:r && ./%:r<CR>', { noremap = true, silent = true })
