-- Mason configuration
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    -- Automatically install LSPs configured via lspconfig
    automatic_installation = true,
    ensure_installed = {},
})

-- Enhanced LSP keymappings (similar to LazyVim)
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- LSP key mappings
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- Enhanced navigation functions
    local function goto_definition()
        require("telescope.builtin").lsp_definitions({ reuse_win = true })
    end

    local function goto_references()
        require("telescope.builtin").lsp_references({
            show_line = false,
            include_declaration = true,
        })
    end

    local function goto_implementation()
        require("telescope.builtin").lsp_implementations({ reuse_win = true })
    end

    local function goto_declaration()
        vim.lsp.buf.declaration()
    end

    local function goto_type_definition()
        require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
    end

    -- Navigation mappings
    vim.keymap.set('n', 'gD', goto_declaration, vim.tbl_extend("force", bufopts, { desc = "Go to declaration" }))
    vim.keymap.set('n', 'gd', goto_definition, vim.tbl_extend("force", bufopts, { desc = "Go to definition" }))
    vim.keymap.set('n', 'gr', goto_references, vim.tbl_extend("force", bufopts, { desc = "Go to references" }))
    vim.keymap.set('n', 'gi', goto_implementation, vim.tbl_extend("force", bufopts, { desc = "Go to implementation" }))
    vim.keymap.set('n', 'gt', goto_type_definition, vim.tbl_extend("force", bufopts, { desc = "Go to type definition" }))

    -- Documentation and help
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "Show hover documentation" }))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend("force", bufopts, { desc = "Show signature help" }))

    -- Workspace management
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", bufopts, { desc = "Add workspace folder" }))
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", bufopts, { desc = "Remove workspace folder" }))
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend("force", bufopts, { desc = "List workspace folders" }))

    -- Code actions and refactoring
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "Rename symbol" }))
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend("force", bufopts, { desc = "Code actions" }))
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, vim.tbl_extend("force", bufopts, { desc = "Format document" }))
end

-- Configure LSP servers
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup LSPs manually for now
-- This is a more reliable approach than using setup_handlers
local servers = require("mason-lspconfig").get_installed_servers()

for _, server_name in ipairs(servers) do
    lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
