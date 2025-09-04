return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false, -- Make sure lualine is loaded at startup
	config = function()
		require("plugins.lualine.theme")
	end,
}
