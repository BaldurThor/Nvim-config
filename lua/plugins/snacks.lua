return {
	"folke/snacks.nvim",
	priority = 1000,
	---@type snacks.Config
	opts = {
		dashboard = {
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = "󰒲 ",
						key = "l",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{
						icon = "󱊈 ",
						key = "m",
						desc = "Mason",
						action = ":Mason",
					},
					{
						icon = " ",
						key = "s",
						desc = "Store",
						action = ":Store",
					},
					{
						icon = " ",
						key = "h",
						desc = "Check Health",
						action = ":checkhealth",
					},
					{
						icon = " ",
						key = "S",
						desc = "SSH Connect",
						action = ":SSHConnect",
					},
					{
						icon = "󰖷 ",
						key = "E",
						desc = "SSH Edit",
						action = ":SSHEdit",
					},

					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				header = [[
  _   _         __     ___           
 | \ | | ___  __\ \   / (_)_ __ ___  
 |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \ 
 | |\  |  __/ (_) \ V / | | | | | | |
 |_| \_|\___|\___/ \_/  |_|_| |_| |_|]],
			},
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		local augroup = vim.api.nvim_create_augroup("DashboardStatusline", { clear = true })
		local default_laststatus = vim.o.laststatus

		vim.api.nvim_create_autocmd("User", {
			group = augroup,
			pattern = "SnacksDashboardOpened",
			callback = function()
				vim.o.laststatus = 3
				local bufnr = vim.api.nvim_get_current_buf()
				vim.api.nvim_create_autocmd("BufLeave", {
					buffer = bufnr,
					once = true,
					callback = function()
						vim.o.laststatus = default_laststatus
					end,
				})
			end,
		})
	end,
}
