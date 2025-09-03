-- lua/plugins/treesitter.lua
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "OXY2DEV/markview.nvim" },
	build = ":TSUpdate",
	config = function()
		-- Pull the list of parsers from our central config file
		local treesitter_parsers = require("config.tools").treesitter

		require("nvim-treesitter.configs").setup({
			-- Use the list of parsers from our tools config
			ensure_installed = treesitter_parsers,

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers on file open
			auto_install = true,

			highlight = {
				enable = true,
			},
			indent = { enable = true },
		})
	end,
}
