return {
	"folke/trouble.nvim",
	opts = {},
	config = function(_, opts)
		require("trouble").setup(opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "trouble",
			callback = function()
				local function jump_and_code_action()
					-- First, jump to the location of the item in the source file.
					require("trouble").jump()
					-- Then, schedule the code action to run immediately after the jump.
					vim.schedule(function()
						vim.lsp.buf.code_action()
					end)
				end
				vim.keymap.set(
					"n",
					"<leader>ca",
					jump_and_code_action,
					{ silent = true, buffer = true, desc = "Code Action" }
				)
			end,
		})
	end,
	cmd = "Trouble",
	keys = {
		{
			"<leader>ct",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Workspace Diagnostics",
		},
		{
			"<leader>cT",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Document Symbols",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions",
		},
		{
			"<leader>cL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List",
		},
		{
			"<leader>cq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List",
		},
	},
}
