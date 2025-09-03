return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "OXY2DEV/markview.nvim" },
	build = ":TSUpdate",
	config = function()
		local treesitter_parsers = require("config.tools").treesitter

		require("nvim-treesitter.configs").setup({
			ensure_installed = treesitter_parsers,
			sync_install = false,
			auto_install = true,
			-- Add the missing fields to fix the error
			modules = {},
			ignore_install = {},
			highlight = {
				enable = true,
			},
			indent = { enable = true },
		})
	end,
}
