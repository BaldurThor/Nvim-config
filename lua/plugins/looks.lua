return {
	"xiyaowong/transparent.nvim",
	{
		"askfiy/visual_studio_code",
		priority = 100,
		config = function()
			vim.cmd([[colorscheme visual_studio_code]])

			-- Apply our custom highlights right after the colorscheme loads
			require("config.highlights")
		end,
	},
}
