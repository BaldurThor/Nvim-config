-- A general fix for many floating windows, which should cover store.nvim
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

-- Style the border of all floating windows
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5E6472" })

-- NvimTree
vim.api.nvim_set_hl(0, "NvimTreeNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { link = "Normal" })

-- ToggleTerm
vim.api.nvim_set_hl(0, "ToggleTermNormal", { link = "Normal" })

-- Telescope
vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Normal" })

-- Lazy.nvim
vim.api.nvim_set_hl(0, "LazyNormal", { link = "Normal" })

-- Mason
vim.api.nvim_set_hl(0, "MasonNormal", { link = "Normal" })

-- Trouble
vim.api.nvim_set_hl(0, "TroubleNormal", { link = "Normal" })
