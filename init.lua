vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.api.nvim_create_user_command('Tree', 'NvimTreeToggle', {})

require("config.lazy")

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
-- After setting up mason-lspconfig you may set up servers via lspconfig
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "harper_ls" },
}
require("lspconfig").lua_ls.setup {}
require("lspconfig").rust_analyzer.setup {}
require("lspconfig").harper_ls.setup {}

-- End of lspconfig

require("dapui").setup {}

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

