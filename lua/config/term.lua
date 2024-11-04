vim.opt.shell = "fish"

vim.api.nvim_command("autocmd TermOpen * startinsert")
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")

function TerminalToggle()
	local currentBuff = vim.api.nvim_get_current_buf()
	if vim.g.terminalToggle and vim.g.terminalBuffer == currentBuff then
		vim.api.nvim_set_current_buf(vim.g.terminalBuffer)
		vim.api.nvim_exec2("close", {})
		vim.g.terminalToggle = false
	elseif vim.g.terminalToggle and vim.g.terminalBuffer ~= currentBuff then
		vim.api.nvim_set_current_buf(vim.g.terminalBuffer)
		--vim.api.nvim_exec2("startinsert", {})
	else
		vim.api.nvim_exec2("new", {})
		vim.api.nvim_exec2("term", {})
		vim.g.terminalBuffer = vim.api.nvim_get_current_buf()
		vim.g.terminalToggle = true
	end
end

vim.keymap.set("n", "<C-Bslash>", function()
	TerminalToggle()
end)
