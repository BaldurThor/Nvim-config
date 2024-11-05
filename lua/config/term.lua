vim.opt.shell = "fish"

vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")

local termOptions = { split = "below", height = 10 }
function TerminalToggle()
	if vim.g.terminalBuf == nil then
		vim.g.terminalBuf = vim.api.nvim_create_buf(true, false)
		vim.g.terminalWin = vim.api.nvim_open_win(vim.g.terminalBuf, true, termOptions)
		vim.cmd(":term")
		vim.cmd(":startinsert")
	elseif vim.g.terminalWin == nil then
		vim.g.terminalWin = vim.api.nvim_open_win(vim.g.terminalBuf, true, termOptions)
		vim.cmd(":startinsert")
	elseif vim.api.nvim_win_is_valid(vim.g.terminalWin) then
		if vim.api.nvim_get_current_win() == vim.g.terminalWin then
			vim.api.nvim_win_close(vim.g.terminalWin, false)
			vim.g.terminalWin = nil
		else
			vim.api.nvim_set_current_win(vim.g.terminalWin)
			vim.cmd(":startinsert")
		end
	else
		vim.g.terminalWin = nil
		TerminalToggle()
	end
end

vim.keymap.set("n", "<C-Bslash>", function()
	TerminalToggle()
end, { desc = "Terminal reveal" })

vim.keymap.set("t", "<C-Bslash>", function()
	TerminalToggle()
end, { desc = "Terminal reveal" })

vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", { desc = "Swap from terminal to window above" })
