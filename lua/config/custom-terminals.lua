local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
local csvlens = Terminal:new({ cmd = "csvlens", hidden = true, direction = "float" })

function _lazygit_toggle()
	lazygit:toggle()
end

vim.api.nvim_set_keymap(
	"n",
	"<leader>g",
	"<cmd>lua _lazygit_toggle()<CR>",
	{ noremap = true, silent = true, desc = "Toggle lazygit" }
)

-- Needs more to work!
--[[
function _csvlens_toggle()
	csvlens:toggle()
end

vim.api.nvim_set_keymap(
	"n",
	"<leader>C",
	"<cmd>lua _csvlens_toggle()<CR>",
	{ noremap = true, silent = true, desc = "Toggle csvlens" }
)
--]]
