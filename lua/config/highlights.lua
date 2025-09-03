-- Make floating windows transparent
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5E6472" })

-- Make specific plugins transparent
vim.api.nvim_set_hl(0, "NvimTreeNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "ToggleTermNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "LazyNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "MasonNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "TroubleNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "FidgetTitle", { link = "Normal" })
vim.api.nvim_set_hl(0, "FidgetTask", { link = "Normal" })
