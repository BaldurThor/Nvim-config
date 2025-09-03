return {
	"askfiy/visual_studio_code",
	priority = 100,
	dependencies = { "xiyaowong/transparent.nvim" },
	config = function()
		vim.cmd([[colorscheme visual_studio_code]])
		vim.cmd([[TransparentEnable]])
		require("config.highlights")
	end,
}
