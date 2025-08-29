-- lazy.nvim
return {
	"folke/snacks.nvim",
	priority = 1000,
	---@type snacks.Config
	opts = {
		dashboard = {
			preset = {
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
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
	},
}
