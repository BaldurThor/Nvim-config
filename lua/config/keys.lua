-- Window navigation shortcuts
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- File Browser
vim.keymap.set("n", "\\", "<cmd>NvimTreeToggle<CR>")

--[[
-- Remote sshfs
local api = require("remote-sshfs.api")
vim.keymap.set("n", "<leader>rc", api.connect, { desc = "Connect" })
vim.keymap.set("n", "<leader>rd", api.disconnect, { desc = "Disconnect" })
vim.keymap.set("n", "<leader>re", api.edit, { desc = "Edit" })
]]

--code actions
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

vim.keymap.set("n", "<leader>cf", "<cmd>FormatBufferToggle<CR>", { desc = "Toggle Auto Format in Buffer" })

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "LSP Buffer Hover" })

-- Buffer
vim.keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bl", "<cmd>bn<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bp<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bh", "<cmd>bp<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>buffers<CR>", { desc = "List Buffers" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bq", "<cmd>bd<CR>", { desc = "Delete Buffer" })
