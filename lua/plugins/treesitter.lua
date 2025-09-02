return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "OXY2DEV/markview.nvim" },
	lazy = false,
	build = "TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = { enable = true }, -- Enable syntax highlighting
			indent = { enable = true }, -- Enable indentation
			ensure_installed = { "lua", "vimdoc", "python" }, -- Example: always install these parsers
			auto_install = true, -- Automatically install missing parsers on file open
		})
	end,

	-- ... All other options.
}
