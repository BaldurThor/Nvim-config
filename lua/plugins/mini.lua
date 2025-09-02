return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		require("mini.completion").setup()
		require("mini.pairs").setup()
	end,
}
