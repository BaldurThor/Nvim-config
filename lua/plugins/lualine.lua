-- lua/plugins/lualine.lua
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				-- This is the key to our solid statusline!
				theme = {
					normal = {
						a = { bg = "#264F78", fg = "#FFFFFF", gui = "bold" },
						b = { bg = "#3C3C3C", fg = "#FFFFFF" },
						c = { bg = "#3C3C3C", fg = "#FFFFFF" },
					},
					inactive = {
						a = { bg = "#3C3C3C", fg = "#B3B3B3" },
						b = { bg = "#3C3C3C", fg = "#B3B3B3" },
						c = { bg = "#3C3C3C", fg = "#B3B3B3" },
					},
				},
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_c = { "filename" },
				lualine_x = { "location" },
			},
		})
	end,
}
